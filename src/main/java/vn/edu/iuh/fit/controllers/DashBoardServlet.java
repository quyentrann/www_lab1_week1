package vn.edu.iuh.fit.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.iuh.fit.models.Account;
import vn.edu.iuh.fit.models.GrantAccess;
import vn.edu.iuh.fit.models.Log;
import vn.edu.iuh.fit.models.Role;
import vn.edu.iuh.fit.repositories.AccountRepository;
import vn.edu.iuh.fit.repositories.GrantAccessRepository;
import vn.edu.iuh.fit.repositories.LogRepository;
import vn.edu.iuh.fit.repositories.RoleRepository;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@WebServlet("/dashboard")
public class DashBoardServlet extends HttpServlet {
    private final AccountRepository accountRepository = new AccountRepository();
    private final RoleRepository roleRepository = new RoleRepository();
    private final GrantAccessRepository grantAccessRepository = new GrantAccessRepository();
    private final LogRepository logRepository = new LogRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String btnSubmit = req.getParameter("btnSubmit");

        switch (btnSubmit) {
            case "Đăng Xuất":
                handleLogout(req);
                break;
            case "ACCOUNT":
                handleAccountManagement(req);
                break;
            case "ROLE":
                handleRoleManagement(req);
                break;
            case "GRANT-ACCESS":
                handleGrantAccessManagement(req);
                break;
            case "LOG":
                // Handle LOG if needed
                break;
        }
    }

    private void handleLogout(HttpServletRequest req) throws ServletException, IOException {
        Optional<Log> log = logRepository.getLogByAccount(Long.parseLong(req.getParameter("accountID")));
        log.ifPresent(l -> {
            l.setLogOut(LocalDateTime.now());
            logRepository.update(l);
        });
//        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    private void handleAccountManagement(HttpServletRequest req) throws ServletException, IOException {
        List<Account> accounts = accountRepository.getAll();
        List<Role> roles = roleRepository.getAll();
        Account account = new Account("", "", "", "", 1);
        req.setAttribute("btnSubmit", "Thêm");
        req.setAttribute("account", account);
        req.setAttribute("accounts", accounts);
        req.setAttribute("roles", roles);
//        req.getRequestDispatcher("managerAccount.jsp").forward(req, resp);
    }

    private void handleRoleManagement(HttpServletRequest req) throws ServletException, IOException {
        List<Role> roles = roleRepository.getAll();
        Role roleChosen = new Role("", "", 1);
        req.setAttribute("btnSubmit", "Thêm");
        req.setAttribute("role", roleChosen);
        req.setAttribute("roles", roles);
//        req.getRequestDispatcher("managerRole.jsp").forward(req,resp);
    }

    private void handleGrantAccessManagement(HttpServletRequest req) throws ServletException, IOException {
        List<Account> accounts = accountRepository.getAll();
        List<Role> roles = roleRepository.getAll();
        GrantAccess grChosen = new GrantAccess(accounts.get(0), roles.get(0), 1, "");
        req.setAttribute("btnSubmit", "Thêm");
        req.setAttribute("grant", grChosen);
        req.setAttribute("accounts", accounts);
        req.setAttribute("roles", roles);
//        req.getRequestDispatcher("managerGrantAccess.jsp").forward(req, resp);
    }
}
