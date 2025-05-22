package controller.admin;

import dao.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Pet;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/admin/pet/edit")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class PetEditServlet extends HttpServlet {
    private PetDAO petDAO;
    private static final String UPLOAD_DIRECTORY = "uploads/pets";

    @Override
    public void init() throws ServletException {
        petDAO = new PetDAO();
        // Create upload directory if it doesn't exist
        try {
            Path uploadPath = Paths.get(getServletContext().getRealPath("/") + UPLOAD_DIRECTORY);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
        } catch (IOException e) {
            throw new ServletException("Could not create upload directory", e);
        }
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

        String petId = request.getParameter("id");
        if (petId != null && !petId.isEmpty()) {
            Pet pet = petDAO.getPetById(Integer.parseInt(petId));
            if (pet != null) {
                request.setAttribute("pet", pet);
            }
        }

        request.getRequestDispatcher("/WEB-INF/View/admin/pet-edit.jsp").forward(request, response);
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

        // Get form data
        String petId = request.getParameter("petId");
        String name = request.getParameter("name");
        String species = request.getParameter("species");
        String breed = request.getParameter("breed");
        int age = Integer.parseInt(request.getParameter("age"));
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // Handle file upload
        String petImage = null;
        Part filePart = request.getPart("petImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
            String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
            filePart.write(uploadPath + "/" + fileName);
            petImage = UPLOAD_DIRECTORY + "/" + fileName;
        }

        Pet pet = new Pet();
        if (petId != null && !petId.isEmpty()) {
            pet = petDAO.getPetById(Integer.parseInt(petId));
            if (pet == null) {
                request.setAttribute("error", "Pet not found");
                doGet(request, response);
                return;
            }
        }

        pet.setName(name);
        pet.setSpecies(species);
        pet.setBreed(breed);
        pet.setAge(age);
        pet.setPrice(price);
        pet.setDescription(description);
        pet.setStatus(status);
        if (petImage != null) {
            pet.setPetImage(petImage);
        }

        boolean success;
        if (petId != null && !petId.isEmpty()) {
            success = petDAO.updatePet(pet);
            request.setAttribute("success", "Pet updated successfully");
        } else {
            pet.setUserId(user.getUserId());
            success = petDAO.createPet(pet);
            request.setAttribute("success", "Pet created successfully");
        }

        if (!success) {
            request.setAttribute("error", "Failed to save pet");
        }

        response.sendRedirect(request.getContextPath() + "/admin/pets");
    }

    private String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        return submittedFileName.substring(submittedFileName.lastIndexOf("."));
    }
} 