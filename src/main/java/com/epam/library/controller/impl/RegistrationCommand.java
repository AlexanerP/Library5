package com.epam.library.controller.impl;

import com.epam.library.controller.Command;
import com.epam.library.controller.PathFile;
import com.epam.library.entity.User;
import com.epam.library.service.ServiceException;
import com.epam.library.service.ServiceFactory;
import com.epam.library.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RegistrationCommand implements Command {

    private final static Logger logger = LoggerFactory.getLogger(RegistrationCommand.class);

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            logger.info("Start registration.");
            UserService userService = ServiceFactory.getInstance().getUserService();
            HttpSession session = req.getSession();
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String secondName = req.getParameter("second_name");
            String lastName = req.getParameter("last_name");
            if (email != "" && password != "" && secondName != "" && lastName != ""){
                int flagRegistration = userService.create(email, password, secondName, lastName);
                if(flagRegistration == 1) {
                    Optional<User> optionalUser = userService.verification(email, password);
                    User user = new User();
                    user.setUserId(optionalUser.get().getUserId());
                    user.setRole(optionalUser.get().getRole());
                    user.setSecondName(optionalUser.get().getSecondName());
                    user.setLastName(optionalUser.get().getLastName());
                    user.setStatus(optionalUser.get().getStatus());
                    session.setAttribute("user", user);
                    req.getRequestDispatcher(PathFile.INDEX_PAGE).forward(req, resp);
                } else if (flagRegistration == 2){
                    String negativeMessage = "Operation failed";
                    session.setAttribute("negativeMessage", negativeMessage);
                    resp.sendRedirect("Controller?command=GoToMessagePage");
                }else if (flagRegistration == 3) {
                    String negativeMessage = "Operation failed";
                    session.setAttribute("negativeMessage", negativeMessage);
                    resp.sendRedirect("Controller?command=GoToMessagePage");
                }
            } else {
                logger.error("Not all fields are filled.");
                req.getRequestDispatcher(PathFile.REGISTRATION_PAGE).forward(req, resp);
            }
        } catch (ServiceException e) {
            logger.error("An error occured during registration. " + e);
            resp.sendRedirect("error.jsp");
        }
    }
}
