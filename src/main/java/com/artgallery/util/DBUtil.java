package com.artgallery.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    static public Connection getConnection() throws SQLException {
        Connection connection = null;
        String url = "jdbc:mysql://localhost:3306/artgallery";
        String userName = "root";
        String password = "HolyJesus#7%";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, userName, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return connection;
    }

}
