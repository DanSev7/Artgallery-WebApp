package com.artgallery.services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.artgallery.util.DBUtil;

public class AdminService {
    public static List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection()) {
            Statement statement = connection.createStatement();
            String sql = "SELECT * FROM admin"; // Adjust SQL query as needed

            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                Admin admin = new Admin();
                admin.setId(resultSet.getInt("id")); // Assuming 'id' is an integer field
                admin.setUsername(resultSet.getString("username"));
                admin.setPassword(resultSet.getString("password"));
                // Add other fields similarly

                admins.add(admin);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions properly in a real application
        }

        return admins;
    }
}