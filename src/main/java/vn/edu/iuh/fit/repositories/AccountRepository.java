package vn.edu.iuh.fit.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import vn.edu.iuh.fit.db.ConnectionDB;
import vn.edu.iuh.fit.models.Account;

import java.util.List;
import java.util.Optional;

public class AccountRepository {

    private final EntityManagerFactory entityManagerFactory;

    public AccountRepository() {
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
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    public boolean create(Account account) {
        return executeTransaction(entityManager -> {
            entityManager.persist(account);
            return true;
        });
    }

    public boolean update(Account account) {
        return executeTransaction(entityManager -> {
            entityManager.merge(account);
            return true;
        });
    }

    public boolean delete(long id) {
        return executeTransaction(entityManager -> {
            Query query = entityManager.createQuery("UPDATE Account SET status = -1 WHERE id = :accountID");
            query.setParameter("accountID", id);
            int result = query.executeUpdate();
            return result > 0;
        });
    }

    public Optional<Account> getByID(long id) {
        return Optional.ofNullable(executeTransaction(entityManager -> entityManager.find(Account.class, id)));
    }

    public List<Account> getAll() {
        return executeTransaction(entityManager ->
                entityManager.createQuery("SELECT a FROM Account a WHERE a.status = 1", Account.class).getResultList());
    }

    public Optional<Account> checkAccount(String email, String password) {
        return Optional.ofNullable(executeTransaction(entityManager -> {
            Query query = entityManager.createQuery("SELECT a FROM Account a WHERE a.email = :email AND a.password = :password AND a.status = 1");
            query.setParameter("email", email);
            query.setParameter("password", password);
            return (Account) query.getSingleResult();
        }));
    }

    public List<Account> getAccountsByRole(long id) {
        return executeTransaction(entityManager -> {
            Query query = entityManager.createQuery("SELECT a FROM GrantAccess g INNER JOIN Account a INNER JOIN Role r WHERE g.account.id = a.id AND g.role.id = r.id AND g.role.id = :roleID");
            query.setParameter("roleID", id);
            return query.getResultList();
        });
    }

    @FunctionalInterface
    private interface TransactionFunction<T> {
        T apply(EntityManager entityManager);
    }
}
