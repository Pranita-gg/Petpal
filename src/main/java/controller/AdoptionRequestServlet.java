package controller;

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
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/adoption/request")
public class AdoptionRequestServlet extends HttpServlet {
    private AdoptionDAO adoptionDAO;
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        adoptionDAO = new AdoptionDAO();
        petDAO = new PetDAO();
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
        String petId = request.getParameter("petId");
        
        if (petId == null || petId.isEmpty()) {
            session.setAttribute("error", "Invalid pet ID");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Pet pet = petDAO.getPetById(Integer.parseInt(petId));
        if (pet == null) {
            session.setAttribute("error", "Pet not found");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        if (!"available".equals(pet.getStatus())) {
            session.setAttribute("error", "This pet is not available for adoption");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Check if user already has a pending request for this pet
        if (adoptionDAO.hasPendingRequest(user.getUserId(), pet.getPetId())) {
            session.setAttribute("error", "You already have a pending request for this pet");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Adoption adoption = new Adoption();
        adoption.setUserId(user.getUserId());
        adoption.setPetId(pet.getPetId());
        adoption.setAdoptionDate(new Timestamp(System.currentTimeMillis()));
        adoption.setStatus("pending");

        boolean success = adoptionDAO.createAdoption(adoption);
        if (success) {
            session.setAttribute("success", "Adoption request submitted successfully");
        } else {
            session.setAttribute("error", "Failed to submit adoption request");
        }

        response.sendRedirect(request.getContextPath() + "/home");
    }
} 