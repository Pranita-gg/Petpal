package com.petrental.dao;

import com.petrental.model.Pet;
import com.petrental.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetDAO {
    
    // Add a new pet
    public boolean addPet(Pet pet) {
        String sql = "INSERT INTO pets (name, species, breed, age, description, rental_price, is_available, pet_image, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, pet.getName());
            pstmt.setString(2, pet.getSpecies());
            pstmt.setString(3, pet.getBreed());
            pstmt.setInt(4, pet.getAge());
            pstmt.setString(5, pet.getDescription());
            pstmt.setDouble(6, pet.getRentalPrice());
            pstmt.setBoolean(7, pet.isAvailable());
            pstmt.setBytes(8, pet.getPetImage());
            pstmt.setTimestamp(9, new Timestamp(pet.getCreatedAt().getTime()));
            pstmt.setTimestamp(10, new Timestamp(pet.getUpdatedAt().getTime()));
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get pet by ID
    public Pet getPetById(int id) {
        String sql = "SELECT * FROM pets WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractPetFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Get all pets
    public List<Pet> getAllPets() {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM pets ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                pets.add(extractPetFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }
    
    // Get available pets
    public List<Pet> getAvailablePets() {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM pets WHERE is_available = true ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                pets.add(extractPetFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }
    
    // Update pet
    public boolean updatePet(Pet pet) {
        String sql = "UPDATE pets SET name = ?, species = ?, breed = ?, age = ?, description = ?, " +
                    "rental_price = ?, is_available = ?, pet_image = ?, updated_at = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, pet.getName());
            pstmt.setString(2, pet.getSpecies());
            pstmt.setString(3, pet.getBreed());
            pstmt.setInt(4, pet.getAge());
            pstmt.setString(5, pet.getDescription());
            pstmt.setDouble(6, pet.getRentalPrice());
            pstmt.setBoolean(7, pet.isAvailable());
            pstmt.setBytes(8, pet.getPetImage());
            pstmt.setTimestamp(9, new Timestamp(pet.getUpdatedAt().getTime()));
            pstmt.setInt(10, pet.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete pet
    public boolean deletePet(int id) {
        String sql = "DELETE FROM pets WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to extract Pet object from ResultSet
    private Pet extractPetFromResultSet(ResultSet rs) throws SQLException {
        Pet pet = new Pet();
        pet.setId(rs.getInt("id"));
        pet.setName(rs.getString("name"));
        pet.setSpecies(rs.getString("species"));
        pet.setBreed(rs.getString("breed"));
        pet.setAge(rs.getInt("age"));
        pet.setDescription(rs.getString("description"));
        pet.setRentalPrice(rs.getDouble("rental_price"));
        pet.setAvailable(rs.getBoolean("is_available"));
        pet.setPetImage(rs.getBytes("pet_image"));
        pet.setCreatedAt(rs.getTimestamp("created_at"));
        pet.setUpdatedAt(rs.getTimestamp("updated_at"));
        return pet;
    }
} 