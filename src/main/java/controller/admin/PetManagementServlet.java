package controller.admin;

import dao.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Pet;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/pets")
public class PetManagementServlet extends HttpServlet {
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object userObj = (session != null) ? session.getAttribute("user") : null;
        Object roleObj = (session != null) ? session.getAttribute("role") : null;

        System.out.println("[PetManagementServlet] Session user: " + userObj);
        System.out.println("[PetManagementServlet] Session role: " + roleObj);

        if (userObj == null || roleObj == null || !"admin".equalsIgnoreCase(roleObj.toString())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get search parameters
        String searchQuery = request.getParameter("search");
        String status = request.getParameter("status");
        String species = request.getParameter("species");

        // Get pets based on filters
        List<Pet> pets;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            pets = petDAO.searchPets(searchQuery, null, null, null, null);
        } else if (status != null && !status.isEmpty()) {
            pets = petDAO.getPetsByStatus(status);
        } else {
            pets = petDAO.getAllPets();
        }

        // Set attributes for the JSP
        request.setAttribute("pets", pets);
        request.setAttribute("searchTerm", searchQuery);
        request.setAttribute("status", status);
        request.setAttribute("species", species);

        request.getRequestDispatcher("/View/admin/pet-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            int petId = Integer.parseInt(request.getParameter("petId"));
            if (petDAO.deletePet(petId)) {
                request.setAttribute("success", "Pet deleted successfully");
            } else {
                request.setAttribute("error", "Failed to delete pet");
            }
        } else if ("updateStatus".equals(action)) {
            int petId = Integer.parseInt(request.getParameter("petId"));
            String newStatus = request.getParameter("status");
            
            Pet pet = petDAO.getPetById(petId);
            if (pet != null) {
                pet.setStatus(newStatus);
                if (petDAO.updatePet(pet)) {
                    request.setAttribute("success", "Pet status updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update pet status");
                }
            }
        }
        
        doGet(request, response);
    }
} 