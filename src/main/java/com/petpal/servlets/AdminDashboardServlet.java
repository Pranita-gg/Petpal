package com.petpal.servlets;

import com.petpal.models.Pet;
import com.petpal.models.User;
import com.petpal.services.PetService;
import com.petpal.services.UserService;
import com.petpal.services.AdoptionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private PetService petService;
    private UserService userService;
    private AdoptionService adoptionService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize services
        petService = new PetService();
        userService = new UserService();
        adoptionService = new AdoptionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        try {
            // Get dashboard statistics
            int totalPets = petService.getTotalPets();
            int totalUsers = userService.getTotalUsers();
            int pendingAdoptions = adoptionService.getPendingAdoptionsCount();
            int completedAdoptions = adoptionService.getCompletedAdoptionsCount();

            // Get recent pets and users
            List<Pet> recentPets = petService.getRecentPets(5); // Get 5 most recent pets
            List<User> recentUsers = userService.getRecentUsers(5); // Get 5 most recent users

            // Set attributes for the JSP
            request.setAttribute("totalPets", totalPets);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("pendingAdoptions", pendingAdoptions);
            request.setAttribute("completedAdoptions", completedAdoptions);
            request.setAttribute("recentPets", recentPets);
            request.setAttribute("recentUsers", recentUsers);

            // Forward to the dashboard JSP
            request.getRequestDispatcher("/admin/admin_dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error
            e.printStackTrace();
            // Set error message
            request.setAttribute("error", "An error occurred while loading the dashboard. Please try again later.");
            request.getRequestDispatcher("/admin/admin_dashboard.jsp").forward(request, response);
        }
    }
} 