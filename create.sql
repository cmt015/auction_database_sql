CREATE DATABASE AuctionDB;
USE AuctionDB;
CREATE TABLE IF NOT EXISTS CLIENT(
  ClientID int NOT NULL AUTO_INCREMENT,
  Fname char(50) NOT NULL,
  Minit char(1),
  Lname char(50) NOT NULL,
  StreetNo char(100) NOT NULL,
  City char(60) NOT NULL,
  State char(50),
  Country char(55) NOT NULL,
  ZipCode char(9) NOT NULL,
  Sex enum('M', 'F', 'O') NOT NULL,
  DOB date NOT NULL,
  Pay_Info varchar(300),
  Company char(50),
  Phone char(15) UNIQUE NOT NULL,
  Email char(50) NOT NULL,
  Dealer bit NOT NULL,
  Bank_Ver bit DEFAULT 0, 
  PRIMARY KEY(ClientID)
);

CREATE TABLE IF NOT EXISTS EMPLOYEE(
  EmpID int NOT NULL AUTO_INCREMENT,
  Fname char(50) NOT NULL,
  Minit char(1),
  Lname char(50) NOT NULL,
  StreetNo char(50) NOT NULL,
  City char(60) NOT NULL,
  State char(50) NOT NULL,
  Country char(55) NOT NULL,
  ZipCode char(9) NOT NULL,
  SEX enum('M', 'F', 'O') NOT NULL,
  DOB date NOT NULL,
  SSN char(11) UNIQUE NOT NULL,
  Salary int NOT NULL,
  JobTitle char(50) NOT NULL,
  StartDate date NOT NULL,
  WorkPhone char(15),
  CellPhone char(15) UNIQUE NOT NULL,
  Marital bit,
  Email char(50) NOT NULL,
  PRIMARY KEY(EmpID)
);

CREATE TABLE IF NOT EXISTS AUCTION(
  AuctionID int NOT NULL AUTO_INCREMENT,
  Name char(100) NOT NULL,
  Auc_Date date NOT NULL,
  Buyers_Prem int DEFAULT 20,
  EmpID int NOT NULL,
  FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
  PRIMARY KEY(AuctionID)
);
CREATE TABLE IF NOT EXISTS ADVERTISEMENT(
  AdID int NOT NULL AUTO_INCREMENT,
  EmpID int NOT NULL,
  AuctionID int NOT NULL,
  FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
  FOREIGN KEY (AuctionID) REFERENCES AUCTION(AuctionID), 
  PRIMARY KEY(AdID)
);

CREATE TABLE IF NOT EXISTS CONSIGNMENT_AGREEMENT(
  ContractID int NOT NULL AUTO_INCREMENT,
  Date_Signed date NOT NULL,
  Com_Rate int NOT NULL,
  ClientID int NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENT(ClientID),
  PRIMARY KEY(ContractID)
);
CREATE TABLE IF NOT EXISTS CATEGORY(
  CName varchar(100) NOT NULL,
  PRIMARY KEY(CName)
);
CREATE TABLE IF NOT EXISTS ENQUIRY(
  EnquiryID int NOT NULL AUTO_INCREMENT,
  Description char(50) NOT NULL,
  Date_Sub date NOT NULL,
  Value_Est decimal,
  TouchUps varchar(500),
  Accept bit,
  CName varchar(100),
  FOREIGN KEY (CName) REFERENCES CATEGORY(CName),
  ClientID int NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENT(ClientID),
  EmpID int,
  FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
  PRIMARY KEY(EnquiryID)
);
CREATE TABLE IF NOT EXISTS SENT_TO(
  ClientID int NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENT(ClientID),
  AdID int NOT NULL,
  FOREIGN KEY (AdID) REFERENCES ADVERTISEMENT(AdID),
  PRIMARY KEY (ClientID, AdID)
);
CREATE TABLE IF NOT EXISTS INVOICE(
  InvoiceID  int NOT NULL AUTO_INCREMENT,
  total decimal,
  DateSent date,
  DatePaid date,
  ClientId int NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENT(Clientid),
  EmpId int NOT NULL,
  FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
  IStatus enum('C', 'U', 'P', 'D') DEFAULT 'C',
  PRIMARY KEY(InvoiceID)
);
CREATE TABLE IF NOT EXISTS LOT(
  LotID int NOT NULL AUTO_INCREMENT,
  LStatus enum('U', 'A', 'B', 'P', 'S') DEFAULT 'U',
  CountryOfOrigin char(55),
  YearCreated char(20),
  Creator char(50),
  LLocation char(100) NOT NULL,
  Photo varchar(300),
  LDescription varchar(300) NOT NULL,
  StartingPrice decimal NOT NULL,
  ContractID int NOT NULL,
  FOREIGN KEY (ContractID) REFERENCES CONSIGNMENT_AGREEMENT(ContractID),
  AuctionID int,
  FOREIGN KEY (AuctionID) REFERENCES AUCTION(AuctionID),
  LotNo int,
  PRIMARY KEY(LotID)
);
CREATE TABLE IF NOT EXISTS SUP_MAT(
  LotID int NOT NULL,
  FOREIGN KEY (LotID) REFERENCES LOT(LotID),
  Doc_Name varchar(50) NOT NULL,
  Descr varchar(500),
  PRIMARY KEY (LotID, Doc_Name)
);
CREATE TABLE IF NOT EXISTS OUTGOING_PAYMENT(
  PayID int NOT NULL AUTO_INCREMENT,
  Total decimal,
  DatePaid date,
  ContractID int NOT NULL,
  FOREIGN KEY (ContractID) REFERENCES CONSIGNMENT_AGREEMENT(ContractID),
  EmpID int NOT NULL,
  FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
  PRIMARY KEY(PayID)
);
CREATE TABLE IF NOT EXISTS LIKES(
  ClientId int NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENT(Clientid),
  CName varchar(100) NOT NULL,
  FOREIGN KEY (CName) REFERENCES CATEGORY(CName),
  PRIMARY KEY (ClientID, CName)
);
CREATE TABLE IF NOT EXISTS CATALOG(
  EnquiryID int NOT NULL,
  FOREIGN KEY (EnquiryID) REFERENCES ENQUIRY(EnquiryID),
  LotID int NOT NULL,
  FOREIGN KEY (LotID) REFERENCES LOT(LotID),
  EmpID int NOT NULL,
  FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID),
  Hours_ decimal DEFAULT 0, 
  Cat_Date date NOT NULL,
  Service_ char(100) NOT NULL,
  PRIMARY KEY (EnquiryID, LotID, EmpID, Service_)
);
CREATE TABLE IF NOT EXISTS DISPUTE(
  DisputeID int NOT NULL AUTO_INCREMENT,
  Description varchar(300) NOT NULL,
  DStatus enum('U', 'O', 'R') DEFAULT 'U',
  DateAlleged date NOT NULL,
  Resolution varchar(300),
  DateResolved date,
  ClientID int NOT NULL,
  FOREIGN KEY (ClientID) references Client(ClientID),
  EmpID int,
  FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
  LotID int,
  FOREIGN KEY (LotID) REFERENCES Lot(LotID),
  PRIMARY KEY(DisputeID)
);
CREATE TABLE IF NOT EXISTS WINNING_BID_PRICE(
  ClientID int NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENT(Clientid),
  LotID int UNIQUE NOT NULL,
  FOREIGN KEY (LotID) REFERENCES LOT(LotID),
  AuctionID int NOT NULL,
  FOREIGN KEY (AuctionID) REFERENCES AUCTION(AuctionID),
  Hammer_Price decimal NOT NULL,
  PRIMARY KEY (ClientID, LotID, AuctionID)
);
CREATE TABLE IF NOT EXISTS WINNING_BID_PAY(
  ClientID int NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES CLIENT(Clientid),
  AuctionID int NOT NULL,
  FOREIGN KEY (AuctionID) REFERENCES AUCTION(AuctionID),
  PayID int NOT NULL,
  FOREIGN KEY (PayID) REFERENCES OUTGOING_PAYMENT(PayID),
  PRIMARY KEY (ClientID, AuctionID, PayID)
);
CREATE TABLE IF NOT EXISTS WINNING_BID_INV(
  LotID int UNIQUE NOT NULL,
  FOREIGN KEY (LotID) REFERENCES LOT(LotID),
  AuctionID int NOT NULL,
  FOREIGN KEY (AuctionID) REFERENCES AUCTION(AuctionID),
  InvoiceID int NOT NULL,
  FOREIGN KEY (InvoiceID) REFERENCES INVOICE(InvoiceID),
  PRIMARY KEY (LotID, AuctionID, InvoiceID)
);