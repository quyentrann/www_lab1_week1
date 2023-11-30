package vn.edu.iuh.fit.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.iuh.fit.models.Role;
import vn.edu.iuh.fit.repositories.RoleRepository;

import java.io.IOException;
import java.util.List;

@WebServlet("/role")
public class RoleServlet extends HttpServlet {
    private final RoleRepository roleRepository = new RoleRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Role> roles = roleRepository.getAll();
        String btnSubmitFeature = req.getParameter("btnSubmitFeature");
        Role roleChosen = new Role("", "", 1);
        String btnSubmit = "Thêm";

        switch (btnSubmitFeature) {
            case "Thêm":
                handleAddRole(req);
                break;
            case "selectRow":
                btnSubmit = "Cập Nhật";
                String roleID = req.getParameter("roleID");
                roleChosen = roleRepository.getByID(Long.parseLong(roleID)).orElse(new Role("", "", 1));
                break;
            case "Cập Nhật":
                handleUpdateRole(req);
                break;
            case "XÓA":
                handleDeleteRole(req);
                break;
        }

        req.setAttribute("role", roleChosen);
        req.setAttribute("roles", roles);
        req.setAttribute("btnSubmit", btnSubmit);
        req.getRequestDispatcher("managerRole.jsp").forward(req, resp);
    }

    private void handleAddRole(HttpServletRequest req) {
        String roleName = req.getParameter("roleName");
        String description = req.getParameter("description");
        int status = Integer.parseInt(req.getParameter("selectStatus"));

        Role role = new Role(roleName, description, status);
        boolean result = roleRepository.create(role);
        if (result) {
            // Update the list of roles
            List<Role> roles = roleRepository.getAll();
        }
    }

    private void handleUpdateRole(HttpServletRequest req) {
        String roleName = req.getParameter("roleName");
        String description = req.getParameter("description");
        int status = Integer.parseInt(req.getParameter("selectStatus"));

        long roleId = Long.parseLong(req.getParameter("roleID"));
        Role roleToUpdate = roleRepository.getByID(roleId).orElse(new Role("", "", 1));
        roleToUpdate.setName(roleName);
        roleToUpdate.setDescription(description);
        roleToUpdate.setStatus(status);

        boolean result = roleRepository.update(roleToUpdate);
        if (result) {
            // Update the list of roles
            List<Role> roles = roleRepository.getAll();
        }
    }

    private void handleDeleteRole(HttpServletRequest req) {
        long roleId = Long.parseLong(req.getParameter("roleID"));
        boolean result = roleRepository.delete(roleId);
        if (result) {
            // Update the list of roles
            List<Role> roles = roleRepository.getAll();
        }
    }
}
