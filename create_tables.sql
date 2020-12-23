DROP DATABASE IF EXISTS parks;

CREATE DATABASE IF NOT EXISTS parks;

USE parks;

-- Create park table
CREATE TABLE park(
park_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
park_name VARCHAR(50) NOT NULL UNIQUE,
phone VARCHAR(13) NOT NULL,
description VARCHAR(250)
);

-- Create state table
CREATE TABLE state(
state_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
state VARCHAR(50) NOT NULL UNIQUE,
abbreviation CHAR(2) NOT NULL UNIQUE
);

-- Create park_state table
CREATE TABLE park_state(
park_id INT NOT NULL,
state_id INT NOT NULL,
CONSTRAINT park_state_park_id FOREIGN KEY (park_id) REFERENCES park (park_id),
CONSTRAINT park_state_state_id FOREIGN KEY (state_id) REFERENCES state (state_id)
);

-- Create entrance table
CREATE TABLE entrance(
entrance_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
entrance_name VARCHAR(100) NOT NULL,
park_id INT NOT NULL,
lat DECIMAL(10,7) NOT NULL,
lon DECIMAL(10,7) NOT NULL,
CONSTRAINT entrance_park_id FOREIGN KEY (park_id) REFERENCES park (park_id)
);

-- Create visitor center table
CREATE TABLE visitor_center(
visitor_center_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
park_id INT NOT NULL,
viscenter_name VARCHAR(250) NOT NULL,
CONSTRAINT visitor_center_park_id FOREIGN KEY (park_id) REFERENCES park (park_id)
);

-- Create parking table
CREATE TABLE parking(
parking_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
park_id INT NOT NULL,
CONSTRAINT parking_park_id FOREIGN KEY (park_id) REFERENCES park (park_id)
);

-- Create accommodation table
CREATE TABLE accommodation(
accommodation_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
park_id INT NOT NULL,
accommodation_name VARCHAR(50) NOT NULL,
type ENUM('Lodge', 'Campground', 'RV Park') NOT NULL,
CONSTRAINT accommodation_park_id FOREIGN KEY (park_id) REFERENCES park (park_id)
);

-- Create weather_station table
CREATE TABLE weather_station(
station_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
park_id INT NOT NULL,
state_id INT NOT NULL,
weather_st_name VARCHAR(50) NOT NULL UNIQUE,
lat DECIMAL(10,7) NOT NULL,
lon DECIMAL(10,7) NOT NULL,
altitude DECIMAL(11, 6) NOT NULL,
CONSTRAINT weather_station_park_id FOREIGN KEY (park_id) REFERENCES park (park_id),
CONSTRAINT station_state_id FOREIGN KEY (state_id) REFERENCES state (state_id)
);

-- Create weather table
CREATE TABLE weather(
station_id INT NOT NULL,
day DATE NOT NULL,
high_temp VARCHAR(50) NOT NULL,
low_temp VARCHAR(50) NOT NULL,
precip DECIMAL(5,2) NOT NULL,
snow DECIMAL(5,2) NOT NULL,
CONSTRAINT weather_station_id FOREIGN KEY (station_id) REFERENCES weather_station (station_id)
);

-- Create trail table
CREATE TABLE trail(
trail_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
park_id INT NOT NULL,
station_id INT NOT NULL,
trail VARCHAR(150) NOT NULL, 
distance_miles DECIMAL(4, 2) NOT NULL,
difficulty ENUM('Easy', 'Moderate', 'Hard') NOT NULL,
route_type ENUM('Out & Back', 'Loop', 'Point-to-Point'),
elevation_gain INT NOT NULL,
is_trailhead ENUM('Yes', 'No') NOT NULL,
date_open DATE NOT NULL,
date_close DATE NOT NULL,
bathrooms ENUM('Yes', 'No') NOT NULL,
dogs_allow ENUM('Yes', 'No') NOT NULL,
start_lat DECIMAL(10,7) NOT NULL,
start_lon DECIMAL(10,7) NOT NULL,
end_lat DECIMAL(10,7) NOT NULL,
end_lon DECIMAL(10,7) NOT NULL,
permit_required ENUM('Yes','No'),
description VARCHAR(1000),
CONSTRAINT trail_park_id FOREIGN KEY (park_id) REFERENCES park (park_id),
CONSTRAINT trail_station_id FOREIGN KEY (station_id) REFERENCES weather_station (station_id)
);


-- Create feature table
CREATE TABLE feature(
feature_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
feature VARCHAR(50) NOT NULL
);

-- Create trail_has_feature table
CREATE TABLE trail_has_feature(
trail_id INT NOT NULL,
feature_id INT NOT NULL,
CONSTRAINT trail_has_feature_trail_id FOREIGN KEY (trail_id) REFERENCES trail (trail_id),
CONSTRAINT trail_has_feature_feature_id FOREIGN KEY (feature_id) REFERENCES feature (feature_id)
);


-- Create user table
CREATE TABLE user(
user_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
name VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL
);

-- Create QR table
CREATE TABLE QR(
QR_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
trail_id INT NOT NULL,
lat DECIMAL(10,7) NOT NULL,
lon DECIMAL(10,7) NOT NULL,
CONSTRAINT qr_trail_id FOREIGN KEY (trail_id) REFERENCES trail (trail_id)
);

-- Create check_in table
CREATE TABLE check_in(
QR_id INT NOT NULL,
user_id INT NOT NULL,
timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT check_in_QR_id FOREIGN KEY (QR_id) REFERENCES QR (QR_id),
CONSTRAINT check_in_user_id FOREIGN KEY (user_id) REFERENCES user (user_id)
);

-- Create review table
CREATE TABLE review(
user_id INT NOT NULL,
trail_id INT NOT NULL,
time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
star_rating INT NOT NULL,        
review VARCHAR(1000),
CONSTRAINT review_user_id FOREIGN KEY (user_id) REFERENCES user (user_id),
CONSTRAINT review_trail_id FOREIGN KEY (trail_id) REFERENCES trail (trail_id)
);

-- Create condition table
CREATE TABLE conditions(
trail_id INT NOT NULL,
user_id INT NOT NULL,
condition_report VARCHAR(250) NOT NULL,
time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
picture BLOB, 
CONSTRAINT review_trail_id_2 FOREIGN KEY (trail_id) REFERENCES trail (trail_id),
CONSTRAINT review_user_id_2 FOREIGN KEY (user_id) REFERENCES user (user_id)
);

-- Create animal table
CREATE TABLE animal(
animal_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
animal_class ENUM('mammal', 'amphibian', 'reptile', 'bird', 'fish') NOT NULL,
common_name VARCHAR(45) NOT NULL
);


-- Create spotting table
CREATE TABLE spotting(
spotting_id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
animal_id INT NOT NULL,
user_id INT NOT NULL,
trail_id INT,
quantity INT NOT NULL DEFAULT 1,
lat DECIMAL(10,7) NOT NULL,
lon DECIMAL(10,7) NOT NULL,
description VARCHAR(250) NOT NULL,
time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
picture BLOB,
CONSTRAINT spotting_animal_id FOREIGN KEY (animal_id) REFERENCES animal (animal_id),
CONSTRAINT spotting_user_id FOREIGN KEY (user_id) REFERENCES user (user_id),
CONSTRAINT spotting_trail_id FOREIGN KEY (trail_id) REFERENCES trail (trail_id)
);

ALTER TABLE park AUTO_INCREMENT = 1;
ALTER TABLE state AUTO_INCREMENT = 1;
ALTER TABLE entrance AUTO_INCREMENT = 1;
ALTER TABLE visitor_center AUTO_INCREMENT = 1;
ALTER TABLE parking AUTO_INCREMENT = 1;
ALTER TABLE accommodation AUTO_INCREMENT = 1;
ALTER TABLE weather_station AUTO_INCREMENT = 1;
ALTER TABLE trail AUTO_INCREMENT = 1;
ALTER TABLE feature AUTO_INCREMENT = 1;
ALTER TABLE user AUTO_INCREMENT = 1;
ALTER TABLE QR AUTO_INCREMENT = 1;
ALTER TABLE animal AUTO_INCREMENT = 1;
ALTER TABLE spotting AUTO_INCREMENT = 1;

