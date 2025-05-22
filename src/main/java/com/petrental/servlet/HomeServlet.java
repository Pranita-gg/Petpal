package com.petrental.servlet;

import com.petrental.dao.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("")
public class HomeServlet extends HttpServlet {
    private PetDAO petDAO;
    
    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Restrict access: only logged-in users can view home
        if (request.getSession(false) == null || request.getSession(false).getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // Get available pets
        request.setAttribute("pets", petDAO.getAvailablePets());
        
        // Forward to home page
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
} 