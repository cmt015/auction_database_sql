USE AuctionDB;
-- MY
/*1. Generate Auction Catalog: Generate a list of the lots in an auction, including the lot
number, the title and description, a thumbnail picture, and the low and high estimates for
market value.*/
SET @Auction.AuctionID:= 4;
SELECT A.Name, L.LotID, L.LDescription, L.Photo, L.StartingPrice, W.Hammer_Price
FROM Lot L, Auction A, WINNING_BID_PRICE W
WHERE  A.AuctionID = @Auction.AuctionID AND L.AUCTIONID = A.AUCTIONID AND W.LotID = L.LotID;
-- CHRISTINE
/*2. Generate Outgoing Payment Report: list of items auctioned by client in an auction
includes the lot number, the title and description, the hammer price, the commission
amount, and the total amount owed to the client for that lot (hammer price minus alter
commission amount).*/
SET @Seller:=2;
SET @Auction2:=4;
SELECT L.LotID, L.LDescription AS 'Description', W.Hammer_Price AS 'Hammer Price', 
		(C.Com_Rate / 100) * W.Hammer_Price AS 'Commission Amount', 
        W.Hammer_Price*(1 - (C.Com_Rate / 100)) AS 'Total'
FROM LOT L, WINNING_BID_PRICE W, CONSIGNMENT_AGREEMENT C
WHERE C.ClientID = @Seller AND L.ContractID = C.ContractID 
		AND L.LotID = W.LotID AND W.AuctionID = @Auction2;
-- CHRISTINE
/*3. Generate Invoice Lots List: list of items won by client, with lot number, description, 
the hammer price, the buyers premium, and the total.*/
SET @Buyer:=4;
SET @Auction3:=4;
SELECT L.LotID, L.LDescription AS 'Description', W.Hammer_Price AS 'Hammer Price',
		(W.Hammer_Price*(A.Buyers_Prem/100)) AS "Buyer's Premium", W.Hammer_Price*((100 + A.Buyers_Prem)/100) AS 'Total'
FROM LOT L, WINNING_BID_PRICE W, AUCTION A
WHERE W.ClientID = @Buyer AND A.AuctionID = @Auction3 
		AND A.AuctionID = W.AuctionID AND W.LotID = L.LotID;

-- MY
/*4. Generate Consignment Agreement: list of items to be auctioned for consigner, including
the title, description, estimated value, the minimum bid, and the minimum raise.*/
SET @ContractID := 2;
SELECT C.ContractID, L.LDescription, L.StartingPrice, W.Hammer_Price, W.Hammer_Price - L.StartingPrice as MaxRaise
FROM CONSIGNMENT_AGREEMENT C, Lot L, WINNING_BID_PRICE W
WHERE  C.ContractID = @ContractID AND C.ContractID = L.ContractID AND W.LotID = L.LotID;
-- ISAIAH
/*5. Generate Enquiry Report: list of items appraised by an employee from a certain consigner
on a certain date, includes item title, description, estimated value, and whether the
auction house is interested in auctioning said item.*/
SET @date:= '2022-03-01';
SELECT EN.Description, EN.Value_Est, EN.Accept
FROM ENQUIRY EN, EMPLOYEE E, CLIENT C
WHERE EN.EmpID=E.EmpID AND C.ClientID=EN.ClientID AND EN.Date_Sub=@date;

-- CHRISTINE
/*6. Analyze Category Performance over Time: list of sold lots within a certain
category, including the lot id, description, date auctioned, estimated value and
hammer price.*/
SET @Category:='Tableware';
SELECT DISTINCT L.LotID, L.LDescription AS 'Description', A.Auc_Date AS 'Auction Date',
				E.Value_Est AS 'Estimated Value', W.Hammer_Price AS 'Hammer Price'
FROM LOT L, AUCTION A, WINNING_BID_PRICE W, ENQUIRY E, CATALOG C
WHERE E.CName = @Category AND E.EnquiryID = C.EnquiryID AND C.LotID = L.LotID
		AND L.AuctionID = A.AuctionID AND L.LotID = W.LotID;
-- ISAIAH
/*7. Analyze Unaccepted Categories: how many Enquiry Items of each Category are denied
for auction by the auction house.*/
SELECT C.CName, COUNT(*)
FROM CATEGORY C, ENQUIRY EN
WHERE C.CName=EN.CName AND EN.Accept=0
GROUP BY C.CNAME;
-- MY
/*8. Analyze Advertisement Effectiveness: how many winning bidders were sent an
Advertisement for this Auction?*/
Set @AdID := 4;
Select AdID, COUNT(*) as WinningBidWithAd
FROM SENT_TO S, WINNING_BID_PRICE W
WHERE S.ClientID = W.ClientID
GROUP BY AdID;
-- ISAIAH
/*9. Analyze Bidders Interests through Bidding History: how many Lots of each Category
has this client bid on in all auctions so far*/
Set @ClientID:=2;
SELECT E.CName, COUNT(*)
FROM CATALOG CAT, ENQUIRY E, WINNING_BID_PRICE W, CLIENT C
WHERE W.ClientID=@ClientID AND W.ClientID = C.ClientID AND W.LotID=CAT.LotID AND CAT.EnquiryID=E.EnquiryID
GROUP BY E.CName;
-- CHRISTINE
/*10. Advertisement Email List: Generate a list of Clients (including their names and email
addresses) who are interested in the Categories of the Lots present in this Auction.*/
SET @Auction10:=4;
SELECT Concat(C.Fname,' ',C.Lname) AS 'Name', C.Email
FROM CLIENT C, LIKES LK
WHERE C.ClientID = LK.ClientID AND 
	LK.CName =	ANY(SELECT Distinct E.CName
				FROM LOT L, CATALOG CA, ENQUIRY E
				WHERE L.AuctionID = @Auction10 AND L.LotID = CA.LotID AND CA.EnquiryID = E.EnquiryID);
