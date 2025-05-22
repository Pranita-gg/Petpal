package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pet_rental";
    private static final String USER = "root";
    private static final String PASS = "";

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, USER, PASS);
    }

    public static User verifyUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getString("phone"),
                    rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role"),
                    rs.getString("phone"),
                    rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean updateUser(User user) {
        String sql = "UPDATE users SET username = ?, email = ?, password = ?, role = ?, phone = ?, image_data = ?, image_type = ? WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getPhone());
            stmt.setBytes(6, user.getImageData());
            stmt.setString(7, user.getImageType());
            stmt.setInt(8, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, email, password, role, phone) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getPhone());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static User login(String email, String plainPassword) {
        try {
            String query = "SELECT * FROM users WHERE email=?";
            PreparedStatement pst = getConnection().prepareStatement(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (PasswordUtil.checkPassword(plainPassword, hashedPassword)) {
                    User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role")
                    );
                    user.setImageData(rs.getBytes("image_data"));
                    user.setImageType(rs.getString("image_type"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            String query = "SELECT * FROM users";
            PreparedStatement pst = getConnection().prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
                );
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public static boolean deleteUserById(int userId) {
        try {
            String query = "DELETE FROM users WHERE user_id = ?";
            PreparedStatement pst = getConnection().prepareStatement(query);
            pst.setInt(1, userId);
            return pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int getTotalMembers() throws Exception {
        Connection con = getConnection();
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'user'";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    public static void addUser(String name, String email, String password, String role, byte[] imageData, String imageType) throws Exception {
        Connection con = getConnection();
        String hashedPassword;
        try {
            hashedPassword = PasswordUtil.hashPassword(password);
        } catch (Exception e) {
            throw new Exception("Failed to hash password: " + e.getMessage());
        }
        String sql = "INSERT INTO users (username, email, password, role, image_data, image_type) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, hashedPassword);
        pstmt.setString(4, role);
        pstmt.setBytes(5, imageData);
        pstmt.setString(6, imageType);
        pstmt.executeUpdate();
    }

    public static User getUserById(int id) throws Exception {
        Connection con = getConnection();
        String sql = "SELECT * FROM users WHERE user_id = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            User user = new User(
                rs.getInt("user_id"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("role")
            );
            user.setImageData(rs.getBytes("image_data"));
            user.setImageType(rs.getString("image_type"));
            return user;
        }
        return null;
    }

    public static void updateUserImage(int userId, byte[] imageData, String imageType) {
        String sql = "UPDATE users SET image_data = ?, image_type = ? WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBytes(1, imageData);
            stmt.setString(2, imageType);
            stmt.setInt(3, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void removeUserImage(int userId) {
        String sql = "UPDATE users SET image_data = NULL, image_type = NULL WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 