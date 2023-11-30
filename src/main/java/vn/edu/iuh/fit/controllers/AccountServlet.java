package vn.edu.iuh.fit.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.iuh.fit.models.Account;
import vn.edu.iuh.fit.models.Role;
import vn.edu.iuh.fit.repositories.AccountRepository;
import vn.edu.iuh.fit.repositories.RoleRepository;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {
    private AccountRepository accountRepository = new AccountRepository();
    private RoleRepository roleRepository = new RoleRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String btnSubmitFeature = req.getParameter("btnSubmitFeature");
        List<Account> accounts;

        switch (btnSubmitFeature) {
            case "Filter":
                handleFilter(req);
                break;
            case "Thêm":
                handleAdd(req);
                break;
            case "Cập Nhật":
                handleUpdate(req);
                break;
            case "XÓA":
                handleDelete(req);
                break;
            default:
                handleEdit(req, btnSubmitFeature);
                break;
        }

        accounts = accountRepository.getAll();
        List<Role> roles = roleRepository.getAll();
        req.setAttribute("accounts", accounts);
        req.setAttribute("roles", roles);
        req.getRequestDispatcher("managerAccount.jsp").forward(req, resp);
    }

    private void handleFilter(HttpServletRequest req) {
        long filter = Long.parseLong(req.getParameter("filter"));
        List<Account> accounts = (filter != 0) ? accountRepository.getAccountsByRole(filter) : accountRepository.getAll();
        req.setAttribute("accounts", accounts);
    }

    private void handleAdd(HttpServletRequest req) {
        Account newAccount = createAccountFromRequest(req);
        if (accountRepository.create(newAccount)) {

        }
    }

    private void handleUpdate(HttpServletRequest req) {
        Account account = getAccountById(req);
        if (account != null) {
            updateAccountInfo(req, account);
            if (accountRepository.update(account)) {

            }
        }
    }

    private void handleDelete(HttpServletRequest req) {
        long accountId = Long.parseLong(req.getParameter("accountID"));
        if (accountRepository.delete(accountId)) {

        }
    }

    private void handleEdit(HttpServletRequest req, String btnSubmitFeature) {
        Account account = getAccountById(req);
        if (account != null) {
            req.setAttribute("account", account);
            req.setAttribute("btnSubmit", "Cập Nhật");
        }
    }

    private Account createAccountFromRequest(HttpServletRequest req) {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        int status = Integer.parseInt(req.getParameter("status"));

        return new Account(fullName, email, password, phone, status);
    }

    private Account getAccountById(HttpServletRequest req) {
        Optional<Account> account = accountRepository.getByID(Long.parseLong(req.getParameter("accountID")));
        return account.orElse(null);
    }

    private void updateAccountInfo(HttpServletRequest req, Account account) {
        account.setFullName(req.getParameter("fullName"));
        account.setEmail(req.getParameter("email"));
        account.setPassword(req.getParameter("password"));
        account.setPhone(req.getParameter("phone"));
        account.setStatus(Integer.parseInt(req.getParameter("status")));
    }
}
