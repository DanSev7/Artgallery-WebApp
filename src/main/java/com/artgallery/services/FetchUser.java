package com.artgallery.services;
import java.io.IOException;
import java.sql.*;

import com.artgallery.util.DBUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class FetchUser {
	public static int fetchId (HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException  {
		String query = "SELECT user_id FROM users WHERE user_id=?";
		Object id = req.getSession().getAttribute("uid");
		try {
			if (id == null) {
				res.sendRedirect("register.jsp");
				return -1;
			}
			
			Connection con = DBUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, (int)id);
			ResultSet rs = ps.executeQuery();
			
			if (!rs.next()) {
				res.sendRedirect("login.jsp");
				return -1;
			}
			
			return (int) id;

		} catch (SQLException e) {
			e.printStackTrace();
			res.getWriter().println(e.getMessage());
		}
		return -1;
	}
			
}
