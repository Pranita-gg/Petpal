package controller.admin;

import dao.AdoptionDAO;
import dao.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Adoption;
import model.Pet;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/adoptions")
public class AdoptionManagementServlet extends HttpServlet {
    private AdoptionDAO adoptionDAO;
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        adoptionDAO = new AdoptionDAO();
        petDAO = new PetDAO();
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
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String status = request.getParameter("status");
        List<Adoption> adoptions;
        
        if (status != null && !status.isEmpty()) {
            adoptions = adoptionDAO.getAdoptionsByStatus(status);
        } else {
            adoptions = adoptionDAO.getAllAdoptions();
        }

        request.setAttribute("adoptions", adoptions);
        request.getRequestDispatcher("/WEB-INF/View/admin/adoption-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String adoptionId = request.getParameter("adoptionId");
        String action = request.getParameter("action");

        if (adoptionId == null || action == null) {
            session.setAttribute("error", "Invalid request");
            response.sendRedirect(request.getContextPath() + "/admin/adoptions");
            return;
        }

        Adoption adoption = adoptionDAO.getAdoptionById(Integer.parseInt(adoptionId));
        if (adoption == null) {
            session.setAttribute("error", "Adoption request not found");
            response.sendRedirect(request.getContextPath() + "/admin/adoptions");
            return;
        }

        boolean success = false;
        if ("approve".equals(action)) {
            adoption.setStatus("approved");
            success = adoptionDAO.updateAdoption(adoption);
            
            if (success) {
                // Update pet status to adopted
                Pet pet = petDAO.getPetById(adoption.getPetId());
                if (pet != null) {
                    pet.setStatus("adopted");
                    petDAO.updatePet(pet);
                }
            }
        } else if ("reject".equals(action)) {
            adoption.setStatus("rejected");
            success = adoptionDAO.updateAdoption(adoption);
        }

        if (success) {
            session.setAttribute("success", "Adoption request " + action + "d successfully");
        } else {
            session.setAttribute("error", "Failed to " + action + " adoption request");
        }

        response.sendRedirect(request.getContextPath() + "/admin/adoptions");
    }
} 