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

drop table if EXISTS genres;

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

drop table if EXISTS products;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    artist_brand VARCHAR(100),
    product_type ENUM('CD', 'Vinyl', 'Record Player') NOT NULL,
    genre_id INT NULL,
    unit_cost_price DECIMAL(10,2) NOT NULL,
    unit_selling_price DECIMAL(10,2) NOT NULL,
    min_stock_threshold INT DEFAULT 5,
    is_active TINYINT DEFAULT 1,
    INDEX(genre_id),
    CONSTRAINT fk_product_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
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

INSERT INTO genres (genre_name) VALUES
('Rock'), ('Pop'), ('Hip Hop'), ('Jazz'), ('Classical'),
('R&B'), ('Electronic'), ('Indie'), ('Metal'), ('Reggae');

INSERT INTO products (sku, name, artist_brand, product_type, genre_id, unit_cost_price, unit_selling_price, min_stock_threshold, is_active) VALUES
('SKU1001','Abbey Road','The Beatles','Vinyl',1,500,950,5,1),
('SKU1002','Thriller','Michael Jackson','CD',2,280,650,5,1),
('SKU1003','DAMN.','Kendrick Lamar','CD',3,300,720,5,1),
('SKU1004','Kind of Blue','Miles Davis','Vinyl',4,450,900,5,1),
('SKU1005','Beethoven 9th','Ludwig van Beethoven','CD',5,220,500,5,1),

('SKU1006','After Hours','The Weeknd','CD',6,320,750,5,1),
('SKU1007','Random Access Memories','Daft Punk','Vinyl',7,480,980,5,1),
('SKU1008','Indie Essentials','Various Artists','CD',8,180,420,5,1),
('SKU1009','Master of Puppets','Metallica','Vinyl',9,520,1100,5,1),
('SKU1010','Exodus','Bob Marley','CD',10,260,600,5,1),

('SKU1011','The Wall','Pink Floyd','Vinyl',1,550,1150,5,1),
('SKU1012','1989','Taylor Swift','CD',2,290,690,5,1),
('SKU1013','Astroworld','Travis Scott','CD',3,310,730,5,1),
('SKU1014','Blue Train','John Coltrane','Vinyl',4,460,920,5,1),
('SKU1015','Mozart Collection','Mozart','CD',5,240,540,5,1),

('SKU1016','Starboy','The Weeknd','CD',6,300,700,5,1),
('SKU1017','Discovery','Daft Punk','Vinyl',7,470,970,5,1),
('SKU1018','Indie Waves','Various Artists','CD',8,200,450,5,1),
('SKU1019','Ride the Lightning','Metallica','Vinyl',9,530,1120,5,1),
('SKU1020','Legend','Bob Marley','CD',10,270,620,5,1);

INSERT INTO stock (product_id, quantity) VALUES
(1, 38),(2, 52),(3, 27),(4, 44),(5, 61),
(6, 33),(7, 21),(8, 57),(9, 18),(10, 70),
(11, 40),(12, 49),(13, 26),(14, 35),(15, 63),
(16, 31),(17, 24),(18, 58),(19, 19),(20, 66);

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