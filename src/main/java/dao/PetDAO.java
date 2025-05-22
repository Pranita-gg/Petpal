package dao;

import model.Pet;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class PetDAO {
    
    // Create a new pet
    public boolean createPet(Pet pet) {
        String sql = "INSERT INTO pets (user_id, name, species, breed, age, price, description, pet_image, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, pet.getUserId());
            pstmt.setString(2, pet.getName());
            pstmt.setString(3, pet.getSpecies());
            pstmt.setString(4, pet.getBreed());
            pstmt.setInt(5, pet.getAge());
            pstmt.setBigDecimal(6, pet.getPrice());
            pstmt.setString(7, pet.getDescription());
            pstmt.setString(8, pet.getPetImage());
            pstmt.setString(9, pet.getStatus());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating pet: " + e.getMessage());
            return false;
        }
    }
    
    // Get pet by ID
    public Pet getPetById(int petId) {
        String sql = "SELECT * FROM pets WHERE pet_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, petId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractPetFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting pet by ID: " + e.getMessage());
        }
        return null;
    }
    
    // Update pet
    public boolean updatePet(Pet pet) {
        String sql = "UPDATE pets SET name = ?, species = ?, breed = ?, age = ?, " +
                    "price = ?, description = ?, pet_image = ?, status = ? WHERE pet_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, pet.getName());
            pstmt.setString(2, pet.getSpecies());
            pstmt.setString(3, pet.getBreed());
            pstmt.setInt(4, pet.getAge());
            pstmt.setBigDecimal(5, pet.getPrice());
            pstmt.setString(6, pet.getDescription());
            pstmt.setString(7, pet.getPetImage());
            pstmt.setString(8, pet.getStatus());
            pstmt.setInt(9, pet.getPetId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating pet: " + e.getMessage());
            return false;
        }
    }
    
    // Delete pet
    public boolean deletePet(int petId) {
        String sql = "DELETE FROM pets WHERE pet_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, petId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting pet: " + e.getMessage());
            return false;
        }
    }
    
    // Get all pets
    public List<Pet> getAllPets() {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM pets";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                pets.add(extractPetFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all pets: " + e.getMessage());
        }
        return pets;
    }
    
    // Get pets by user ID
    public List<Pet> getPetsByUserId(int userId) {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM pets WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                pets.add(extractPetFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting pets by user ID: " + e.getMessage());
        }
        return pets;
    }
    
    // Search pets by description
    public List<Pet> searchPets(String query, String species, String minPrice, String maxPrice, String status) {
        List<Pet> pets = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM pets WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (query != null && !query.isEmpty()) {
            sql.append(" AND (name LIKE ? OR breed LIKE ? OR description LIKE ?)");
            String searchPattern = "%" + query + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        if (species != null && !species.isEmpty()) {
            sql.append(" AND species = ?");
            params.add(species);
        }

        if (minPrice != null && !minPrice.isEmpty()) {
            sql.append(" AND price >= ?");
            params.add(new BigDecimal(minPrice));
        }

        if (maxPrice != null && !maxPrice.isEmpty()) {
            sql.append(" AND price <= ?");
            params.add(new BigDecimal(maxPrice));
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("name"));
                pet.setSpecies(rs.getString("species"));
                pet.setBreed(rs.getString("breed"));
                pet.setAge(rs.getInt("age"));
                pet.setPrice(rs.getBigDecimal("price"));
                pet.setStatus(rs.getString("status"));
                pet.setPetImage(rs.getString("pet_image"));
                pet.setDescription(rs.getString("description"));
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }
    
    // Helper method to extract pet from ResultSet
    private Pet extractPetFromResultSet(ResultSet rs) throws SQLException {
        Pet pet = new Pet();
        pet.setPetId(rs.getInt("pet_id"));
        pet.setUserId(rs.getInt("user_id"));
        pet.setName(rs.getString("name"));
        pet.setSpecies(rs.getString("species"));
        pet.setBreed(rs.getString("breed"));
        pet.setAge(rs.getInt("age"));
        pet.setPrice(rs.getBigDecimal("price"));
        pet.setDescription(rs.getString("description"));
        pet.setPetImage(rs.getString("pet_image"));
        pet.setStatus(rs.getString("status"));
        pet.setCreatedAt(rs.getTimestamp("created_at"));
        return pet;
    }

    public List<Pet> getPetsByStatus(String status) {
        List<Pet> pets = new ArrayList<>();
        String query = "SELECT * FROM pets WHERE status = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("name"));
                pet.setSpecies(rs.getString("species"));
                pet.setBreed(rs.getString("breed"));
                pet.setAge(rs.getInt("age"));
                pet.setDescription(rs.getString("description"));
                pet.setPrice(rs.getBigDecimal("price"));
                pet.setStatus(rs.getString("status"));
                pet.setPetImage(rs.getString("pet_image"));
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }

    public List<Pet> getPetsNeedingAttention() {
        List<Pet> pets = new ArrayList<>();
        String query = "SELECT * FROM pets WHERE status = 'available' AND " +
                      "(age > 5 OR price < 100) ORDER BY age DESC, price ASC LIMIT 5";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("name"));
                pet.setSpecies(rs.getString("species"));
                pet.setBreed(rs.getString("breed"));
                pet.setAge(rs.getInt("age"));
                pet.setDescription(rs.getString("description"));
                pet.setPrice(rs.getBigDecimal("price"));
                pet.setStatus(rs.getString("status"));
                pet.setPetImage(rs.getString("pet_image"));
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }
} 