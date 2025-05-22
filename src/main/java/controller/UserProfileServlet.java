package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet("/profile")
public class UserProfileServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/View/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            // Update profile information
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");

            // Verify current password if changing password
            if (newPassword != null && !newPassword.isEmpty()) {
                User verifiedUser = userDAO.verifyUser(currentUser.getEmail(), currentPassword);
                if (verifiedUser == null) {
                    session.setAttribute("error", "Current password is incorrect");
                    response.sendRedirect(request.getContextPath() + "/profile");
                    return;
                }
            }

            // Update user information
            currentUser.setUsername(username);
            currentUser.setEmail(email);
            if (newPassword != null && !newPassword.isEmpty()) {
                currentUser.setPassword(newPassword);
            }

            boolean success = userDAO.updateUser(currentUser);
            if (success) {
                session.setAttribute("user", currentUser);
                session.setAttribute("success", "Profile updated successfully");
            } else {
                session.setAttribute("error", "Failed to update profile");
            }
        }

        response.sendRedirect(request.getContextPath() + "/profile");
    }
} 