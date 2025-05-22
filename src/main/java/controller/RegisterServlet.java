package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.User;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/register")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/View/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = getFormField(request, "username");
        String email = getFormField(request, "email");
        String password = getFormField(request, "password");
        String confirmPassword = getFormField(request, "confirmPassword");
        String role = request.getParameter("role");
        Part imagePart = request.getPart("profileImage");

        // Validate input
        if (username == null || email == null || password == null ||
            username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/View/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/View/register.jsp").forward(request, response);
            return;
        }
        if (userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("/WEB-INF/View/register.jsp").forward(request, response);
            return;
        }

        // Handle image upload (store as byte[] in DB)
        byte[] profileImageBytes = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            try (InputStream is = imagePart.getInputStream()) {
                profileImageBytes = is.readAllBytes();
            }
        }

        // Create new user
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(password);
        user.setRole(role);
        user.setImageData(profileImageBytes);

        if (userDAO.createUser(user)) {
            // Registration successful, redirect to login with success message
            HttpSession session = request.getSession();
            session.setAttribute("success", "Registration successful! Please log in.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/View/register.jsp").forward(request, response);
        }
    }

    // Helper to get text field from multipart form
    private String getFormField(HttpServletRequest request, String name) throws IOException, ServletException {
        Part part = request.getPart(name);
        if (part != null) {
            try (InputStream is = part.getInputStream()) {
                return new String(is.readAllBytes(), request.getCharacterEncoding());
            }
        }
        return null;
    }
} 