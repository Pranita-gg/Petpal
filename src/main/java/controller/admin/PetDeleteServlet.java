package controller.admin;

import dao.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet("/admin/pet/delete")
public class PetDeleteServlet extends HttpServlet {
    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
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
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String petId = request.getParameter("petId");
        if (petId != null && !petId.isEmpty()) {
            boolean success = petDAO.deletePet(Integer.parseInt(petId));
            if (success) {
                session.setAttribute("success", "Pet deleted successfully");
            } else {
                session.setAttribute("error", "Failed to delete pet");
            }
        } else {
            session.setAttribute("error", "Invalid pet ID");
        }

        response.sendRedirect(request.getContextPath() + "/admin/pets");
    }
} 