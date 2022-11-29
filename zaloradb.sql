drop database if exists zalora_db;
create database zalora_db;
use zalora_db;

drop table if exists address;
CREATE TABLE address (
    postal_code CHAR(7) NOT NULL PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    block_no VARCHAR(8),
    city VARCHAR(20) NOT NULL
);

drop table if exists customer;
CREATE TABLE customer (
    customer_id CHAR(8) NOT NULL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    unit_no VARCHAR(8) NOT NULL,
    postal_code CHAR(7) NOT NULL,
    contact_no INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    CONSTRAINT customer_fk FOREIGN KEY (postal_code)
        REFERENCES address (postal_code)
);


drop table if exists courier;
CREATE TABLE courier (
    courier_id CHAR(8) NOT NULL PRIMARY KEY,
    courier_name VARCHAR(20) NOT NULL,
    unit_no VARCHAR(8) NOT NULL,
    postal_code CHAR(7) NOT NULL,
    courier_contact INT NOT NULL,
	CONSTRAINT courier_fk FOREIGN KEY (postal_code)
        REFERENCES address (postal_code)
);

drop table if exists product;
CREATE TABLE product (
    product_id CHAR(10) NOT NULL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    unit_price DECIMAL(6 , 2 ) NOT NULL,
    product_type VARCHAR(10) NOT NULL,
    total_quantity INT NOT NULL
);

drop table if exists cardno;
CREATE TABLE cardno (
    card_no CHAR(16) NOT NULL PRIMARY KEY,
    expiry_date DATE NOT NULL,
    cvc INT NOT NULL
);

drop table if exists card;
CREATE TABLE card (
    customer_id CHAR(8) NOT NULL,
    card_no CHAR(16) NOT NULL,
    CONSTRAINT card_pk PRIMARY KEY (customer_id , card_no),
    CONSTRAINT card_fk1 FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id),
	CONSTRAINT card_fk2 FOREIGN KEY (card_no)
        REFERENCES cardno (card_no)
);

drop table if exists customerorder;
CREATE TABLE customerorder (
    order_id CHAR(8) NOT NULL PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id CHAR(8) NOT NULL,
    card_no CHAR(16) NOT NULL,
    CONSTRAINT order_fk FOREIGN KEY (customer_id , card_no)
        REFERENCES card (customer_id , card_no)
);

drop table if exists ordersummary;
CREATE TABLE ordersummary (
    order_id CHAR(8) NOT NULL,
    courier_id CHAR(8) NOT NULL,
    product_id CHAR(10) NOT NULL,
    ordered_quantity INT NOT NULL,
    CONSTRAINT ordersummary_pk PRIMARY KEY (order_id , courier_id , product_id),
    CONSTRAINT ordersummary_fk1 FOREIGN KEY (order_id)
        REFERENCES customerorder (order_id),
    CONSTRAINT ordersummary_fk2 FOREIGN KEY (courier_id)
        REFERENCES courier (courier_id),
    CONSTRAINT ordersummary_fk3 FOREIGN KEY (product_id)
        REFERENCES product (product_id)
);

drop table if exists rating;
CREATE TABLE rating (
    rating_id CHAR(5) NOT NULL PRIMARY KEY,
    review_date DATE NOT NULL,
    rating_score INT NOT NULL,
    review_description VARCHAR(200),
    order_id CHAR(8) NOT NULL,
    courier_id CHAR(8) NOT NULL,
    product_id CHAR(10) NOT NULL,
    CONSTRAINT rating_fk FOREIGN KEY (order_id , courier_id , product_id)
        REFERENCES ordersummary (order_id , courier_id , product_id)
);

drop table if exists bundle;
CREATE TABLE bundle (
    product_id CHAR(10) NOT NULL,
    bundle_id CHAR(10) NOT NULL,
    item_quantity INT,
    CONSTRAINT bundle_pk PRIMARY KEY (product_id,bundle_id),
    CONSTRAINT bundle_fk1 FOREIGN KEY (product_id)
        REFERENCES product (product_id),
	CONSTRAINT bundle_fk2 FOREIGN KEY (bundle_id)
        REFERENCES product (product_id)
);

drop table if exists fashion;
CREATE TABLE fashion (
    f_product_id CHAR(10) NOT NULL PRIMARY KEY,
    size VARCHAR(10) NOT NULL,
    CONSTRAINT fashion_fk FOREIGN KEY (f_product_id)
        REFERENCES product (product_id)
);

drop table if exists beauty;
CREATE TABLE beauty (
    b_product_id CHAR(10) NOT NULL PRIMARY KEY,
    expiry_date DATE NOT NULL,
    CONSTRAINT beauty_fk FOREIGN KEY (b_product_id)
        REFERENCES product (product_id)
);

drop table if exists tech;
CREATE TABLE tech (
    t_product_id CHAR(10) NOT NULL PRIMARY KEY,
    warranty_months INT NOT NULL,
    CONSTRAINT tech_fk FOREIGN KEY (t_product_id)
        REFERENCES product (product_id)
);

#inserting data
insert into address values
('S636954','Tampines Street 31','56','Singapore'),
('S396869','Castle Street 12','3','Singapore'),
('S636929','Orchard Road 68','9','Singapore'),
('S131313','Cornelia Street 12','13','Singapore'),
('S985632','Hougang Street 31','123','Singapore'),
('S385748','Sentosa Street 92','12','Singapore'),
('S626682','Tampines Grove 13','2','Singapore'),
('S689868','Tampines Road 12','24','Singapore'),
('S258517','Little Istana 34',NULL,'Singapore'),
('S896368','Yishun Street 01','53','Singapore'),
('S963258','Simei Street 76','965','Singapore'),
('S865968','Bedok Street 12','64C','Singapore'),
('S633685','Harry Grove 3','24','Singapore'),
('S869595','Toa Payoh 78','924B','Singapore'),
('S456985','Jurong Street 12','65','Singapore'),
('S569863','Lany Road 24','45','Singapore'),
('S621686','Ubi Road 34','86B','Singapore'),
('S587875','Changi Road','47','Singapore'),
('S322686','Ubi Street 10','68','Singapore'),
('S399869','Jurong Street 92','34','Singapore'),
('S625368','Changi Road 35','24','Singapore'),
('S698986','Ubi Street 54',NULL,'Singapore'),
('S696998','Lany Road 12','89','Singapore'),
('S698698','Jurong Lane 64','24','Singapore'),
('S665368','Ubi Lane 34','56','Singapore'),
('S698526','Mapletree City','69','Singapore'),
('S889968','Ubi Lane 532','23','Singapore'),
('S963686','Jurong Lane 10','62','Singapore'),
('S972084','Lany Street 10',NULL,'Singapore'),
('S936986','Ubi Lane 01','68','Singapore');

insert into cardno values
('4485181349190300', '2023-09-06', 515),
('5272221502946215', '2023-12-29', 705),
('4716131479585572', '2025-07-26', 430),
('5472374119912464', '2026-05-28', 455),
('4539179732803253', '2027-11-30', 489),
('5243089237822688', '2025-01-26', 301),
('4539839761871683', '2026-09-17', 988),
('5218660889469159', '2027-02-05', 851),
('4848795625582583', '2023-06-07', 538),
('5396533420981780', '2025-12-22', 354),
('4929428544962122', '2024-07-20', 132), 
('5449696310668697', '2026-02-16', 945),
('4716335246477787', '2023-02-24', 188),
('5309551438455767', '2027-07-06', 406),
('4716021980954708', '2025-10-21', 156)
;

insert into customer values
('S1658344', 'Hakim', 'Zahrin', 'ben.dover@gmail.com','#04-85','S636954', 82958611,'Male'),
('S9618326', 'Joelle', 'Tan', 'Joel123@yahoo.com','#05-85','S963258',86923685,'Male'),
('S9863652','Shi Hao', 'Ang', 'SH123@gmail.com', '#16-98','S456985', 91457585,'Male'),
('S5577514', 'Venus', 'Lim', 'VenusJupiterMars@gmail.com', '#09-12','S985632', 68582595,'Female'),
('S6986325', 'Ting','Ting', 'TT@gmail.com', '#01-24', 'S689868', 63391248, 'Female'),
('S6985626', 'Eugene', 'Lim', 'Lim@gmail.com', '#07-57', 'S626682', 82268569, 'Male'), 
('S3686598', 'Emily', 'Mary', 'Emary@gmail.com', '#03-97', 'S636929', 66239868, 'Female'),
('S3326685', 'Meghan', 'Markle', 'Iamthequeen@gmail.com',  '#03-03',  'S396869', 89546685, 'Female'), 
('S5236869', 'Taylor', 'Swift', 'Midnight@gmail.com',  '#13-13',  'S131313', 86139613, 'Female'),
('S8963156', 'Halimah', 'Tan', 'Iamthepresident@gmail.com','#12-56', 'S258517', 82695698, 'Female'),
('S9633361', 'Harry', 'Style', 'Duriansugar@gmail.com',  '#05-23', 'S633685', 89695869, 'Male'),
('S9683689', 'Obama', 'Lim', 'whitehouse@gmail.com',  '#05-29',  'S869595', 86523674, 'Male'),
('S6836986', 'Alice', 'Bay', 'Wonderland@gmail.com',  '#02-23',  'S385748', 85264498, 'Female'),
('S9369354', 'Ling Xi', 'Long', 'LLX@gmail.com',  '#08-23', 'S896368', 68633152, 'Female'), 
('S9632589', 'Tom', 'Victor', 'Tommy@gmail.com',  '#05-05', 'S865968', 91789738, 'Male'); 
 
insert into courier values
('89626986', 'DHL', '#01-54', 'S698526', 98693632), 
('45856895', 'LHD',  '#01-02',  'S587875', 98635441), 
('12136898', 'NinjaVan',  '#01-04', 'S569863', 98145868), 
('68635685', 'NinjaCar',  '#04-24', 'S698986', 89966985),
('24878912', 'GogoVan',  '#07-23', 'S621686', 66986265), 
('63269868', 'GogoMotor',  '#08-12',  'S399869', 82986858),
('63686989', 'FedEx',  '#03-02', 'S625368', 89363658), 
('96869862', 'XpressGo',  '#01-42',  'S936986', 66989868),
('86698986', 'SpeedEx',  '#05-12',  'S665368', 85698569),
('89669868', 'Safexpress',  '#09-12',  'S963686', 86368698), 
('96832586', 'ProSpeeder',  '#01-12',  'S972084', 97569228),
('62268689', 'F1delivery',  '#01-32',  'S322686', 89689109), 
('69869898', 'GotoDelivery',  '#06-23',  'S698698', 99800985), 
('89636898', 'ExpressSpeed',  '#01-24',  'S889968', 89821068), 
('68989686', 'Speeder',  '#06-12',  'S696998', 67989808);

insert into card values 
('S1658344', '4485181349190300'),
('S3326685', '5272221502946215'),
('S3686598', '4716131479585572'),
('S5236869', '5472374119912464'),
('S5577514', '4539179732803253'),
('S6836986', '5243089237822688'),
('S6985626', '4539839761871683'),
('S6986325', '5218660889469159'),
('S8963156', '4848795625582583'),
('S9369354', '5396533420981780'),
('S9618326', '4929428544962122'), 
('S9632589', '5449696310668697'),
('S9633361', '4716335246477787'),
('S9683689', '5309551438455767'),
('S9863652', '4716021980954708')
;

insert into product values
('FH98689868', 'Nike Bag', '126.60', 'Fashion', 5),
('FH63689868', '2XU Tights', '90.30', 'Fashion', 18),
('FH68986386', 'Under Armour Shirt', '45.00', 'Fashion', 34), 
('FH63698986', 'New Balance Socks', '12.50', 'Fashion', 45),
('FH69589858', 'Adidas Shoes', '189.00', 'Fashion', 43),
('FH92878783', 'Lululemon Tights','76.50','Fashion', 23),
('FH98760905', 'Fila Cap','23.40','Fashion',19),
('FH92749875', 'New Balance Shoes','145.60','Fashion', 25),
('BT98663968', 'Estee Lauder Make Up','89.10', 'Beauty', 20), 
('BT98369898', 'Dior Lip Balm', '56.99', 'Beauty', 45), 
('BT17293890', 'Dior Mascara', '47.00', 'Beauty', 20), 
('BT98635235', 'Dior Powder', '68.45', 'Beauty', 32), 
('BT98632565', 'SK2 Miracle Water', '265.35', 'Beauty', 45), 
('BT90923452', 'The Ordinary Concealer','254.50','Beauty',30),
('BT90238722', 'Jo Malone Fragance', '184.00','Beauty', 28),
('BT29485725', 'Lush Hand Cream', '78.00','Beauty', 8),
('TE68986585', 'Sony Headphone', '321.50', 'Technology', 36),
('TE56898568', 'Samsung Galaxy Flip4', '1638.50', 'Technology', 26), 
('TE68689868', 'Samsung Galaxy Buds', '218.50', 'Technology', 53),
('TE67846656', 'Samsung Galaxy Portable Charger', '34.00','Technology', 24),
('TE86989868', 'Sonos Speaker', '629.00', 'Technology', 17),
('TE69858682', 'GoPro Hero 10', '680.00', 'Technology', 24),
('TE91284728', 'Jabra Elite Earphone', '238.00', 'Technology',10),
('TE12983739', 'Xiaomi Redmi Phone', '668.00', 'Technology', 13),
('TE12948573', 'Garmin Watch', '499.00', 'Technology', 4),
('BFH3232145', 'New Balance Footwear Bundle', '149.90', 'Fashion', 4),
('BBT9878977', 'Dior Beauty Family Bundle', '449.90', 'Beauty', 3),
('BBT4335335', 'Bestie Fragrance Bundle', '299.90', 'Beauty', 5),
('BTE0019282', 'Samsung Phone Bundle', '1749.90', 'Technology', 10),
('BTE7481438', 'Music Lover Bundle', '899.90', 'Technology', 5)
;

insert into fashion values
('FH98689868', 'M'),
('FH63689868', 'L'),
('FH68986386', 'XS'), 
('FH63698986', 'EU38'),
('FH69589858', 'UK10'),
('FH92878783', 'XS'),
('FH98760905', 'XL'),
('FH92749875', 'US5');

insert into tech values
('TE68986585', 24),
('TE56898568', 12), 
('TE68689868', 12),
('TE67846656', 36),
('TE86989868', 60),
('TE69858682', 24),
('TE91284728', 12),
('TE12983739', 12),
('TE12948573', 36);

insert into beauty values
('BT98663968', '2023-10-30'), 
('BT98369898', '2022-12-18'), 
('BT17293890', '2023-08-29'), 
('BT98635235', '2022-11-26'), 
('BT98632565', '2023-11-09'), 
('BT90923452','2022-12-31'),
('BT90238722', '2022-12-24'),
('BT29485725', '2022-11-30');

insert into customerorder values
('O4816591', '2022-10-06', 'S3686598', '4716131479585572'),
('O1787083', '2022-10-09', 'S6836986', '5243089237822688'),
('O1433913', '2022-10-23', 'S9632589', '5449696310668697'),
('O4596025', '2022-10-30', 'S5577514', '4539179732803253'), 
('O8832416', '2022-10-16', 'S6836986', '5243089237822688'),
('O6462938', '2022-10-28', 'S9618326', '4929428544962122'),
('O7729324', '2022-10-11', 'S9632589', '5449696310668697'),
('O2241692', '2022-10-10', 'S1658344', '4485181349190300'),
('O5480967', '2022-10-25', 'S9369354', '5396533420981780'),
('O6369560', '2022-10-19', 'S9863652', '4716021980954708'),
('O8394262', '2022-10-12', 'S5236869', '5472374119912464'),
('O9558845', '2022-10-14', 'S6985626', '4539839761871683'),
('O3708134', '2022-10-21', 'S8963156', '4848795625582583'),
('O9538512', '2022-10-20', 'S3326685', '5272221502946215'),
('O3186074', '2022-10-03', 'S3686598', '4716131479585572')
;

insert into bundle values
('FH63698986', 'BFH3232145', 2),
('FH92749875', 'BFH3232145', 2),
('BT98369898', 'BBT9878977', 3),
('BT17293890', 'BBT9878977', 3),
('BT98635235', 'BBT9878977', 3),
('BT90238722', 'BBT4335335', 2),
('BT29485725', 'BBT4335335', 2),
('TE56898568', 'BTE0019282', 1),
('TE68689868', 'BTE0019282', 1),
('TE67846656', 'BTE0019282', 1),
('TE68986585', 'BTE7481438', 1),
('TE86989868', 'BTE7481438', 1)
;

insert into ordersummary values
('O4816591', '69869898', 'TE12948573', 2),
('O1787083', '96832586', 'TE69858682', 1),
('O1433913', '63686989', 'TE86989868', 1),
('O4596025', '68989686', 'BT98663968', 2), 
('O8832416', '12136898', 'TE68986585', 1),
('O6462938', '12136898', 'TE68986585', 1),
('O7729324', '96832586', 'BTE0019282', 1),
('O2241692', '96832586', 'BT90238722', 2),
('O5480967', '63686989', 'FH92749875', 1),
('O6369560', '68989686', 'FH68986386', 3),
('O8394262', '63269868', 'BT90238722', 1),
('O9558845', '63686989', 'BT17293890', 1),
('O3708134', '63686989', 'BTE7481438', 1),
('O9538512', '68635685', 'FH98689868', 2),
('O3186074', '68635685', 'BFH3232145', 1)
;

insert into rating values
('R1383', '2022-10-09', 5, 'speedy delivery', 'O4816591', '69869898', 'TE12948573'),
('R1384', '2022-10-14', 4, 'love it! the quality is amazing and the package was well-wrapped.', 'O1787083', '96832586', 'TE69858682'),
('R1385', '2022-10-30', 3, 'great sound quality, just what i was looking for. the delivery took a little longer than expected though', 'O1433913', '63686989', 'TE86989868'),
('R1386', '2022-11-02', 1, 'product had cracks', 'O4596025', '68989686', 'BT98663968'),
('R1387', '2022-11-02', 5, 'great sound quality and comfortable. like the noise cancelling effect', 'O6462938', '12136898', 'TE68986585'),
('R1388', '2022-10-16', 4, 'good deal!', 'O7729324', '96832586', 'BTE0019282'),
('R1389', '2022-10-16', 5, 'bought one for myself and my mom. mom approves and loves the citrus scent!', 'O2241692', '96832586', 'BT90238722'),
('R1390', '2022-10-25', 4, 'very breathable for the singapore weather. measurements are true to size', 'O6369560', '68989686', 'FH68986386'),
('R1391', '2022-10-17', 2, 'scent doesnt really suit me, will give it away to friends', 'O8394262', '63269868', 'BT90238722'),
('R1392', '2022-10-18', 1, 'bought it because of the hype but its clumpy and not waterproof. would not purchase again', 'O9558845', '63686989', 'BT17293890'),
('R1393', '2022-10-26', 4, 'great bundle deal, worth the price', 'O3708134', '63686989', 'BTE7481438'),
('R1394', '2022-10-26', 4, 'spacious and great as a gym bag', 'O9538512', '68635685', 'FH98689868'),
('R1395', '2022-10-08', 2, 'true to size. comfortable', 'O3186074', '68635685', 'BFH3232145')
;



#Queries
# Query 1
##Find the most popular product category for females based on the number of products sold. (in terms of quantity bought)
WITH popularity AS
	(SELECT 
		gender, product_type, SUM(ordered_quantity) AS total_qty
    FROM 
		ordersummary os, product p, customer c, customerorder co
    WHERE 
		os.product_id = p.product_id AND os.order_id = co.order_id 
        AND c.customer_id = co.customer_id AND gender = 'Female'
    GROUP BY 
		gender, product_type)
SELECT 
    *
FROM
    popularity
WHERE
    total_qty = (SELECT MAX(total_qty) FROM popularity);
    
# Query 2
## Retrieve the reviews where ‘delivery' is mentioned. The query function should show the RatingID, corresponding Courier, Rating and Description.
## This query function allows Zalora to understand rating scores that were impacted by delivery. Zalora can use this information to evaluate their couriers and offer shipping offers to those who had negative reviews for their last mile experience.
SELECT 
    rating_id AS RatingID,
    courier_name AS Courier,
    rating_score AS Rating,
    review_description AS Description
FROM
    rating r,
    courier cu
WHERE
    r.courier_id = cu.courier_id
        AND ROUND((LENGTH(review_description) - LENGTH(REPLACE(review_description,
                        'delivery',
                        ''))) / LENGTH('delivery')) <> 0;


# Query 3
## Return all of Zalora’s customers that have given a bad rating (Rating = 1). The query function should show the customer’s 
## full name and email address.
## This query function identifies customers who had a bad experience shopping with Zalora. From here, Zalora can send out 
## apology emails to these customers, allowing them to rectify the relationship and improve the company’s reputation. 

SELECT 
    CONCAT(first_name, ' ', Last_Name) AS fullname, email
FROM
    customer c, customerorder co, rating r
WHERE
    c.customer_id = co.customer_id
        AND co.order_id = r.order_id
        AND r.product_id IN (SELECT 
            product_id
        FROM
            rating
        WHERE
            rating_score < 2)
            
	AND r.order_id IN (SELECT 
            order_id
        FROM
            rating
        WHERE
            rating_score < 2);
        
        
# Query 4
## Return Zalora’s top customers, based on frequency of orders for the month of October. The query function should show the 
## customer’s full name, gender, customer ID and the type, name, quantity of the product ordered as well as the order date. 
## This query function identifies Zalora’s top customers and helps them better understand their loyal customers. 
## Zalora can consider providing incentives through offers similar to their recent purchases to incentivise their loyal customers 
## to spend more. 

WITH top_customers AS
	(SELECT 
		concat(first_name,' ',last_name) AS full_name, gender, c.customer_id, 
        COUNT(os.product_id) AS num_orders
	FROM
		customerorder co, ordersummary os, product p, customer c
	WHERE
		co.customer_id = c.customer_id
			AND co.order_id = os.order_id AND os.product_id = p.product_id
			AND MONTH(order_date) = 10
	GROUP BY c.customer_id)

SELECT 
 full_name, gender, t.customer_id, product_type, product_name, ordered_quantity, order_date
FROM
 top_customers t, product p, customerorder co, ordersummary os
WHERE
 t.customer_id = co.customer_id 
 AND co.order_id = os.order_id AND os.product_id = p.product_id AND 
 num_orders = (SELECT MAX(num_orders) FROM top_customers)
 ORDER BY full_name, order_date;

# Query 5
## Return all beauty products that are expiring this year (i.e. 2022). 
## The query function should show the ID, name and expiry date of the product as well as the current stock level.
## This query function identifies products that are expiring. This helps Zalora’s Operations team to manage the expiring 
## inventory and informs the Commercial team to place new orders for the identified beauty products. 

WITH orders as
(SELECT p.product_name, 
  CASE WHEN sum(ordered_quantity) is null then 0
        ELSE sum(ordered_quantity)
        END AS total_ordered 
FROM product p LEFT JOIN ordersummary os ON os.product_id = p.product_id 
GROUP BY p.product_name)

SELECT 
    exptable.b_product_id AS Product_ID,
    stktable.product_name AS Product_Name,
    exptable.expiry_date AS Expiry_Date,
    stktable.stock_level AS Stock_level
FROM
(SELECT 
        b.b_product_id, p.product_name,b.expiry_date, 
        CASE WHEN b.expiry_date <= '2022-12-31' THEN 'Expired' ELSE 'Not Expired'
            END AS Expiry_Status
    FROM
        beauty b, product p
    WHERE
        b_product_id = product_id) as exptable INNER JOIN
(SELECT 
        DISTINCT p.product_name,
   CASE WHEN p.product_id IN (SELECT product_id FROM ordersummary) 
   THEN (total_quantity - total_ordered) ELSE total_quantity
   END AS stock_level
    FROM
        orders o LEFT JOIN product p ON o.product_name = p.product_name 
        LEFT JOIN ordersummary os ON os.product_id = p.product_id) AS stktable
        ON exptable.product_name = stktable.product_name
        AND exptable.expiry_status = "Expired"
ORDER BY Expiry_Date;

