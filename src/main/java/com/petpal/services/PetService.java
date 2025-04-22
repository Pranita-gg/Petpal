package com.petpal.services;

import com.petpal.models.Pet;
import com.petpal.database.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetService {
    private final DatabaseConnection dbConnection;

    public PetService() {
        this.dbConnection = new DatabaseConnection();
    }

    public int getTotalPets() {
        String query = "SELECT COUNT(*) FROM pets";
        try (Connection conn = dbConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Pet> getRecentPets(int limit) {
        List<Pet> pets = new ArrayList<>();
        String query = "SELECT * FROM pets ORDER BY created_at DESC LIMIT ?";
        
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Pet pet = new Pet();
                    pet.setId(rs.getInt("id"));
                    pet.setName(rs.getString("name"));
                    pet.setType(rs.getString("type"));
                    pet.setBreed(rs.getString("breed"));
                    pet.setStatus(rs.getString("status"));
                    pet.setImageUrl(rs.getString("image_url"));
                    pets.add(pet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }

    public Pet getPetById(int id) {
        String query = "SELECT * FROM pets WHERE id = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Pet pet = new Pet();
                    pet.setId(rs.getInt("id"));
                    pet.setName(rs.getString("name"));
                    pet.setType(rs.getString("type"));
                    pet.setBreed(rs.getString("breed"));
                    pet.setStatus(rs.getString("status"));
                    pet.setImageUrl(rs.getString("image_url"));
                    return pet;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addPet(Pet pet) {
        String query = "INSERT INTO pets (name, type, breed, status, image_url) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, pet.getName());
            pstmt.setString(2, pet.getType());
            pstmt.setString(3, pet.getBreed());
            pstmt.setString(4, pet.getStatus());
            pstmt.setString(5, pet.getImageUrl());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePet(Pet pet) {
        String query = "UPDATE pets SET name = ?, type = ?, breed = ?, status = ?, image_url = ? WHERE id = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, pet.getName());
            pstmt.setString(2, pet.getType());
            pstmt.setString(3, pet.getBreed());
            pstmt.setString(4, pet.getStatus());
            pstmt.setString(5, pet.getImageUrl());
            pstmt.setInt(6, pet.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePet(int id) {
        String query = "DELETE FROM pets WHERE id = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
} 