package com.artgallery.model;

public class ArtistWork {
    private int id;
    private String artistname;
    private String title;
    private String description;
    private String category;
    private String creationdate;
    private String imagedata;
	public ArtistWork(int id, String artistname, String title, String description, String category, String creationdate,
			String imagedata) {
		super();
		this.id = id;
		this.artistname = artistname;
		this.title = title;
		this.description = description;
		this.category = category;
		this.creationdate = creationdate;
		this.imagedata = imagedata;
	}
	public ArtistWork() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getArtistname() {
		return artistname;
	}
	public void setArtistname(String artistname) {
		this.artistname = artistname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCreationdate() {
		return creationdate;
	}
	public void setCreationdate(String creationdate) {
		this.creationdate = creationdate;
	}
	public String getImagedata() {
		return imagedata;
	}
	public void setImagedata(String imagedata) {
		this.imagedata = imagedata;
	}
    
    

   
}

