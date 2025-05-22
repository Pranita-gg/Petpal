package model;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class PetDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pet_rental";
    private static final String USER = "root";
    private static final String PASS = "";

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, USER, PASS);
    }

    public Pet getPetById(int petId) {
        String sql = "SELECT * FROM pets WHERE pet_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, petId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("name"));
                pet.setSpecies(rs.getString("species"));
                pet.setBreed(rs.getString("breed"));
                pet.setAge(rs.getInt("age"));
                pet.setPrice(rs.getBigDecimal("price"));
                pet.setStatus(rs.getString("status"));
                pet.setImageData(rs.getBytes("image_data"));
                pet.setImageType(rs.getString("image_type"));
                return pet;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pet> getAllPets() {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM pets ORDER BY name";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setPetId(rs.getInt("pet_id"));
                pet.setName(rs.getString("name"));
                pet.setSpecies(rs.getString("species"));
                pet.setBreed(rs.getString("breed"));
                pet.setAge(rs.getInt("age"));
                pet.setPrice(rs.getBigDecimal("price"));
                pet.setStatus(rs.getString("status"));
                pet.setImageData(rs.getBytes("image_data"));
                pet.setImageType(rs.getString("image_type"));
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }

    public List<Pet> searchPets(String query, String species, String minPrice, String maxPrice, String status) {
        List<Pet> pets = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM pets WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (query != null && !query.isEmpty()) {
            sql.append(" AND (name LIKE ? OR breed LIKE ?)");
            params.add("%" + query + "%");
            params.add("%" + query + "%");
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

        sql.append(" ORDER BY name");

        try (Connection conn = getConnection();
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
                pet.setImageData(rs.getBytes("image_data"));
                pet.setImageType(rs.getString("image_type"));
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }

    public List<Pet> getPetsByStatus(String status) {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM pets WHERE status = ? ORDER BY name";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
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
                pet.setImageData(rs.getBytes("image_data"));
                pet.setImageType(rs.getString("image_type"));
                pets.add(pet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pets;
    }

    public boolean updatePet(Pet pet) {
        String sql = "UPDATE pets SET name = ?, species = ?, breed = ?, age = ?, price = ?, status = ?, image_data = ?, image_type = ? WHERE pet_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, pet.getName());
            stmt.setString(2, pet.getSpecies());
            stmt.setString(3, pet.getBreed());
            stmt.setInt(4, pet.getAge());
            stmt.setBigDecimal(5, pet.getPrice());
            stmt.setString(6, pet.getStatus());
            stmt.setBytes(7, pet.getImageData());
            stmt.setString(8, pet.getImageType());
            stmt.setInt(9, pet.getPetId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePet(int petId) {
        String sql = "DELETE FROM pets WHERE pet_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, petId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 