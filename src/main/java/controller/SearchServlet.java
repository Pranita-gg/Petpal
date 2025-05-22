package controller;

import dao.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Pet;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String query = request.getParameter("query");
        String species = request.getParameter("species");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String status = request.getParameter("status");

        List<Pet> pets = petDAO.searchPets(query, species, minPrice, maxPrice, status);
        request.setAttribute("pets", pets);
        request.setAttribute("query", query);
        request.setAttribute("species", species);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("status", status);

        request.getRequestDispatcher("/WEB-INF/View/search-results.jsp").forward(request, response);
    }
} 