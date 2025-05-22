package dao;

import model.Adoption;
import model.Pet;
import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdoptionDAO {
    
    // Create a new adoption
    public boolean createAdoption(Adoption adoption) {
        String sql = "INSERT INTO adoptions (pet_id, user_id, payment_status, payment_amount) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, adoption.getPetId());
            pstmt.setInt(2, adoption.getUserId());
            pstmt.setString(3, adoption.getPaymentStatus());
            pstmt.setBigDecimal(4, adoption.getPaymentAmount());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating adoption: " + e.getMessage());
            return false;
        }
    }
    
    // Get adoption by ID
    public Adoption getAdoptionById(int adoptionId) {
        String sql = "SELECT * FROM adoptions WHERE adoption_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, adoptionId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractAdoptionFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting adoption by ID: " + e.getMessage());
        }
        return null;
    }
    
    // Update adoption
    public boolean updateAdoption(Adoption adoption) {
        String sql = "UPDATE adoptions SET payment_status = ?, payment_amount = ? WHERE adoption_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, adoption.getPaymentStatus());
            pstmt.setBigDecimal(2, adoption.getPaymentAmount());
            pstmt.setInt(3, adoption.getAdoptionId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating adoption: " + e.getMessage());
            return false;
        }
    }
    
    // Delete adoption
    public boolean deleteAdoption(int adoptionId) {
        String sql = "DELETE FROM adoptions WHERE adoption_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, adoptionId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting adoption: " + e.getMessage());
            return false;
        }
    }
    
    // Get all adoptions
    public List<Adoption> getAllAdoptions() {
        List<Adoption> adoptions = new ArrayList<>();
        String sql = "SELECT * FROM adoptions";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                adoptions.add(extractAdoptionFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all adoptions: " + e.getMessage());
        }
        return adoptions;
    }
    
    // Get adoptions by user ID
    public List<Adoption> getAdoptionsByUserId(int userId) {
        List<Adoption> adoptions = new ArrayList<>();
        String sql = "SELECT * FROM adoptions WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                adoptions.add(extractAdoptionFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting adoptions by user ID: " + e.getMessage());
        }
        return adoptions;
    }
    
    // Get adoptions by pet ID
    public List<Adoption> getAdoptionsByPetId(int petId) {
        List<Adoption> adoptions = new ArrayList<>();
        String sql = "SELECT * FROM adoptions WHERE pet_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, petId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                adoptions.add(extractAdoptionFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting adoptions by pet ID: " + e.getMessage());
        }
        return adoptions;
    }
    
    // Get recent adoptions
    public List<Adoption> getRecentAdoptions(int limit) {
        List<Adoption> adoptions = new ArrayList<>();
        String query = "SELECT a.*, p.name as pet_name, p.species, p.breed, " +
                      "u.username as adopter_name " +
                      "FROM adoptions a " +
                      "JOIN pets p ON a.pet_id = p.pet_id " +
                      "JOIN users u ON a.user_id = u.user_id " +
                      "ORDER BY a.adoption_date DESC LIMIT ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Adoption adoption = new Adoption();
                adoption.setAdoptionId(rs.getInt("adoption_id"));
                
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setSpecies(rs.getString("species"));
                pet.setBreed(rs.getString("breed"));
                adoption.setPet(pet);
                
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("adopter_name"));
                adoption.setUser(user);
                
                adoption.setAdoptionDate(rs.getTimestamp("adoption_date"));
                adoption.setStatus(rs.getString("status"));
                adoptions.add(adoption);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return adoptions;
    }
    
    // Helper method to extract adoption from ResultSet
    private Adoption extractAdoptionFromResultSet(ResultSet rs) throws SQLException {
        Adoption adoption = new Adoption();
        adoption.setAdoptionId(rs.getInt("adoption_id"));
        adoption.setPetId(rs.getInt("pet_id"));
        adoption.setUserId(rs.getInt("user_id"));
        adoption.setAdoptionDate(rs.getTimestamp("adoption_date"));
        adoption.setPaymentStatus(rs.getString("payment_status"));
        adoption.setPaymentAmount(rs.getBigDecimal("payment_amount"));
        return adoption;
    }

    public boolean hasPendingRequest(int userId, int petId) {
        String sql = "SELECT COUNT(*) FROM adoptions WHERE user_id = ? AND pet_id = ? AND status = 'pending'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, petId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Adoption> getAdoptionsByStatus(String status) {
        List<Adoption> adoptions = new ArrayList<>();
        String sql = "SELECT a.*, u.username, p.name as pet_name FROM adoptions a " +
                    "JOIN users u ON a.user_id = u.user_id " +
                    "JOIN pets p ON a.pet_id = p.pet_id " +
                    "WHERE a.status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Adoption adoption = new Adoption();
                adoption.setAdoptionId(rs.getInt("adoption_id"));
                adoption.setUserId(rs.getInt("user_id"));
                adoption.setPetId(rs.getInt("pet_id"));
                adoption.setAdoptionDate(rs.getTimestamp("adoption_date"));
                adoption.setStatus(rs.getString("status"));
                adoption.setUser(new User());
                adoption.getUser().setUsername(rs.getString("username"));
                adoption.setPet(new Pet());
                adoption.getPet().setName(rs.getString("pet_name"));
                adoptions.add(adoption);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return adoptions;
    }
} 