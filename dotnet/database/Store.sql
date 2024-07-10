USE master;
GO

-- Drop database if it exists
IF DB_ID('store') IS NOT NULL
BEGIN
	ALTER DATABASE store SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE store;
END
GO

CREATE DATABASE store;
GO

USE store;
GO

-- Create tables
-- Users_Table
CREATE TABLE users (
	user_id INT IDENTITY(1,1) NOT NULL,
	username VARCHAR(50) NOT NULL,
	password_hash VARCHAR(200) NOT NULL,
	salt VARCHAR(200) NOT NULL,
	user_role VARCHAR(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

-- Product_Table
CREATE TABLE product (
	product_id INT IDENTITY(1,1) NOT NULL,
	brand VARCHAR(75) NOT NULL,
	name VARCHAR(50) NOT NULL,
	type VARCHAR(50) NOT NULL,
	price DECIMAL(8,2) NOT NULL,
	picture_url VARCHAR(1000) NOT NULL,
	CONSTRAINT PK_product PRIMARY KEY (product_id)
);

-- Review_Table
CREATE TABLE review (
	review_id INT IDENTITY(1,1) NOT NULL,
	product_id INT NOT NULL,
	reviewer VARCHAR(50) NOT NULL,
	rating INT NOT NULL,
	title VARCHAR(50) NOT NULL,
	comment VARCHAR(500) NOT NULL,
	date DATE DEFAULT GETDATE() NOT NULL,
	CONSTRAINT PK_review PRIMARY KEY (review_id),
	CONSTRAINT FK_product_review FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- User_Review_Table
CREATE TABLE user_review (
	review_id INT NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT PK_user_review PRIMARY KEY (review_id, user_id),
	CONSTRAINT FK_review_id FOREIGN KEY (review_id) REFERENCES review(review_id),
	CONSTRAINT FK_user_id FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert sample users
-- Password for these is "password"
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user', 'Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=', 'user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin', 'YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=', 'admin');

-- Insert 50 sample products
INSERT INTO product (brand, name, type, price, picture_url) VALUES 
    ('Nike', 'Air Max', 'Shoes', 299.99, 'https://robohash.org/1.png?size=200x200'),
    ('Adidas', 'UltraBoost', 'Shoes', 199.99, 'https://robohash.org/2.png?size=200x200'),
    ('Samsung', 'Galaxy S21', 'Smartphone', 899.99, 'https://robohash.org/3.png?size=200x200'),
    ('Apple', 'MacBook Pro', 'Laptop', 1299.99, 'https://robohash.org/4.png?size=200x200'),
    ('Sony', 'PlayStation 5', 'Gaming Console', 499.99, 'https://robohash.org/5.png?size=200x200'),
    ('Dell', 'XPS 13', 'Laptop', 999.99, 'https://robohash.org/6.png?size=200x200'),
    ('Bose', 'QuietComfort 35', 'Headphones', 299.99, 'https://robohash.org/7.png?size=200x200'),
    ('LG', 'CX OLED', 'Television', 1499.99, 'https://robohash.org/8.png?size=200x200'),
    ('Microsoft', 'Surface Pro 7', 'Tablet', 749.99, 'https://robohash.org/9.png?size=200x200'),
    ('Canon', 'EOS R5', 'Camera', 3899.99, 'https://robohash.org/10.png?size=200x200'),
    ('Sony', 'WH-1000XM4', 'Headphones', 349.99, 'https://robohash.org/11.png?size=200x200'),
    ('Apple', 'iPhone 12', 'Smartphone', 799.99, 'https://robohash.org/12.png?size=200x200'),
    ('HP', 'Spectre x360', 'Laptop', 1199.99, 'https://robohash.org/13.png?size=200x200'),
    ('Samsung', 'Galaxy Tab S7', 'Tablet', 649.99, 'https://robohash.org/14.png?size=200x200'),
    ('Google', 'Pixel 5', 'Smartphone', 699.99, 'https://robohash.org/15.png?size=200x200'),
    ('Sony', 'A7 III', 'Camera', 1999.99, 'https://robohash.org/16.png?size=200x200'),
    ('Nintendo', 'Switch', 'Gaming Console', 299.99, 'https://robohash.org/17.png?size=200x200'),
    ('Apple', 'iPad Air', 'Tablet', 599.99, 'https://robohash.org/18.png?size=200x200'),
    ('Samsung', 'QLED Q80T', 'Television', 1199.99, 'https://robohash.org/19.png?size=200x200'),
    ('Microsoft', 'Xbox Series X', 'Gaming Console', 499.99, 'https://robohash.org/20.png?size=200x200'),
    ('Bose', 'SoundLink Revolve', 'Speaker', 199.99, 'https://robohash.org/21.png?size=200x200'),
    ('Fitbit', 'Charge 4', 'Fitness Tracker', 149.99, 'https://robohash.org/22.png?size=200x200'),
    ('Garmin', 'Fenix 6', 'Smartwatch', 599.99, 'https://robohash.org/23.png?size=200x200'),
    ('JBL', 'Flip 5', 'Speaker', 119.99, 'https://robohash.org/24.png?size=200x200'),
    ('Dyson', 'V11', 'Vacuum', 599.99, 'https://robohash.org/25.png?size=200x200'),
    ('GoPro', 'Hero 9', 'Action Camera', 449.99, 'https://robohash.org/26.png?size=200x200'),
    ('Razer', 'Blade 15', 'Laptop', 1599.99, 'https://robohash.org/27.png?size=200x200'),
    ('Nikon', 'Z6', 'Camera', 1799.99, 'https://robohash.org/28.png?size=200x200'),
    ('Apple', 'AirPods Pro', 'Earbuds', 249.99, 'https://robohash.org/29.png?size=200x200'),
    ('Sony', 'Bravia X900H', 'Television', 999.99, 'https://robohash.org/30.png?size=200x200'),
    ('Samsung', 'Galaxy Watch 3', 'Smartwatch', 399.99, 'https://robohash.org/31.png?size=200x200'),
    ('Lenovo', 'Yoga C940', 'Laptop', 1399.99, 'https://robohash.org/32.png?size=200x200'),
    ('Apple', 'Apple Watch Series 6', 'Smartwatch', 399.99, 'https://robohash.org/33.png?size=200x200'),
    ('Sony', 'A6400', 'Camera', 899.99, 'https://robohash.org/34.png?size=200x200'),
    ('Bose', 'SoundSport Free', 'Earbuds', 199.99, 'https://robohash.org/35.png?size=200x200'),
    ('Jabra', 'Elite 75t', 'Earbuds', 179.99, 'https://robohash.org/36.png?size=200x200'),
    ('Samsung', 'Galaxy Buds Live', 'Earbuds', 169.99, 'https://robohash.org/37.png?size=200x200'),
    ('Roku', 'Streaming Stick+', 'Streaming Device', 49.99, 'https://robohash.org/38.png?size=200x200'),
    ('Amazon', 'Echo Dot', 'Smart Speaker', 49.99, 'https://robohash.org/39.png?size=200x200'),
    ('Apple', 'HomePod', 'Smart Speaker', 299.99, 'https://robohash.org/40.png?size=200x200'),
    ('Google', 'Nest Mini', 'Smart Speaker', 49.99, 'https://robohash.org/41.png?size=200x200'),
    ('Sony', 'WF-1000XM3', 'Earbuds', 229.99, 'https://robohash.org/42.png?size=200x200'),
    ('Bose', 'Soundbar 700', 'Soundbar', 799.99, 'https://robohash.org/43.png?size=200x200'),
    ('Samsung', 'HW-Q90R', 'Soundbar', 1499.99, 'https://robohash.org/44.png?size=200x200'),
    ('Vizio', 'SB36512-F6', 'Soundbar', 499.99, 'https://robohash.org/45.png?size=200x200'),
    ('Yamaha', 'YAS-209', 'Soundbar', 349.99, 'https://robohash.org/46.png?size=200x200'),
    ('LG', 'SL10YG', 'Soundbar', 1199.99, 'https://robohash.org/47.png?size=200x200'),
    ('Klipsch', 'Bar 48', 'Soundbar', 399.99, 'https://robohash.org/48.png?size=200x200'),
    ('Sonos', 'Beam', 'Soundbar', 399.99, 'https://robohash.org/49.png?size=200x200'),
    ('Polk Audio', 'Command Bar', 'Soundbar', 299.99, 'https://robohash.org/50.png?size=200x200');

-- Insert sample reviews for each product
INSERT INTO review (product_id, reviewer, rating, title, comment) VALUES 
    (1, 'Alice', 5, 'Comfortable and Stylish', 'Great shoes, very comfortable!'),
    (1, 'Bob', 4, 'Amazing Running Shoes', 'Perfect for long-distance running.'),
    (1, 'Charlie', 5, 'Best Shoes', 'Absolutely love these shoes!'),
    (1, 'Dave', 4, 'Good Quality', 'Well made and durable.'),
    (2, 'Eve', 5, 'Fantastic Sneakers', 'Comfortable and stylish.'),
    (2, 'Frank', 4, 'Great for Running', 'Good for jogging and daily use.'),
    (2, 'Grace', 5, 'Worth the Price', 'High quality and comfortable.'),
    (2, 'Hannah', 4, 'Nice Design', 'Love the look and feel.'),
    (3, 'Isaac', 5, 'Fantastic Phone', 'Awesome phone, love the camera!'),
    (3, 'Jack', 4, 'Great Value', 'Good phone for the price.'),
    (3, 'Alice', 5, 'Highly Recommend', 'Excellent features and performance.'),
    (3, 'Bob', 4, 'Solid Choice', 'Dependable and well-made.'),
    (4, 'Charlie', 5, 'High Performance', 'The MacBook Pro is blazing fast!'),
    (4, 'Dave', 4, 'Great Laptop', 'Perfect for work and play.'),
    (4, 'Eve', 5, 'Worth Every Penny', 'Superb performance and build quality.'),
    (4, 'Frank', 4, 'Impressive', 'Really satisfied with this purchase.'),
    (5, 'Grace', 5, 'Gaming Beast', 'The PS5 offers an incredible gaming experience.'),
    (5, 'Hannah', 4, 'Next Gen Console', 'Amazing graphics and speed.'),
    (5, 'Isaac', 5, 'Best Console', 'Unmatched gaming performance.'),
    (5, 'Jack', 4, 'Great Fun', 'Lots of fun for the whole family.'),
    (6, 'Alice', 5, 'Sleek and Powerful', 'The XPS 13 is a powerhouse in a small package.'),
    (6, 'Bob', 4, 'Impressive Build', 'Solid construction and design.'),
    (6, 'Charlie', 5, 'Great Performance', 'Handles everything I throw at it.'),
    (6, 'Dave', 4, 'Compact and Efficient', 'Perfect for on-the-go use.'),
    (7, 'Eve', 5, 'Amazing Sound', 'The QuietComfort 35s are fantastic.'),
    (7, 'Frank', 4, 'Comfortable', 'Very comfortable for long periods of use.'),
    (7, 'Grace', 5, 'Top Quality', 'The sound quality is unbeatable.'),
    (7, 'Hannah', 4, 'Great Noise Cancelling', 'Blocks out noise very effectively.'),
    (8, 'Isaac', 5, 'Stunning Picture', 'The CX OLED has an amazing picture quality.'),
    (8, 'Jack', 4, 'Great TV', 'Love the vibrant colors and deep blacks.'),
    (8, 'Alice', 5, 'Worth It', 'Definitely worth the investment.'),
    (8, 'Bob', 4, 'Excellent Choice', 'Great for movies and gaming.'),
    (9, 'Charlie', 5, 'Perfect Tablet', 'The Surface Pro 7 is very versatile.'),
    (9, 'Dave', 4, 'Great for Work', 'Perfect for productivity tasks.'),
    (9, 'Eve', 5, 'Highly Recommend', 'Excellent performance and build quality.'),
    (9, 'Frank', 4, 'Very Portable', 'Easy to carry around and use on the go.'),
    (10, 'Grace', 5, 'Amazing Camera', 'The EOS R5 is a game-changer.'),
    (10, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (10, 'Isaac', 5, 'Top Quality', 'The image quality is outstanding.'),
    (10, 'Jack', 4, 'Excellent Choice', 'Highly recommend for photographers.'),
    (11, 'Alice', 5, 'Excellent Headphones', 'The WH-1000XM4 are top-notch.'),
    (11, 'Bob', 4, 'Comfortable', 'Very comfortable for long use.'),
    (11, 'Charlie', 5, 'Great Sound', 'The sound quality is excellent.'),
    (11, 'Dave', 4, 'Great Noise Cancelling', 'Blocks out noise effectively.'),
    (12, 'Eve', 5, 'Amazing Phone', 'The iPhone 12 is fantastic.'),
    (12, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (12, 'Grace', 5, 'Top Quality', 'The build quality is excellent.'),
    (12, 'Hannah', 4, 'Highly Recommend', 'Great phone for the price.'),
    (13, 'Isaac', 5, 'Excellent Laptop', 'The Spectre x360 is very versatile.'),
    (13, 'Jack', 4, 'Great for Work', 'Perfect for productivity tasks.'),
    (13, 'Alice', 5, 'Highly Recommend', 'Excellent performance and build quality.'),
    (13, 'Bob', 4, 'Very Portable', 'Easy to carry around and use on the go.'),
    (14, 'Charlie', 5, 'Fantastic Tablet', 'The Galaxy Tab S7 is amazing.'),
    (14, 'Dave', 4, 'Great for Work', 'Perfect for productivity tasks.'),
    (14, 'Eve', 5, 'Highly Recommend', 'Excellent performance and build quality.'),
    (14, 'Frank', 4, 'Very Portable', 'Easy to carry around and use on the go.'),
    (15, 'Grace', 5, 'Amazing Phone', 'The Pixel 5 is fantastic.'),
    (15, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (15, 'Isaac', 5, 'Top Quality', 'The build quality is excellent.'),
    (15, 'Jack', 4, 'Highly Recommend', 'Great phone for the price.'),
    (16, 'Alice', 5, 'Excellent Camera', 'The A7 III is top-notch.'),
    (16, 'Bob', 4, 'Great Features', 'Loaded with useful features.'),
    (16, 'Charlie', 5, 'Top Quality', 'The image quality is outstanding.'),
    (16, 'Dave', 4, 'Highly Recommend', 'Great camera for the price.'),
    (17, 'Eve', 5, 'Amazing Console', 'The Switch is fantastic.'),
    (17, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (17, 'Grace', 5, 'Top Quality', 'The build quality is excellent.'),
    (17, 'Hannah', 4, 'Highly Recommend', 'Great console for the price.'),
    (18, 'Isaac', 5, 'Excellent Tablet', 'The iPad Air is top-notch.'),
    (18, 'Jack', 4, 'Great Features', 'Loaded with useful features.'),
    (18, 'Alice', 5, 'Top Quality', 'The build quality is excellent.'),
    (18, 'Bob', 4, 'Highly Recommend', 'Great tablet for the price.'),
    (19, 'Charlie', 5, 'Amazing TV', 'The QLED Q80T is fantastic.'),
    (19, 'Dave', 4, 'Great Features', 'Loaded with useful features.'),
    (19, 'Eve', 5, 'Top Quality', 'The picture quality is outstanding.'),
    (19, 'Frank', 4, 'Highly Recommend', 'Great TV for the price.'),
    (20, 'Grace', 5, 'Excellent Console', 'The Xbox Series X is top-notch.'),
    (20, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (20, 'Isaac', 5, 'Top Quality', 'The build quality is excellent.'),
    (20, 'Jack', 4, 'Highly Recommend', 'Great console for the price.'),
    (21, 'Alice', 5, 'Amazing Speaker', 'The SoundLink Revolve is fantastic.'),
    (21, 'Bob', 4, 'Great Features', 'Loaded with useful features.'),
    (21, 'Charlie', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (21, 'Dave', 4, 'Highly Recommend', 'Great speaker for the price.'),
    (22, 'Eve', 5, 'Excellent Tracker', 'The Charge 4 is top-notch.'),
    (22, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (22, 'Grace', 5, 'Top Quality', 'The build quality is excellent.'),
    (22, 'Hannah', 4, 'Highly Recommend', 'Great tracker for the price.'),
    (23, 'Isaac', 5, 'Amazing Watch', 'The Fenix 6 is fantastic.'),
    (23, 'Jack', 4, 'Great Features', 'Loaded with useful features.'),
    (23, 'Alice', 5, 'Top Quality', 'The build quality is excellent.'),
    (23, 'Bob', 4, 'Highly Recommend', 'Great watch for the price.'),
    (24, 'Charlie', 5, 'Amazing Speaker', 'The Flip 5 is fantastic.'),
    (24, 'Dave', 4, 'Great Features', 'Loaded with useful features.'),
    (24, 'Eve', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (24, 'Frank', 4, 'Highly Recommend', 'Great speaker for the price.'),
    (25, 'Grace', 5, 'Excellent Vacuum', 'The V11 is top-notch.'),
    (25, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (25, 'Isaac', 5, 'Top Quality', 'The build quality is excellent.'),
    (25, 'Jack', 4, 'Highly Recommend', 'Great vacuum for the price.'),
    (26, 'Alice', 5, 'Amazing Camera', 'The Hero 9 is fantastic.'),
    (26, 'Bob', 4, 'Great Features', 'Loaded with useful features.'),
    (26, 'Charlie', 5, 'Top Quality', 'The image quality is outstanding.'),
    (26, 'Dave', 4, 'Highly Recommend', 'Great camera for the price.'),
    (27, 'Eve', 5, 'Excellent Laptop', 'The Blade 15 is top-notch.'),
    (27, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (27, 'Grace', 5, 'Top Quality', 'The build quality is excellent.'),
    (27, 'Hannah', 4, 'Highly Recommend', 'Great laptop for the price.'),
    (28, 'Isaac', 5, 'Amazing Camera', 'The Z6 is fantastic.'),
    (28, 'Jack', 4, 'Great Features', 'Loaded with useful features.'),
    (28, 'Alice', 5, 'Top Quality', 'The image quality is outstanding.'),
    (28, 'Bob', 4, 'Highly Recommend', 'Great camera for the price.'),
    (29, 'Charlie', 5, 'Amazing Earbuds', 'The AirPods Pro are fantastic.'),
    (29, 'Dave', 4, 'Great Features', 'Loaded with useful features.'),
    (29, 'Eve', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (29, 'Frank', 4, 'Highly Recommend', 'Great earbuds for the price.'),
    (30, 'Grace', 5, 'Excellent TV', 'The Bravia X900H is top-notch.'),
    (30, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (30, 'Isaac', 5, 'Top Quality', 'The picture quality is outstanding.'),
    (30, 'Jack', 4, 'Highly Recommend', 'Great TV for the price.'),
    (31, 'Alice', 5, 'Amazing Watch', 'The Galaxy Watch 3 is fantastic.'),
    (31, 'Bob', 4, 'Great Features', 'Loaded with useful features.'),
    (31, 'Charlie', 5, 'Top Quality', 'The build quality is excellent.'),
    (31, 'Dave', 4, 'Highly Recommend', 'Great watch for the price.'),
    (32, 'Eve', 5, 'Excellent Laptop', 'The Yoga C940 is top-notch.'),
    (32, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (32, 'Grace', 5, 'Top Quality', 'The build quality is excellent.'),
    (32, 'Hannah', 4, 'Highly Recommend', 'Great laptop for the price.'),
    (33, 'Isaac', 5, 'Amazing Watch', 'The Apple Watch Series 6 is fantastic.'),
    (33, 'Jack', 4, 'Great Features', 'Loaded with useful features.'),
    (33, 'Alice', 5, 'Top Quality', 'The build quality is excellent.'),
    (33, 'Bob', 4, 'Highly Recommend', 'Great watch for the price.'),
    (34, 'Charlie', 5, 'Excellent Camera', 'The A6400 is top-notch.'),
    (34, 'Dave', 4, 'Great Features', 'Loaded with useful features.'),
    (34, 'Eve', 5, 'Top Quality', 'The image quality is outstanding.'),
    (34, 'Frank', 4, 'Highly Recommend', 'Great camera for the price.'),
    (35, 'Grace', 5, 'Amazing Earbuds', 'The SoundSport Free are fantastic.'),
    (35, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (35, 'Isaac', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (35, 'Jack', 4, 'Highly Recommend', 'Great earbuds for the price.'),
    (36, 'Alice', 5, 'Excellent Earbuds', 'The Elite 75t are top-notch.'),
    (36, 'Bob', 4, 'Great Features', 'Loaded with useful features.'),
    (36, 'Charlie', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (36, 'Dave', 4, 'Highly Recommend', 'Great earbuds for the price.'),
    (37, 'Eve', 5, 'Amazing Earbuds', 'The Galaxy Buds Live are fantastic.'),
    (37, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (37, 'Grace', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (37, 'Hannah', 4, 'Highly Recommend', 'Great earbuds for the price.'),
    (38, 'Isaac', 5, 'Excellent Device', 'The Streaming Stick+ is top-notch.'),
    (38, 'Jack', 4, 'Great Features', 'Loaded with useful features.'),
    (38, 'Alice', 5, 'Top Quality', 'The build quality is excellent.'),
    (38, 'Bob', 4, 'Highly Recommend', 'Great device for the price.'),
    (39, 'Charlie', 5, 'Amazing Speaker', 'The Echo Dot is fantastic.'),
    (39, 'Dave', 4, 'Great Features', 'Loaded with useful features.'),
    (39, 'Eve', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (39, 'Frank', 4, 'Highly Recommend', 'Great speaker for the price.'),
    (40, 'Grace', 5, 'Excellent Speaker', 'The HomePod is top-notch.'),
    (40, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (40, 'Isaac', 5, 'Top Quality', 'The build quality is excellent.'),
    (40, 'Jack', 4, 'Highly Recommend', 'Great speaker for the price.'),
    (41, 'Alice', 5, 'Amazing Speaker', 'The Nest Mini is fantastic.'),
    (41, 'Bob', 4, 'Great Features', 'Loaded with useful features.'),
    (41, 'Charlie', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (41, 'Dave', 4, 'Highly Recommend', 'Great speaker for the price.'),
    (42, 'Eve', 5, 'Excellent Earbuds', 'The WF-1000XM3 are top-notch.'),
    (42, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (42, 'Grace', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (42, 'Hannah', 4, 'Highly Recommend', 'Great earbuds for the price.'),
    (43, 'Isaac', 5, 'Amazing Soundbar', 'The Soundbar 700 is fantastic.'),
    (43, 'Jack', 4, 'Great Features', 'Loaded with useful features.'),
    (43, 'Alice', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (43, 'Bob', 4, 'Highly Recommend', 'Great soundbar for the price.'),
    (44, 'Charlie', 5, 'Excellent Soundbar', 'The HW-Q90R is top-notch.'),
    (44, 'Dave', 4, 'Great Features', 'Loaded with useful features.'),
    (44, 'Eve', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (44, 'Frank', 4, 'Highly Recommend', 'Great soundbar for the price.'),
    (45, 'Grace', 5, 'Amazing Soundbar', 'The SB36512-F6 is fantastic.'),
    (45, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (45, 'Isaac', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (45, 'Jack', 4, 'Highly Recommend', 'Great soundbar for the price.'),
    (46, 'Alice', 5, 'Excellent Soundbar', 'The YAS-209 is top-notch.'),
    (46, 'Bob', 4, 'Great Features', 'Loaded with useful features.'),
    (46, 'Charlie', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (46, 'Dave', 4, 'Highly Recommend', 'Great soundbar for the price.'),
    (47, 'Eve', 5, 'Amazing Soundbar', 'The SL10YG is fantastic.'),
    (47, 'Frank', 4, 'Great Features', 'Loaded with useful features.'),
    (47, 'Grace', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (47, 'Hannah', 4, 'Highly Recommend', 'Great soundbar for the price.'),
    (48, 'Isaac', 5, 'Excellent Soundbar', 'The Bar 48 is top-notch.'),
    (48, 'Jack', 4, 'Great Features', 'Loaded with useful features.'),
    (48, 'Alice', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (48, 'Bob', 4, 'Highly Recommend', 'Great soundbar for the price.'),
    (49, 'Charlie', 5, 'Amazing Soundbar', 'The Beam is fantastic.'),
    (49, 'Dave', 4, 'Great Features', 'Loaded with useful features.'),
    (49, 'Eve', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (49, 'Frank', 4, 'Highly Recommend', 'Great soundbar for the price.'),
    (50, 'Grace', 5, 'Excellent Soundbar', 'The Command Bar is top-notch.'),
    (50, 'Hannah', 4, 'Great Features', 'Loaded with useful features.'),
    (50, 'Isaac', 5, 'Top Quality', 'The sound quality is outstanding.'),
    (50, 'Jack', 4, 'Highly Recommend', 'Great soundbar for the price.');


-- Update picture_url for all products with unique Unsplash links
DECLARE @counter INT = 1;
DECLARE @max INT;

SELECT @max = MAX(product_id) FROM product;

WHILE @counter <= @max
BEGIN
   UPDATE product
	SET picture_url = 'https://robohash.org/' + CAST(product_id AS VARCHAR) + '.png?size=200x200'
    WHERE product_id = @counter;
    SET @counter = @counter + 1;
END;
GO