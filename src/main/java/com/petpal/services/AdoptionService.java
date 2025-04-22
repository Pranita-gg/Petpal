package com.petpal.services;

import com.petpal.database.DatabaseConnection;

import java.sql.*;

public class AdoptionService {
    private final DatabaseConnection dbConnection;

    public AdoptionService() {
        this.dbConnection = new DatabaseConnection();
    }

    public int getPendingAdoptionsCount() {
        String query = "SELECT COUNT(*) FROM adoptions WHERE status = 'pending'";
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

    public int getCompletedAdoptionsCount() {
        String query = "SELECT COUNT(*) FROM adoptions WHERE status = 'completed'";
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

    public boolean updateAdoptionStatus(int adoptionId, String status) {
        String query = "UPDATE adoptions SET status = ? WHERE id = ?";
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, adoptionId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
} 