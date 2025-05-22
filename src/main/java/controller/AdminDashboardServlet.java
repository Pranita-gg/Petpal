package controller;

import dao.PetDAO;
import dao.UserDAO;
import dao.AdoptionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Pet;
import model.User;
import model.Adoption;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private PetDAO petDAO;
    private UserDAO userDAO;
    private AdoptionDAO adoptionDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
        userDAO = new UserDAO();
        adoptionDAO = new AdoptionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object userObj = (session != null) ? session.getAttribute("user") : null;
        Object roleObj = (session != null) ? session.getAttribute("role") : null;

        System.out.println("[AdminDashboardServlet] Session user: " + userObj);
        System.out.println("[AdminDashboardServlet] Session role: " + roleObj);

        if (userObj == null || roleObj == null || !"admin".equalsIgnoreCase(roleObj.toString())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get statistics
        int totalPets = petDAO.getAllPets().size();
        int availablePets = petDAO.getPetsByStatus("available").size();
        int adoptedPets = petDAO.getPetsByStatus("adopted").size();
        int totalUsers = userDAO.getAllUsers().size();
        int totalAdoptions = adoptionDAO.getAllAdoptions().size();

        // Get recent adoptions
        List<Adoption> recentAdoptions = adoptionDAO.getRecentAdoptions(5);

        // Get pets that need attention (low stock or high demand)
        List<Pet> petsNeedingAttention = petDAO.getPetsNeedingAttention();

        // Set attributes for the JSP
        request.setAttribute("totalPets", totalPets);
        request.setAttribute("availablePets", availablePets);
        request.setAttribute("adoptedPets", adoptedPets);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalAdoptions", totalAdoptions);
        request.setAttribute("recentAdoptions", recentAdoptions);
        request.setAttribute("petsNeedingAttention", petsNeedingAttention);

        request.getRequestDispatcher("/View/admin/dashboard.jsp").forward(request, response);
    }
} 