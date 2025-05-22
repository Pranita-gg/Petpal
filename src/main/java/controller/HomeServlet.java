package controller;

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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
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

        // Get search parameter if any
        String searchQuery = request.getParameter("search");
        List<Pet> pets;
        
        if (searchQuery != null && !searchQuery.isEmpty()) {
            pets = petDAO.searchPets(searchQuery, null, null, null, null);
        } else {
            pets = petDAO.getAllPets();
        }

        request.setAttribute("pets", pets);
        request.getRequestDispatcher("/WEB-INF/View/home.jsp").forward(request, response);
    }
}