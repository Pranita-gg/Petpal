package com.petrental.servlet;

import com.petrental.dao.PetDAO;
import com.petrental.model.Pet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/petImage")
public class PetImageServlet extends HttpServlet {
    private PetDAO petDAO;
    
    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String petId = request.getParameter("id");
        if (petId == null || petId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Pet ID is required");
            return;
        }
        
        try {
            int id = Integer.parseInt(petId);
            Pet pet = petDAO.getPetById(id);
            
            if (pet == null || pet.getPetImage() == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Pet or image not found");
                return;
            }
            
            // Set content type
            response.setContentType("image/jpeg");
            response.setContentLength(pet.getPetImage().length);
            
            // Write image data to response
            response.getOutputStream().write(pet.getPetImage());
            response.getOutputStream().flush();
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Pet ID format");
        }
    }
} 