package com.artgallery.util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserAuthentication {
    public static boolean authenticate(Connection connection, String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, password);
            
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly in a real application
            return false;
        }
    }
    
    public static boolean isAdmin(Connection connection, String username) {
        String query = "SELECT * FROM admin WHERE username = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly in a real application
            return false;
        }
    }

//    public static String getUserRole(Connection connection, String username) {
//        String query = "SELECT role FROM users WHERE username = ?";
//        
//        try (PreparedStatement statement = connection.prepareStatement(query)) {
//            statement.setString(1, username);
//            
//            ResultSet resultSet = statement.executeQuery();
//            if (resultSet.next()) {
//                return resultSet.getString("role");
//            }
//        } catch (SQLException e) {
//            e.printStackTrace(); // Handle exceptions properly in a real application
//        }
//        
//        return ""; // Return an empty string or handle appropriately if no role is found
//    }

    public static boolean isUsernameAvailable(Connection connection, String username) {
        String query = "SELECT * FROM users WHERE username = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            
            ResultSet resultSet = statement.executeQuery();
            return !resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly in a real application
            return false;
        }
    }

    public static boolean authenticateAdmin(Connection connection, String username, String password) {
        String query = "SELECT * FROM admin WHERE username = ? AND password = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, password);
            
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly in a real application
            return false;
        }
    }

    public static void registerUser(Connection connection, String username, String password) throws SQLException {
        String query;
        
        
            query = "INSERT INTO users (username, password) VALUES (?, ?)";
        
        
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly in a real application
        }
    }

    public static int authenticateAndGetUserId(Connection connection, String username, String password) throws SQLException {
        String query = "SELECT user_id FROM users WHERE username = ? AND password = ?";
        int id = 0; // Initialize to a value that won't conflict with actual user IDs
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, password);
            
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                id = resultSet.getInt(1); // Retrieve the user ID directly from index 1
            } else {
                id = 0; // Set to a different value to indicate no valid ID found
            }
        } catch (SQLException e) {
            throw e; // Propagate the exception for handling elsewhere
        }
        
        return id;
    }



}
