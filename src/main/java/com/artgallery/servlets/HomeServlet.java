package com.artgallery.servlets;
import com.artgallery.dao.ArtGalleryDAO;
import com.artgallery.model.ArtistWork;

import com.artgallery.util.DBUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArtGalleryDAO artGalleryDAO = new ArtGalleryDAO();
        List<ArtistWork> artistWorks = artGalleryDAO.getAllArtistWorks();
        
        request.setAttribute("artistWorks", artistWorks);
        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
    }
}
