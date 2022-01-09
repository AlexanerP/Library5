package com.epam.library.controller.impl;

import com.epam.library.controller.Command;
import com.epam.library.controller.PathJsp;
import com.epam.library.service.LibraryService;
import com.epam.library.service.ServiceException;
import com.epam.library.service.ServiceFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpdateLibraryCommand implements Command {

    private static final Logger logger = LoggerFactory.getLogger(UpdateLibraryCommand.class);

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            LibraryService libraryService = ServiceFactory.getInstance().getLibraryService();
            Integer libraryId = (Integer) req.getSession().getAttribute("updateLibraryId");
            String city = req.getParameter("city");
            String street = req.getParameter("street");
            req.getSession().removeAttribute("updateLibraryId");
            if (libraryId == null) {
                boolean resultOperation = libraryService.update(libraryId + "", city, street);
                if (resultOperation) {
                    String successfulMessage = "Operation successful";
                    req.getSession().setAttribute("successfulMessage", successfulMessage);
                    resp.sendRedirect("Controller?command=GoToMessagePage");
                } else {
                    String negativeMessage = "Operation failed";
                    req.getSession().setAttribute("negativeMessage", negativeMessage);
                    resp.sendRedirect("Controller?command=GoToMessagePage");
                }
            } else {
                req.getRequestDispatcher(PathJsp.LIBRARY_CATALOG_PAGE).forward(req, resp);
            }
        }catch (ServiceException e) {
            logger.error("Error while updating the library.", e);
            resp.sendRedirect(PathJsp.ERROR_PAGE);
        }
    }
}
