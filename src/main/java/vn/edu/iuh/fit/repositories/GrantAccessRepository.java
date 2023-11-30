package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import vn.edu.iuh.fit.db.ConnectionDB;
import vn.edu.iuh.fit.models.GrantAccess;

import java.util.List;
import java.util.Optional;

public class GrantAccessRepository {

    private final EntityManagerFactory entityManagerFactory;

    public GrantAccessRepository() {
        entityManagerFactory = ConnectionDB.getInstance().getEntityManagerFactory();
    }

    private <T> T executeTransaction(TransactionFunction<T> transactionFunction) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
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

    public boolean create(GrantAccess grantAccess) {
        return executeTransaction(entityManager -> {
            entityManager.persist(grantAccess);
            return true;
        });
    }

    public boolean update(GrantAccess grantAccess) {
        return executeTransaction(entityManager -> {
            entityManager.merge(grantAccess);
            return true;
        });
    }

    public boolean delete(long id) {
        return executeTransaction(entityManager -> {
            GrantAccess grantAccess = entityManager.find(GrantAccess.class, id);
            entityManager.remove(grantAccess);
            return true;
        });
    }

    public Optional<GrantAccess> getByID(long id) {
        return Optional.ofNullable(executeTransaction(entityManager -> entityManager.find(GrantAccess.class, id)));
    }

    public List<GrantAccess> getAll() {
        return executeTransaction(entityManager ->
                entityManager.createQuery("SELECT ga FROM GrantAccess ga", GrantAccess.class).getResultList());
    }

    @FunctionalInterface
    private interface TransactionFunction<T> {
        T apply(EntityManager entityManager);
    }
}
