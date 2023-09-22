INSERT INTO CLIENT(Fname, Minit, Lname, StreetNo, City, State, Country, ZipCode, Sex, DOB, Pay_Info, Company, Phone, Email, Dealer, Bank_Ver)
 	VALUES('Hally', 'M', 'Berry', '304 Peachtree Blvd', 'Atlanta', 'GA', 'USA', '30328', 'F', '1982-04-26', 'Credit Card No', 'Stars Unite', '704-992-2326', 'hallyberry@gmail.com', 0, 0);
INSERT INTO CLIENT(Fname, Lname, StreetNo, City, State, Country, ZipCode, Sex, DOB, Phone, Email, Dealer)
	VALUES('Helen', 'Mirren', '459 Honors Ave', 'Tallahassee', 'FL', 'USA', '22548', 'F', '1952-07-09', '771-546-5512', 'hmirren@starsacademy.com', 0);
INSERT INTO CLIENT(Fname,Minit,Lname, StreetNo, City, State, Country, ZipCode, Sex, DOB, Pay_Info, Company, Phone, Email, Dealer, Bank_Ver)
    VALUES('Craig', 'b', 'Jackson', '555', 'ATL',' Georgia', 'United States', '30305', 'M', '1999-04-23', 'Debit/Credit Card', 'Charter','359-888-4564', 'CJack@gmail.com', 0, 0),
    ('Gordon', 'i', 'Tillington', '555', 'ATL',' Georgia', 'United States', '30305', 'M', '1999-04-23', 'Debit/Credit Card', 'Charter', '456-545-5654','GTill@gmail.com', 0, 0),
    ('Bob', 't', 'Smith', '555', 'ATL',' Georgia', 'United States', '30305', 'M', '1999-04-23', 'Debit/Credit Card', 'Charter', '124-555-5265','BobSmith@gmail.com', 0, 0);
SELECT * FROM CLIENT;
INSERT INTO EMPLOYEE(Fname, Minit, Lname, StreetNo, City, State, Country, ZipCode, Sex, DOB, SSN, Salary, JobTitle, StartDate, WorkPhone, CellPhone, Marital, Email)
	VALUES('Sandy', 'P', 'Carter', '1700 Sherwood Ln', 'Knoxville', 'TN', 'USA', '15948', 'F', '1972-08-22', '165-99-4852', 70000, 'Inventory Management and Cataloging', 
		'2006-10-14', '568-456-7654', '568-232-1523', 1, 'spcarter@antiquesellers.com'),
        ('Jason', 'B', 'Waterson', '4590 Forest Dr', 'Chattanooga', 'TN', 'USA', '54658', 'M', '1987-05-26', '153-24-3488', 65000, 'Photography Director and Media Management', 
		'2015-02-21', '456-645-8785', '456-898-2231', 0, 'watergunsons@gmail.com'),
        ('William', 'S', 'Bates', '550 Green Hill Ct', 'Knoxville', 'TN', 'USA', '51532', 'M', '1965-04-28', '153-24-6585', 80000, 'General Manager and Auctioneer', 
		'2004-03-02', '568-232-1234', '568-787-4512', 1, 'wsbates@antiquesellers.com'),
        ('Ellen', NULL, 'Lane', '2122 Shady ln', 'Sevierville', 'TN', 'USA', '12125', 'F', '1990-02-28', '845-55-1212', 50000, 'Catalog and Consignment Specialist', 
        '2016-10-22', NULL, '898-125-5564', 0, 'elane@antiquesellers.com');
SELECT * FROM EMPLOYEE;
INSERT INTO CONSIGNMENT_AGREEMENT(Date_Signed, Com_Rate, ClientID)
	VALUES('2022-01-12', 28, 2),
    ('2022-03-15', 20, 1);
SELECT * FROM CONSIGNMENT_AGREEMENT;

INSERT INTO CATEGORY
	VALUES('Tableware'), ('Lighting'), ('Jewelry'), ('Painting: Portrait'), ('Rug'), ('Decorative: Oriental');
INSERT INTO AUCTION(Name, Auc_Date, Buyers_Prem, EmpID)
	VALUES('Ancient China', '2018-08-18', 28, 3), 
		('Magnolia Party', '2021-09-09', 25, 3), 
        ('Suitcase Party', '2022-01-30', 20, 3),
        ('Spring Table 2022', '2022-04-01', 20, 3);
SELECT * FROM AUCTION;
INSERT INTO ENQUIRY(Description, Date_Sub, Value_Est, TouchUps, Accept, CName, ClientID, EmpID)
	VALUES('8 Crystal Goblets', '2021-12-26', 500, NULL, 1, 'Tableware', 2, 1), -- 1
	('Jade Vase, Oriental', '2021-12-26', 1100, NULL, 1, 'Decorative: Oriental', 2, 1), -- 2
	('King Richard 4pc', '2022-01-20', 300, NULL, 0, 'Tableware', 3, 1), -- 3
	('Abalone Linen Desk Lamp', '2022-03-01', 25000, NULL, 1, 'Lighting', 1, 1), -- 4
	('8 Copeland Wide Rim Soup Bowls', '2022-03-01', 2000, NULL, 1, 'Tableware', 1, 1), -- 5
	('18" Pearl Necklace', '2022-03-01', 4000, NULL, 1, 'Jewelry', 1, 1), -- 6
	('10X12 Persian Rug', '2022-03-01', 400, 'Discoloration', 0, 'Rug', 1, 1), -- 7
	('Oil Portrait of Woman in Hat', '2022-03-01', 200, 'Discoloration, water damage', 0, 'Painting: Portrait', 1, 1); -- 8  

INSERT INTO LOT(CountryOfOrigin, YearCreated, Creator, LLocation, LDescription, StartingPrice, ContractID, AuctionID, LotNo)
	VALUES('Ireland', '1900', 'Waterford', 'Warehouse 5, Aisle 10, 4400', '8 Crystal Goblets', 500, 1, 4, 5), -- 1
    ('China', '1920s', NULL, 'Warehouse 5, Aisle 2, 2250', 'Jade Vase, Oriental', 1100, 1, 4, 4), -- 2
    ('New York', '1910', 'Tiffany', 'Warehouse 4, Aisle 7, 3000', 'Abalone Linen Desk Lamp', 25000, 2, 4, 6), -- 3
    ('England', '1850s-1860s', 'Spode', 'Warehouse 4, Aisle 2, 1500', '8 Copeland Wide Rim Soup Bowls', 2000, 2, 4, 3), -- 4
    ('Japan', '1960s', 'Mikimoto', 'Warehouse 2, Aisle 5, 2000', '18" Pearl Necklace', 4000, 2, 4, 1); -- 5
SELECT * FROM LOT;
INSERT INTO CATALOG(EnquiryID, LotID, EmpID, Hours_, Cat_Date, Service_)
	VALUES(1, 1, 4, 0, '2022-01-31', 'General'),
    (1, 1, 2, 0, '2022-01-31', 'Photography'),
    (2, 2, 4, 0, '2022-01-31', 'General'),
    (2, 2, 2, 0, '2022-01-31', 'Photography'),
    (4, 3, 1, 1, '2022-03-25', 'General & Photography'),
    (5, 4, 1, 0, '2022-03-25', 'General & Photography'),
    (6, 5, 1, 0, '2022-03-25', 'General & Photography');


INSERT INTO WINNING_BID_PRICE(ClientID, LotID, AuctionID, Hammer_Price)
	VALUES(4, 1, 4,	850),
    (3,	2, 4, 1620),
    (5, 3, 4, 32000),
    (4, 4, 4, 2800),
    (2, 5, 4, 6000);
SELECT * FROM WINNING_BID_PRICE;

INSERT INTO ADVERTISEMENT(EmpID, AuctionID)
	VALUES(1,1),
        (2,2),
        (2,1),
        (2, 4);
INSERT INTO LIKES
VALUES(2,'JEWELRY'),
      (3,'RUG'),
      (1, 'TABLEWARE'),
      (4, 'DECORATIVE: ORIENTAL');
INSERT INTO OUTGOING_PAYMENT(Total, DatePaid, ContractID, EmpID)
	VALUES(32640, '22-04-15', 2, 1),
    (1778.4, '22-04-15', 1,	4);
INSERT INTO INVOICE(Total, DateSent, DatePaid, ClientID, IStatus, EmpID)
	VALUES(7200, '2022-04-02', '2022-04-05', 2, 'P', 1), 
    (1944, '2022-04-02', '2022-04-07', 3, 'P', 1),
    (4380, '2022-04-02', '2022-04-09', 4, 'P', 1),
    (38400, '2022-04-02', '2022-04-04', 5, 'P', 1);
INSERT INTO WINNING_BID_INV
	VALUES(5, 4, 1),
    (2, 4, 2), 
    (1, 4, 3), 
    (4, 4, 3),
    (3, 4, 4);
INSERT INTO WINNING_BID_PAY -- ClientID, AuctionID, PayID
	VALUES(1, 4, 1),
    (2, 4, 2);
INSERT INTO SENT_TO(ClientID, AdID)
VALUES(1,4),
      (3,4),
      (2,4),
      (4,4);
INSERT INTO DISPUTE(Description, DStatus,DateAlleged, ClientID)
VALUES('Wrong items shipped','U', '2019-03-29', 1),
      ('Wrong items ordered','U', '2020-10-10', 2),
      ('Wrong items chosen','U', '2010-01-01', 3);