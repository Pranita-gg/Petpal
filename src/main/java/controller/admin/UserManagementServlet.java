package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object userObj = (session != null) ? session.getAttribute("user") : null;
        Object roleObj = (session != null) ? session.getAttribute("role") : null;

        System.out.println("[UserManagementServlet] Session user: " + userObj);
        System.out.println("[UserManagementServlet] Session role: " + roleObj);

        if (userObj == null || roleObj == null || !"admin".equalsIgnoreCase(roleObj.toString())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Show the user management page
        request.getRequestDispatcher("/View/admin/adoption-management.jsp").forward(request, response);
    }
} 