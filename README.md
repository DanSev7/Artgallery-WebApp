**ArtGallery-WebApp**
A comprehensive, full-stack Java Servlet ArtGallery WebApp Project.

# App Configuration

## Pre Configuration to run
###
#### Create database
```
CREATE DATABASE artgallery;
```
###  Create a table
### Create admin table
```
CREATE TABLE admin (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(20) NOT NULL
);
```
### Add admin to the admin table
```
INSERT INTO admin (username, password, role)
VALUES ('admin123', 'password123', 'admin');
```
### Create users table
```
CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(25) DEFAULT 'user'
);
```
####  Create artist_content table
```
CREATE TABLE artist_content (
  id INT PRIMARY KEY AUTO_INCREMENT,
  artistname VARCHAR (50),
  title VARCHAR (50),
  description TEXT,
  category VARCHAR(50),
  creationdate DATE,
  imagedata LONGBLOB
);
```
#### Create favorite_list table
```
CREATE TABLE favorite_list (
  id INT PRIMARY KEY AUTO_INCREMENT,
  artistname VARCHAR (50),
  title VARCHAR (50),
  description TEXT,
  category VARCHAR(50),
  creationdate DATE,
  imagedata LONGBLOB,
  user_id INT
);
```
