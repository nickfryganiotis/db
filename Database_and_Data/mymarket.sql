CREATE SCHEMA IF NOT EXISTS market;
USE market;
#SET GLOBAL time_zone = '+3:00';
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE market.customer(
			card_number INT AUTO_INCREMENT,
            first_name VARCHAR(20) NOT NULL,
            last_name VARCHAR(20) NOT NULL,
            points INT DEFAULT 0,
            street VARCHAR(20),
            address_number SMALLINT,
            postal_code CHAR(5),
            city VARCHAR(20),
            family_members SMALLINT,
            pet VARCHAR(20) CHECK (pet IN ('cat', 'dog', 'fish', 'hamster', 'bird', 'rabbit') OR NULL),
            age SMALLINT,
            phone_number NUMERIC(10,0),
            date_of_birth DATE,
            PRIMARY KEY (card_number));
            
CREATE TABLE market.store(
			storeID INT AUTO_INCREMENT,
            street VARCHAR(20) NOT NULL,
            address_number SMALLINT NOT NULL,
            postal_code CHAR(5) NOT NULL,
            city VARCHAR(20) NOT NULL,
            size SMALLINT,
            operating_hours CHAR(11),
            PRIMARY KEY(storeID));
            
CREATE TABLE market.telephone(
			storeID INT,
            telephone_number NUMERIC(10,0) NOT NULL,
            FOREIGN KEY (storeID) REFERENCES store(storeID) ON UPDATE CASCADE,
            PRIMARY KEY (storeID, telephone_number));
            
CREATE TABLE market.category(
			categoryID INT AUTO_INCREMENT,
            category_name VARCHAR(30) NOT NULL CHECK (category_name IN ('fresh products', 'chilled products', 'drinks', 'toiletries', 'homeware', 'pet products')),
            PRIMARY KEY(categoryID));

CREATE TABLE market.product(
			barcode VARCHAR(20),
            product_name VARCHAR(50),
            price DOUBLE,
            brand_name VARCHAR(20),
            categoryID INT,
            PRIMARY KEY(barcode),
            FOREIGN KEY(categoryID) REFERENCES category(categoryID) ON UPDATE CASCADE);
            
CREATE TABLE market.provides(
			storeID INT,
            categoryID INT,
            PRIMARY KEY(storeID, categoryID),
            FOREIGN KEY(storeID) REFERENCES store(storeID) ON UPDATE CASCADE,
            FOREIGN KEY(categoryID) REFERENCES category(categoryID) ON UPDATE CASCADE);
            
CREATE TABLE market.offers(
			storeID INT,
            barcode VARCHAR(20),
            alley_number SMALLINT,
            shelf_number SMALLINT,
            quantity INT NOT NULL,
            PRIMARY KEY(storeID, barcode),
            FOREIGN KEY(storeID) REFERENCES store(storeID) ON UPDATE CASCADE,
            FOREIGN KEY(barcode) REFERENCES product(barcode) ON UPDATE CASCADE);
            
CREATE TABLE market.price_history(
			start_date DATETIME DEFAULT CURRENT_TIMESTAMP,
            barcode VARCHAR(20),
            price DOUBLE,
            end_date DATETIME,
            PRIMARY KEY(start_date, barcode),
            FOREIGN KEY(barcode) REFERENCES product(barcode) ON UPDATE CASCADE);
            
CREATE TABLE market.product_transaction(
			date_time DATETIME,
            card_number INT,
            total_amount DOUBLE DEFAULT 0.0,
            payment_method CHAR(4) CHECK (payment_method in ('cash', 'card') OR NULL),
            total_pieces INT DEFAULT 0,
            storeID INT,
            PRIMARY KEY(date_time, card_number),
            FOREIGN KEY (storeID) REFERENCES store(storeID) ON UPDATE CASCADE,
            FOREIGN KEY(card_number) REFERENCES customer(card_number) ON UPDATE CASCADE);

CREATE TABLE market.product_contains(
			card_number INT,
            date_time DATETIME,
            barcode VARCHAR(20),
            price_bought DOUBLE,
            pieces INT,
            PRIMARY KEY(card_number, date_time, barcode),
            FOREIGN KEY(card_number, date_time) REFERENCES product_transaction(card_number, date_time) ON UPDATE CASCADE,
            FOREIGN KEY(barcode) REFERENCES product(barcode) ON UPDATE CASCADE);
            


CREATE TRIGGER customer_age_calc BEFORE INSERT ON customer 
	FOR EACH ROW SET NEW.age = YEAR(NOW()) - YEAR(NEW.date_of_birth);
CREATE TRIGGER customer_age_calc2 BEFORE UPDATE ON customer 
	FOR EACH ROW SET NEW.age = YEAR(NOW()) - YEAR(NEW.date_of_birth);


CREATE TRIGGER sologelato BEFORE INSERT ON product_contains
	FOR EACH ROW SET NEW.price_bought = (SELECT price FROM price_history WHERE (barcode = NEW.barcode AND start_date <= NEW.date_time AND IFNULL(end_date, '2020-12-31 00-00-00') >= NEW.date_time));

    
DELIMITER $$
CREATE TRIGGER update_transaction_contains
AFTER INSERT ON product_contains FOR EACH ROW
BEGIN
	DECLARE x DOUBLE;
    SELECT price INTO @x FROM price_history WHERE (barcode = NEW.barcode AND NEW.date_time BETWEEN start_date AND IFNULL(end_date, '2020-12-31 00-00-00'));
    UPDATE product_transaction
    SET total_amount = CAST(total_amount + @x*(CAST(NEW.pieces AS DOUBLE)) AS DECIMAL(10,2))
    WHERE product_transaction.date_time = NEW.date_time AND product_transaction.card_number = NEW.card_number;
    UPDATE product_transaction
    SET total_pieces = total_pieces + NEW.pieces
    WHERE product_transaction.date_time = NEW.date_time AND product_transaction.card_number = NEW.card_number;
END;
$$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER auto_update_price
BEFORE INSERT ON price_history FOR EACH ROW
BEGIN
	IF ISNULL(NEW.end_date)
    THEN
        UPDATE product
        SET price = NEW.price
        WHERE (barcode = NEW.barcode);
	END IF;
END; 
$$
DELIMITER ;


LOAD DATA INFILE 'C:/Users/user/Desktop/Customer.txt' INTO TABLE customer FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' (first_name,last_name,points,street,address_number,postal_code,city,family_members,pet,phone_number,date_of_birth);
LOAD DATA INFILE 'C:/Users/user/Desktop/Category.txt' INTO TABLE category FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' (category_name);
LOAD DATA INFILE 'C:/Users/user/Desktop/Store.txt' INTO TABLE store FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' (street,address_number,postal_code,city,size,operating_hours);
LOAD DATA INFILE 'C:/Users/user/Desktop/Telephone.txt' INTO TABLE telephone FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA INFILE 'C:/Users/user/Desktop/Product.txt' INTO TABLE product FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n' (product_name,brand_name,price,barcode,categoryID);
LOAD DATA INFILE 'C:/Users/user/Desktop/Provides.txt' INTO TABLE provides FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' (storeID, categoryID);
LOAD DATA INFILE 'C:/Users/user/Desktop/Offers.txt' INTO TABLE offers FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA INFILE 'C:/Users/user/Desktop/Price_history1.txt' INTO TABLE price_history FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' (start_date, barcode, price, end_date);
LOAD DATA INFILE 'C:/Users/user/Desktop/Price_history2.txt' INTO TABLE price_history FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' (start_date, barcode, price);
LOAD DATA INFILE 'C:/Users/user/Desktop/Product_transaction.txt' INTO TABLE product_transaction FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' (card_number, storeID, payment_method, date_time);
LOAD DATA INFILE 'C:/Users/user/Desktop/Product_contains.txt' INTO TABLE product_contains FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' (card_number,date_time, barcode, pieces);

CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, points, street, address_number, postal_code, city, family_members, pet, age, phone_number
FROM customer;

CREATE OR REPLACE VIEW transaction_category_store AS
SELECT c.date_time AS imerominia , cu.first_name AS mikro, cu.last_name AS eponumo, COUNT(c.pieces) AS total_items, ROUND(SUM(c.pieces*c.price_bought),2)  AS total_price, cat.category_name AS katigoria , t.payment_method AS lefta, s.city AS poli, s.street AS dromos, s.address_number AS arithmos
FROM product_transaction t, product_contains c, product p, category cat, customer cu, store s
WHERE t.date_time = c.date_time 
AND t.card_number = c.card_number 
AND p.barcode = c.barcode 
AND cat.categoryID = p.categoryID 
AND cu.card_number = t.card_number 
AND s.storeID = t.storeID 
GROUP BY t.date_time, t.card_number;


