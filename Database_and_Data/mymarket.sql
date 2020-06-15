SET GLOBAL time_zone = '+3:00';
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
            street VARCHAR(20),
            address_number SMALLINT,
            postal_code CHAR(5),
            city VARCHAR(20),
            size SMALLINT,
            operating_hours CHAR(11),
            PRIMARY KEY(storeID));
            
CREATE TABLE market.telephone(
			storeID INT,
            telephone_number NUMERIC(10,0) NOT NULL,
            FOREIGN KEY (storeID) REFERENCES store(storeID),
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
            first_transaction DATETIME DEFAULT CURRENT_TIMESTAMP,
            categoryID INT,
            PRIMARY KEY(barcode),
            FOREIGN KEY(categoryID) REFERENCES category(categoryID));
            

            
CREATE TABLE market.provides(
			storeID INT,
            categoryID INT,
            PRIMARY KEY(storeID, categoryID),
            FOREIGN KEY(storeID) REFERENCES store(storeID),
            FOREIGN KEY(categoryID) REFERENCES category(categoryID));
            
CREATE TABLE market.offers(
			storeID INT,
            barcode VARCHAR(20),
            alley_number SMALLINT,
            shelf_number SMALLINT,
            PRIMARY KEY(storeID, barcode),
            FOREIGN KEY(storeID) REFERENCES store(storeID),
            FOREIGN KEY(barcode) REFERENCES product(barcode));
            
CREATE TABLE market.price_history(
			start_date DATETIME,
            barcode VARCHAR(20),
            price DOUBLE,
            end_date DATETIME,
            PRIMARY KEY(start_date, barcode),
            FOREIGN KEY(barcode) REFERENCES product(barcode));
            
CREATE TABLE market.product_transaction(
			date_time DATE,
            card_number INT,
            total_amount DOUBLE DEFAULT 0.0,
            payment_method CHAR(4) CHECK (payment_method in ('cash', 'card') OR NULL),
            total_pieces INT DEFAULT 0,
            storeID INT,
            PRIMARY KEY(date_time, card_number),
            FOREIGN KEY (storeID) REFERENCES store(storeID),
            FOREIGN KEY(card_number) REFERENCES customer(card_number));

CREATE TABLE market.product_contains(
			card_number INT,
            date_time DATE,
            barcode VARCHAR(20),
            pieces INT,
            PRIMARY KEY(card_number, date_time, barcode),
            FOREIGN KEY(card_number, date_time) REFERENCES product_transaction(card_number, date_time),
            FOREIGN KEY(barcode) REFERENCES product(barcode));
            



CREATE TRIGGER customer_age_calc BEFORE INSERT ON customer 
	FOR EACH ROW SET NEW.age = YEAR(NOW()) - YEAR(NEW.date_of_birth);
    


LOAD DATA INFILE 'C:/Users/user/Desktop/Customer.txt' INTO TABLE customer FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' (first_name,last_name,points,street,address_number,postal_code,city,family_members,pet,phone_number,date_of_birth);
INSERT INTO category (category_name) VALUES ('fresh products');
INSERT INTO category (category_name) VALUES ('chilled products');
INSERT INTO category (category_name) VALUES ('drinks');
INSERT INTO category (category_name) VALUES ('toiletries');
INSERT INTO category (category_name) VALUES ('homeware');
INSERT INTO category (category_name) VALUES ('pet products');
LOAD DATA INFILE 'C:/Users/user/Desktop/Store.txt' INTO TABLE store FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' (street,address_number,postal_code,city,size,operating_hours);
LOAD DATA INFILE 'C:/Users/user/Desktop/Telephone.txt' INTO TABLE telephone FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA INFILE 'C:/Users/user/Desktop/Products.txt' INTO TABLE product FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' (product_name,brand_name,price,barcode,categoryID,first_transaction);
LOAD DATA INFILE 'C:/Users/user/Desktop/Provides.txt' INTO TABLE provides FIELDS TERMINATED BY ',' (storeID, categoryID);
LOAD DATA INFILE 'C:/Users/user/Desktop/Offers.txt' INTO TABLE offers FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA INFILE 'C:/Users/user/Desktop/Price_history.txt' INTO TABLE price_history FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (start_date, barcode, price, @var) SET end_date = NULLIF(@var, 0000-00-00);

DELIMITER $$
CREATE TRIGGER hard
AFTER INSERT ON product_contains FOR EACH ROW
Begin
	DECLARE x DOUBLE;
    SELECT price INTO @x FROM product WHERE barcode = NEW.barcode;
    UPDATE product_transaction
    SET total_amount = CAST(total_amount + @x*(CAST(NEW.pieces AS DOUBLE)) AS DECIMAL(10,2))
    WHERE product_transaction.date_time = NEW.date_time AND product_transaction.card_number = NEW.card_number;
END;
$$
DELIMITER ;

DROP TRIGGER hard;
TRUNCATE TABLE product_CONTAINS;