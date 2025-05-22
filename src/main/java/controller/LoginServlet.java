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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("[LoginServlet] doGet called");
        request.getRequestDispatcher("/View/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("[LoginServlet] doPost called");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || password == null || 
            email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/View/login.jsp").forward(request, response);
            return;
        }

        // Verify user credentials
        User user = userDAO.verifyUser(email, password);
        if (user != null) {
            // Create session and store user information
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("role", user.getRole());
            System.out.println("[LoginServlet] Logged in user: " + user.getUsername() + ", role: " + user.getRole());
            System.out.println("[LoginServlet] Session user: " + session.getAttribute("user"));
            System.out.println("[LoginServlet] Session role: " + session.getAttribute("role"));

            // Redirect all users to home page
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/View/login.jsp").forward(request, response);
        }
    }
} 