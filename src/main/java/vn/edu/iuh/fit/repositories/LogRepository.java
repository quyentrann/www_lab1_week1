package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import vn.edu.iuh.fit.db.ConnectionDB;
import vn.edu.iuh.fit.models.Log;

import java.util.List;
import java.util.Optional;

public class LogRepository {

    private final EntityManagerFactory entityManagerFactory;

    public LogRepository() {
        entityManagerFactory = ConnectionDB.getInstance().getEntityManagerFactory();
    }

    private <T> T executeTransaction(TransactionFunction<T> transactionFunction) {
        EntityManager entityManager = entityManagerFactory.createEntityManager() ;
            EntityTransaction transaction = entityManager.getTransaction();

            try {
                transaction.begin();
                T result = transactionFunction.apply(entityManager);
                transaction.commit();
                return result;
            } catch (Exception e) {
                e.printStackTrace();
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                return null;
            }

    }

    public boolean create(Log log) {
        return executeTransaction(entityManager -> {
            entityManager.persist(log);
            return true;
        });
    }

    public boolean update(Log log) {
        return executeTransaction(entityManager -> {
            entityManager.merge(log);
            return true;
        });
    }

    public boolean delete(long id) {
        return executeTransaction(entityManager -> {
            entityManager.remove(entityManager.find(Log.class, id));
            return true;
        });
    }

    public Log getByID(long id) {
        return executeTransaction(entityManager -> entityManager.find(Log.class, id));
    }

    public List<Log> getAll() {
        return executeTransaction(entityManager ->
                entityManager.createQuery("SELECT l FROM Log l", Log.class).getResultList());
    }

    public Optional<Log> getLogByAccount(long id) {
        return Optional.ofNullable(executeTransaction(entityManager -> {
            Query query = entityManager.createQuery("SELECT l FROM Log l WHERE l.account.id = :accountID AND l.logOut IS NULL ORDER BY l.id DESC");
            query.setParameter("accountID", id);
            return (Log) query.getResultList().stream().findFirst().orElse(null);
        }));
    }

    @FunctionalInterface
    private interface TransactionFunction<T> {
        T apply(EntityManager entityManager);
    }
}
