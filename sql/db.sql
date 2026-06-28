drop database if EXISTS Plaka_Kanta;

CREATE DATABASE IF NOT EXISTS Plaka_Kanta;
USE Plaka_Kanta;

drop table if EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Customer') NOT NULL DEFAULT 'Customer',
    full_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    address TEXT,
    is_active TINYINT DEFAULT 1
);


drop table if EXISTS products;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    artist_brand VARCHAR(100),
    product_type ENUM('CD', 'Vinyl', 'Record Player') NOT NULL,
    genre ENUM('Pop', 'Metal', 'Alternative', 'Country', 'Rock', 'Hip Hop'),
    unit_cost_price DECIMAL(10,2) NOT NULL,
    unit_selling_price DECIMAL(10,2) NOT NULL,
    min_stock_threshold INT DEFAULT 5,
    is_active TINYINT DEFAULT 1
);

drop table if EXISTS stock;

CREATE TABLE stock (
    stock_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT DEFAULT 0,
    INDEX(product_id),
    CONSTRAINT fk_stock_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

drop table if EXISTS stock_movements;

CREATE TABLE stock_movements (
    movement_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_id INT NOT NULL,
    quantity_change INT NOT NULL,
    reason VARCHAR(255),
    movement_date DATETIME DEFAULT NOW(),
    INDEX(product_id),
    CONSTRAINT fk_movement_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

drop table if EXISTS orders;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME DEFAULT NOW(),
    date_needed DATE,
    status ENUM('Pending', 'Confirmed', 'Voided', 'Cancelled') DEFAULT 'Pending',
    discount_type ENUM('Percentage', 'Fixed', 'None') DEFAULT 'None',
    discount_value DECIMAL(10,2) DEFAULT 0,
    cash_tendered DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) DEFAULT 0,
    change_amount DECIMAL(10,2) DEFAULT 0,
    INDEX(user_id),
    CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

drop table if EXISTS orderline;

CREATE TABLE orderline (
    orderline_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    INDEX(order_id),
    INDEX(product_id),
    CONSTRAINT fk_orderline_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_orderline_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

drop table if EXISTS expenses;

CREATE TABLE expenses (
    expense_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    expense_date DATE NOT NULL,
    category VARCHAR(100)
);

INSERT INTO users (username, password, role, full_name, contact_number, address, is_active) VALUES
('clegado', 'pass123', 'Admin', 'Charles Llegado', '09171234567', 'Upper Bicutan, Taguig', 1),
('jdelacruz', 'hello123', 'Customer', 'Juan Dela Cruz', '09170001234', 'Quezon City', 1),
('msantos', 'HelloWorld', 'Customer', 'Maria Santos', '09170002345', 'Manila', 1),
('jreyes', 'guesspassword', 'Customer', 'Jose Reyes', '09170003456', 'Caloocan', 1),
('alim', 'pass_is_word', 'Customer', 'Ana Lim', '09170004567', 'Pasig', 1),
('mdizon', 'realpass1109', 'Customer', 'Mark Dizon', '09170005678', 'Makati', 1),
('lgarcia', 'Hardpassword', 'Customer', 'Liza Garcia', '09170006789', 'Parañaque', 1),
('jcruz', 'CedricJuly', 'Customer', 'John Cruz', '09170007890', 'Laguna', 1),
('ebautista', 'Domingo11', 'Customer', 'Ella Bautista', '09170008901', 'Cavite', 1),
('mtorres', 'Nunez2006', 'Customer', 'Miguel Torres', '09170009012', 'Bulacan', 1),
('pmendoza', 'mendopass', 'Customer', 'Paula Mendoza', '09170010123', 'Rizal', 1),
('kramos', 'easypeazy', 'Customer', 'Kevin Ramos', '09170011234', 'Taguig', 1);


INSERT INTO products (sku, name, artist_brand, product_type, genre, unit_cost_price, unit_selling_price, min_stock_threshold, is_active) VALUES

-- pop vinyls
('VNY1001', 'Harry''s House', 'Harry Styles', 'Vinyl', 'Pop', 1260, 3150, 5, 1),
('VNY1002', '1989 (Taylor''s Version)', 'Taylor Swift', 'Vinyl', 'Pop', 1800, 4500, 5, 1),
('VNY1003', 'a beautiful blur', 'LANY', 'Vinyl', 'Pop', 900, 2250, 5, 1),
('VNY1004', 'SOUR', 'Olivia Rodrigo', 'Vinyl', 'Pop', 1200, 3000, 5, 1),
('VNY1005', 'brat', 'Charli XCX', 'Vinyl', 'Pop', 1200, 3000, 5, 1),
('VNY1006', 'Short n'' Sweet', 'Sabrina Carpenter', 'Vinyl', 'Pop', 1300, 3250, 5, 1),
('VNY1007', 'thank u, next', 'Ariana Grande', 'Vinyl', 'Pop', 1200, 3000, 5, 1),
('VNY1008', 'Changes', 'Justin Bieber', 'Vinyl', 'Pop', 1000, 2500, 5, 1),
('VNY1009', 'Bad', 'Michael Jackson', 'Vinyl', 'Pop', 800, 2000, 5, 1),
('VNY1010', 'Thriller', 'Michael Jackson', 'Vinyl', 'Pop', 800, 2000, 5, 1),
('VNY1011', '...baby one more time', 'Britney Spears', 'Vinyl', 'Pop', 800, 2000, 5, 1),
('VNY1012', 'Like a Prayer', 'Madonna', 'Vinyl', 'Pop', 800, 2000, 5, 1),
('VNY1013', 'Teenage Dream', 'Katy Perry', 'Vinyl', 'Pop', 1400, 3500, 5, 1),
('VNY1014', '24K Magic', 'Bruno Mars', 'Vinyl', 'Pop', 800, 2000, 5, 1),
('VNY1015', 'Melodrama', 'Lorde', 'Vinyl', 'Pop', 800, 2000, 5, 1),

-- metal vinyls
('VNY2001', 'Ride the Lightning', 'Metallica', 'Vinyl', 'Metal', 800, 2000, 5, 1),
('VNY2002', 'Master of Puppets', 'Metallica', 'Vinyl', 'Metal', 800, 2000, 5, 1),
('VNY2003', 'Painkiller', 'Judas Priest', 'Vinyl', 'Metal', 800, 2000, 5, 1),
('VNY2004', 'Paranoid', 'Black Sabbath', 'Vinyl', 'Metal', 600, 1500, 5, 1),
('VNY2005', 'Fallen', 'Evanescence', 'Vinyl', 'Metal', 600, 1500, 5, 1),
('VNY2006', 'Fortitude', 'Gojira', 'Vinyl', 'Metal', 600, 1500, 5, 1),

-- alternative vinyls
('VNY3001', 'Eyes Open', 'Snow Patrol', 'Vinyl', 'Alternative', 1260, 3150, 5, 1),
('VNY3002', 'OK Computer', 'Radiohead', 'Vinyl', 'Alternative', 1400, 3500, 5, 1),
('VNY3003', 'Hatful of Hollow', 'The Smiths', 'Vinyl', 'Alternative', 800, 2000, 5, 1),
('VNY3004', 'Ghost Stories', 'Coldplay', 'Vinyl', 'Alternative', 800, 2000, 5, 1),
('VNY3005', 'Folklore', 'Taylor Swift', 'Vinyl', 'Alternative', 1500, 3750, 5, 1),
('VNY3006', 'Pablo Honey', 'Radiohead', 'Vinyl', 'Alternative', 800, 2000, 5, 1),

-- country vinyls
('VNY4001', 'Fearless (Platinum Edition)', 'Taylor Swift', 'Vinyl', 'Country', 1400, 3500, 5, 1),
('VNY4002', 'Come On Over', 'Shania Twain', 'Vinyl', 'Country', 1180, 2950, 5, 1),
('VNY4003', 'At Folsom Prison', 'Johnny Cash', 'Vinyl', 'Country', 600, 1500, 5, 1),
('VNY4004', 'Traveller', 'Chris Stapleton', 'Vinyl', 'Country', 800, 2000, 5, 1),
('VNY4005', 'Standing Room Only', 'Tim McGraw', 'Vinyl', 'Country', 800, 2000, 5, 1),
('VNY4006', 'I''m the Problem', 'Morgan Wallen', 'Vinyl', 'Country', 1200, 3000, 5, 1),
('VNY4007', 'Jolene', 'Dolly Parton', 'Vinyl', 'Country', 800, 2000, 5, 1),
('VNY4008', 'The Very Best of Dolly Parton', 'Dolly Parton', 'Vinyl', 'Country', 1200, 3000, 5, 1),
('VNY4009', 'Kansas Anymore', 'Role Model', 'Vinyl', 'Country', 900, 2250, 5, 1),

-- rock vinyls
('VNY5001', 'Use Your Illusion I', 'Guns N'' Roses', 'Vinyl', 'Rock', 1300, 3250, 5, 1),
('VNY5002', 'Appetite for Destruction', 'Guns N'' Roses', 'Vinyl', 'Rock', 800, 2000, 5, 1),
('VNY5003', 'Slippery When Wet', 'Bon Jovi', 'Vinyl', 'Rock', 800, 2000, 5, 1),
('VNY5004', 'Abbey Road', 'The Beatles', 'Vinyl', 'Rock', 1000, 2500, 5, 1),
('VNY5005', 'Rumours', 'Fleetwood Mac', 'Vinyl', 'Rock', 1100, 2750, 5, 1),
('VNY5006', 'The Game', 'Queen', 'Vinyl', 'Rock', 900, 2250, 5, 1),
('VNY5007', 'Greatest Hits', 'Queen', 'Vinyl', 'Rock', 1400, 3500, 5, 1),
('VNY5008', 'Nevermind', 'Nirvana', 'Vinyl', 'Rock', 900, 2250, 5, 1),
('VNY5009', 'Three Cheers for Sweet Revenge', 'My Chemical Romance', 'Vinyl', 'Rock', 900, 2250, 5, 1),

-- hip hop vinyls
('VNY6001', 'GNX', 'Kendrick Lamar', 'Vinyl', 'Hip Hop', 1300, 3250, 5, 1),
('VNY6002', 'Astroworld', 'Travis Scott', 'Vinyl', 'Hip Hop', 1200, 3000, 5, 1),
('VNY6003', 'ANTI', 'Rihanna', 'Vinyl', 'Hip Hop', 1400, 3500, 5, 1),
('VNY6004', 'The Marshall Mathers LP', 'Eminem', 'Vinyl', 'Hip Hop', 1180, 2950, 5, 1),
('VNY6005', 'The Blueprint', 'Jay-Z', 'Vinyl', 'Hip Hop', 1180, 2950, 5, 1),
('VNY6006', 'The College Dropout', 'Kanye West', 'Vinyl', 'Hip Hop', 1200, 3000, 5, 1),

-- pop cds
('CD1001', 'Harry''s House', 'Harry Styles', 'CD', 'Pop', 500, 1250, 5, 1),
('CD1002', 'reputation', 'Taylor Swift', 'CD', 'Pop', 400, 1000, 5, 1),
('CD1003', '1989', 'Taylor Swift', 'CD', 'Pop', 380, 950, 5, 1),
('CD1004', 'SOUR', 'Olivia Rodrigo', 'CD', 'Pop', 380, 950, 5, 1),
('CD1005', 'brat', 'Charli XCX', 'CD', 'Pop', 500, 1250, 5, 1),
('CD1006', 'Short n'' Sweet', 'Sabrina Carpenter', 'CD', 'Pop', 500, 1250, 5, 1),
('CD1007', 'thank u, next', 'Ariana Grande', 'CD', 'Pop', 380, 950, 5, 1),
('CD1008', 'positions', 'Ariana Grande', 'CD', 'Pop', 380, 950, 5, 1),
('CD1009', 'Bad', 'Michael Jackson', 'CD', 'Pop', 340, 850, 5, 1),
('CD1010', 'Thriller', 'Michael Jackson', 'CD', 'Pop', 340, 850, 5, 1),
('CD1011', '24K Magic', 'Bruno Mars', 'CD', 'Pop', 340, 850, 5, 1),
('CD1012', 'My World', 'Justin Bieber', 'CD', 'Pop', 300, 750, 5, 1),

-- metal cds
('CD2001', 'Ride the Lightning', 'Metallica', 'CD', 'Metal', 380, 950, 5, 1),
('CD2002', 'Master of Puppets', 'Metallica', 'CD', 'Metal', 380, 950, 5, 1),
('CD2003', 'Fallen', 'Evanescence', 'CD', 'Metal', 340, 850, 5, 1),

-- alternative cds
('CD3001', 'OK Computer', 'Radiohead', 'CD', 'Alternative', 460, 1150, 5, 1),
('CD3002', 'Ghost Stories', 'Coldplay', 'CD', 'Alternative', 380, 950, 5, 1),
('CD3003', 'Folklore', 'Taylor Swift', 'CD', 'Alternative', 500, 1250, 5, 1),

-- country cds
('CD4001', 'Speak Now', 'Taylor Swift', 'CD', 'Country', 380, 950, 5, 1),
('CD4002', 'Fearless', 'Taylor Swift', 'CD', 'Country', 380, 950, 5, 1),
('CD4003', 'I''m the Problem', 'Morgan Wallen', 'CD', 'Country', 500, 1250, 5, 1),
('CD4004', 'Jolene', 'Dolly Parton', 'CD', 'Country', 340, 850, 5, 1),
('CD4005', 'Kansas Anymore', 'Role Model', 'CD', 'Country', 460, 1150, 5, 1),
('CD4006', 'Cowboy Carter', 'Beyoncé', 'CD', 'Country', 540, 1350, 5, 1),

-- rock cds
('CD5001', 'Use Your Illusion I', 'Guns N'' Roses', 'CD', 'Rock', 380, 950, 5, 1),
('CD5002', 'Slippery When Wet', 'Bon Jovi', 'CD', 'Rock', 340, 850, 5, 1),
('CD5003', 'Rumours', 'Fleetwood Mac', 'CD', 'Rock', 380, 950, 5, 1),
('CD5004', 'Abbey Road', 'The Beatles', 'CD', 'Rock', 460, 1150, 5, 1),
('CD5005', 'Nevermind', 'Nirvana', 'CD', 'Rock', 380, 950, 5, 1),
('CD5006', 'Three Cheers for Sweet Revenge', 'My Chemical Romance', 'CD', 'Rock', 380, 950, 5, 1),

-- hip hop cds
('CD6001', 'GNX', 'Kendrick Lamar', 'CD', 'Hip Hop', 540, 1350, 5, 1),
('CD6002', 'Astroworld', 'Travis Scott', 'CD', 'Hip Hop', 380, 950, 5, 1),
('CD6003', 'ANTI', 'Rihanna', 'CD', 'Hip Hop', 460, 1150, 5, 1),
('CD6004', 'The Eminem Show', 'Eminem', 'CD', 'Hip Hop', 380, 950, 5, 1),
('CD6005', 'The College Dropout', 'Kanye West', 'CD', 'Hip Hop', 460, 1150, 5, 1),
('CD6006', 'Graduation', 'Kanye West', 'CD', 'Hip Hop', 460, 1150, 5, 1),

-- record players ( NULL yung genre since hindi naman yan genre )
('RP0001', 'Stylish Wood Turntable', 'Audio-Technica', 'Record Player', NULL, 10600, 26499, 5, 1),
('RP0002', 'Turntable with High-Fidelity Heritage', 'Audio-Technica', 'Record Player', NULL, 12800, 32000, 5, 1),
('RP0003', 'Straight Carbon-fiber Tonearm with Bluetooth', 'Audio-Technica', 'Record Player', NULL, 16000, 39999, 5, 1),
('RP0004', 'AT-VM95C Dual Magnet with Bluetooth (Black)', 'Audio-Technica', 'Record Player', NULL, 7600, 18999, 5, 1),
('RP0005', 'AT-VM95C Dual Magnet with Bluetooth (White)', 'Audio-Technica', 'Record Player', NULL, 7600, 18999, 5, 1),
('RP0006', 'Audio-Technica USB and Analog Output', 'Audio-Technica', 'Record Player', NULL, 5200, 12999, 5, 1);

-- stock for all 99 fucking products 

INSERT INTO stock (product_id, quantity) VALUES
(1,55),(2,22),(3,16),(4,62),(5,32),(6,30),(7,29),(8,23),(9,62),(10,21),
(11,58),(12,62),(13,72),(14,49),(15,20),(16,52),(17,42),(18,17),(19,16),(20,20),
(21,28),(22,29),(23,47),(24,53),(25,16),(26,50),(27,27),(28,60),(29,56),(30,59),
(31,49),(32,41),(33,29),(34,43),(35,52),(36,32),(37,66),(38,70),(39,15),(40,63),
(41,66),(42,25),(43,59),(44,42),(45,36),(46,32),(47,24),(48,28),(49,63),(50,36),
(51,21),(52,20),(53,39),(54,21),(55,37),(56,69),(57,37),(58,53),(59,31),(60,66),
(61,17),(62,61),(63,44),(64,49),(65,22),(66,74),(67,39),(68,20),(69,50),(70,33),
(71,68),(72,55),(73,54),(74,71),(75,70),(76,38),(77,51),(78,27),(79,60),(80,19),
(81,17),(82,57),(83,29),(84,64),(85,33),(86,20),(87,69),(88,29),(89,70),(90,21),
(91,39),(92,32),(93,44),(94,55),(95,68),(96,38),(97,25),(98,38),(99,37);

INSERT INTO stock_movements (product_id, quantity_change, reason, movement_date) VALUES
(1, 20, 'New shipment received', '2026-06-01 10:00:00'),
(2, -5, 'Customer purchase batch', '2026-06-02 12:15:00'),
(3, 15, 'Restock from supplier', '2026-06-03 09:30:00'),
(4, -3, 'Online orders fulfillment', '2026-06-03 14:10:00'),
(5, 25, 'Warehouse restock', '2026-06-04 11:45:00'),

(6, -4, 'Walk-in sales', '2026-06-05 16:20:00'),
(7, 10, 'Inventory adjustment', '2026-06-06 08:00:00'),
(8, -6, 'Order dispatch', '2026-06-06 13:30:00'),
(9, 12, 'New stock arrival', '2026-06-07 10:25:00'),
(10, -8, 'Bulk customer purchase', '2026-06-07 17:40:00'),

(11, 18, 'Supplier delivery', '2026-06-08 09:10:00'),
(12, -2, 'Damaged item removal', '2026-06-08 15:00:00'),
(13, 14, 'Restock', '2026-06-09 10:50:00'),
(14, -5, 'Customer order', '2026-06-09 18:20:00'),
(15, 20, 'New shipment', '2026-06-10 11:05:00'),

(16, -7, 'Online sales', '2026-06-10 19:30:00'),
(17, 13, 'Restock', '2026-06-11 09:45:00'),
(18, -3, 'Retail purchase', '2026-06-11 14:55:00'),
(19, 16, 'Supplier replenishment', '2026-06-12 10:15:00'),
(20, -9, 'Bulk order shipment', '2026-06-12 16:40:00');

INSERT INTO orders (user_id, date_needed, status, discount_type, discount_value, cash_tendered, total_amount, change_amount) VALUES
(2,'2026-06-25','Confirmed','None',0,1000,950,50),
(3,'2026-06-25','Pending','Percentage',10,800,720,80),
(4,'2026-06-26','Confirmed','Fixed',50,900,850,50),
(5,'2026-06-26','Cancelled','None',0,0,0,0),
(6,'2026-06-27','Confirmed','None',0,1200,1100,100),

(7,'2026-06-27','Pending','Percentage',5,900,855,45),
(8,'2026-06-28','Confirmed','None',0,1500,1400,100),
(9,'2026-06-28','Voided','None',0,0,0,0),
(10,'2026-06-29','Confirmed','Fixed',100,2000,1800,200),
(11,'2026-06-29','Pending','None',0,700,650,50);

INSERT INTO orderline (order_id, product_id, quantity, unit_price) VALUES
(1,1,1,950),
(2,2,1,650),
(3,3,1,720),
(4,4,1,900),
(5,5,2,500),

(6,6,1,750),
(7,7,1,980),
(8,8,2,420),
(9,9,1,1100),
(10,10,1,600);

INSERT INTO expenses (description, amount, expense_date, category) VALUES
('Monthly rent',15000,'2026-06-01','Rent'),
('Electric bill',3200,'2026-06-02','Utilities'),
('Internet subscription',2000,'2026-06-03','Utilities'),
('Staff payroll',12000,'2026-06-04','Payroll'),
('Facebook ads',3500,'2026-06-05','Marketing'),

('Packaging materials',900,'2026-06-06','Operations'),
('Delivery fuel',1100,'2026-06-07','Logistics'),
('Store cleaning',600,'2026-06-08','Maintenance'),
('Equipment repair',2500,'2026-06-09','Maintenance'),
('Inventory system tools',1800,'2026-06-10','Software'),

('Electric bill',3400,'2026-06-11','Utilities'),
('Internet',2000,'2026-06-12','Utilities'),
('Staff bonus',5000,'2026-06-13','Payroll'),
('Marketing boost',4000,'2026-06-14','Marketing'),
('Rent payment',15000,'2026-06-15','Rent'),

('Office supplies',700,'2026-06-16','Operations'),
('Courier fees',1300,'2026-06-17','Logistics'),
('Security service',2200,'2026-06-18','Security'),
('Electric bill',3600,'2026-06-19','Utilities'),
('Software subscription',1500,'2026-06-20','Software');
