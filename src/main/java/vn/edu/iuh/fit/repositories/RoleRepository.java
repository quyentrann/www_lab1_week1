package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import vn.edu.iuh.fit.db.ConnectionDB;
import vn.edu.iuh.fit.models.Role;

import java.util.List;
import java.util.Optional;

public class RoleRepository {

    private final EntityManagerFactory entityManagerFactory;

    public RoleRepository() {
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

    public boolean create(Role role) {
        return executeTransaction(entityManager -> {
            entityManager.persist(role);
            return true;
        });
    }

    public boolean update(Role role) {
        return executeTransaction(entityManager -> {
            entityManager.merge(role);
            return true;
        });
    }

    public boolean delete(long id) {
        return executeTransaction(entityManager -> {
            Query query = entityManager.createQuery("UPDATE Role SET status = -1 WHERE id = :roleID");
            query.setParameter("roleID", id);
            int rs = query.executeUpdate();
            return rs > 0;
        });
    }

    public Optional<Role> getByID(long id) {
        return Optional.ofNullable(executeTransaction(entityManager -> entityManager.find(Role.class, id)));
    }

    public List<Role> getAll() {
        return executeTransaction(entityManager ->
                entityManager.createQuery("SELECT r FROM Role r WHERE r.status = 1", Role.class).getResultList());
    }

    public List<Role> getRolesByAccount(long id) {
        return executeTransaction(entityManager -> {
            Query query = entityManager.createQuery("SELECT r FROM GrantAccess g INNER JOIN Account a INNER JOIN Role r WHERE g.account.id = a.id AND g.role.id = r.id AND g.account.id = :accountID");
            query.setParameter("accountID", id);
            return query.getResultList();
        });
    }

    @FunctionalInterface
    private interface TransactionFunction<T> {
        T apply(EntityManager entityManager);
    }
}
