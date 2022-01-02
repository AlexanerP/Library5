package com.epam.library.controller.impl;

import com.epam.library.controller.Command;
import com.epam.library.controller.PathFile;
import com.epam.library.entity.User;
import com.epam.library.entity.UserRole;
import com.epam.library.service.ServiceException;
import com.epam.library.service.ServiceFactory;
import com.epam.library.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AdminCatalogPage implements Command {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            UserService userService = ServiceFactory.getInstance().getUserService();
            String userIdFind = req.getParameter("userIdFind");
            String email = req.getParameter("email");
            String admins = req.getParameter("allAdmins");
            List<User> users = new ArrayList<>();
            if (userIdFind != null && userIdFind != "") {
               users.add(userService.showUserById("userIdFind").get());
            } else if (email != null && email != "") {
                users.addAll(userService.showUserByEmail(email));
            } else if (admins != null && admins != "") {
                users.addAll(userService.showUserByRole(UserRole.ADMIN.name()));
                users.addAll(userService.showUserByRole(UserRole.MANAGER.name()));
            }
            req.setAttribute("users", users);
//resp.sendRedirect(PathFile.MANAGER_CATALOG_PAGE);
            req.getRequestDispatcher(PathFile.MANAGER_CATALOG_PAGE).forward(req, resp);
        }catch (ServiceException e) {

        }
    }
}