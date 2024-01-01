package com.artgallery.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.artgallery.model.ArtistWork;
import com.artgallery.util.DBUtil;

public class ArtGalleryDAO {
    public List<ArtistWork> getAllArtistWorks() {
        List<ArtistWork> artistWorks = new ArrayList<>();

        try (Connection connection = DBUtil.getConnection()) {
            String sql = "SELECT * FROM artist_content";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ArtistWork artistWork = new ArtistWork();
                artistWork.setId(resultSet.getInt("id"));
                artistWork.setTitle(resultSet.getString("title"));
                artistWork.setArtistname(resultSet.getString("artistname"));
                artistWork.setDescription(resultSet.getString("description"));
                artistWork.setCategory(resultSet.getString("category"));
                // Set other properties as needed

                artistWorks.add(artistWork);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        }

        return artistWorks;
    }
}
