drop database if exists northwind;

create database northwind;
use northwind;

CREATE TABLE Employees (
  ID int PRIMARY KEY AUTO_INCREMENT,
  Company varchar(50),
  LastName varchar(50),
  FirstName varchar(50),
  Email varchar(50),
  JobTitle varchar(50),
  BusinessPhone varchar(25),
  HomePhone varchar(25) ,
  MobilePhone varchar(25),
  Fax varchar(25),
  Address tinytext,
  City varchar(50),
  State varchar(50),
  ZIP varchar(15),
  Country varchar(50),
  Web text,
  Notes text,
  Attachments text
);

CREATE TABLE Privileges (
  PrivilegeID int PRIMARY KEY AUTO_INCREMENT,
  PrivilegeName varchar(50) 
);

CREATE TABLE Employee_Privileges (
  EmployeeID int,
  PrivilegeID int,
  PRIMARY KEY (EmployeeID, PrivilegeID),
  FOREIGN KEY (EmployeeID) REFERENCES Employees(ID),
  FOREIGN KEY (PrivilegeID) REFERENCES Privileges(PrivilegeID)
);

CREATE TABLE Customers (
  ID int PRIMARY KEY AUTO_INCREMENT,
  Company varchar(50),
  LastName varchar(50),
  FirstName varchar(50),
  Email varchar(50),
  JobTitle varchar(50),
  BusinessPhone varchar(25),
  HomePhone varchar(25) ,
  MobilePhone varchar(25),
  Fax varchar(25),
  Address tinytext,
  City varchar(50),
  State varchar(50),
  ZIP varchar(15),
  Country varchar(50),
  Web text,
  Notes text,
  Attachments text
);

CREATE TABLE Suppliers (
  ID int PRIMARY KEY AUTO_INCREMENT,
  Company varchar(50),
  LastName varchar(50),
  FirstName varchar(50),
  Email varchar(50),
  JobTitle varchar(50),
  BusinessPhone varchar(25),
  HomePhone varchar(25) ,
  MobilePhone varchar(25),
  Fax varchar(25),
  Address tinytext,
  City varchar(50),
  State varchar(50),
  ZIP varchar(15),
  Country varchar(50),
  Web text,
  Notes text,
  Attachments text
);

CREATE TABLE Shippers (
  ID int PRIMARY KEY AUTO_INCREMENT,
  Company varchar(50),
  LastName varchar(50),
  FirstName varchar(50),
  Email varchar(50),
  JobTitle varchar(50),
  BusinessPhone varchar(25),
  HomePhone varchar(25) ,
  MobilePhone varchar(25),
  Fax varchar(25),
  Address tinytext,
  City varchar(50),
  State varchar(50),
  ZIP varchar(15),
  Country varchar(50),
  Web text,
  Notes text,
  Attachments text
);

CREATE TABLE Products (
  SupplierIDs mediumtext,
  ID int PRIMARY KEY AUTO_INCREMENT,
  ProductCode varchar(25) ,
  ProductName varchar(50) ,
  Description text,
  StandardCost decimal(16,4) ,
  ListPrice decimal(16,4) ,
  ReorderLevel smallint ,
  TargetLevel int ,
  QuantityPerUnit varchar(50) ,
  Discontinued BOOLEAN ,
  MinimumReorderQuantity smallint ,
  Category varchar(50) ,
  Attachments text
);

CREATE TABLE Orders_Status (
  StatusID int PRIMARY KEY,
  StatusName varchar(50) 
);

CREATE TABLE Orders_Tax_Status (
  ID int PRIMARY KEY,
  TaxStatusName varchar(50) 
);

CREATE TABLE Orders (
  OrderID int PRIMARY KEY AUTO_INCREMENT,
  EmployeeID int,
  CustomerID int,
  OrderDate datetime ,
  ShippedDate datetime ,
  ShipperID int,
  ShipName varchar(50) ,
  ShipAddress mediumtext,
  ShipCity varchar(50) ,
  ShipState varchar(50) ,
  ShipZIP varchar(50) ,
  ShipCountry varchar(50) ,
  ShippingFee decimal(16,4) ,
  Taxes decimal(16,4) ,
  PaymentType varchar(50) ,
  PaidDate datetime ,
  Notes mediumtext,
  TaxRate double ,
  TaxStatus int,
  StatusID int,
  FOREIGN KEY (EmployeeID) REFERENCES Employees(ID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(ID),
  FOREIGN KEY (ShipperID) REFERENCES Shippers(ID),
  FOREIGN KEY (TaxStatus) REFERENCES Orders_Tax_Status(ID),
  FOREIGN KEY (StatusID) REFERENCES Orders_Status(StatusID)
);

CREATE TABLE Invoices (
  InvoiceID int PRIMARY KEY AUTO_INCREMENT,
  OrderID int,
  InvoiceDate datetime ,
  DueDate datetime ,
  Tax decimal(16,4) ,
  Shipping decimal(16,4) ,
  AmountDue decimal(16,4),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Order_Details_Status (
  StatusID int PRIMARY KEY,
  StatusName varchar(50) 
);

CREATE TABLE Order_Details (
  ID int PRIMARY KEY AUTO_INCREMENT,
  OrderID int,
  ProductID int,
  Quantity decimal(16,4) ,
  UnitPrice decimal(16,4) ,
  Discount decimal(16,4) ,
  StatusID int,
  DateAllocated datetime ,
  PurchaseOrderID int ,
  InventoryID int,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ID),
  FOREIGN KEY (StatusID) REFERENCES Order_Details_Status(StatusID)  
);

CREATE TABLE Purchase_Order_Status (
  StatusID int PRIMARY KEY,
  Status varchar(50) 
);

CREATE TABLE Purchase_Orders (
  PurchaseOrderID int PRIMARY KEY AUTO_INCREMENT,
  SupplierID int,
  CreatedBy int,
  SubmittedDate datetime ,
  CreationDate datetime ,
  StatusID int,
  ExpectedDate datetime ,
  ShippingFee decimal(16,4) ,
  Taxes decimal(16,4) ,
  PaymentDate datetime ,
  PaymentAmount decimal(16,4) ,
  PaymentMethod varchar(50) ,
  Notes text,
  ApprovedBy int ,
  ApprovedDate datetime ,
  SubmittedBy int,
  FOREIGN KEY (SupplierID) REFERENCES Suppliers(ID),
  FOREIGN KEY (CreatedBy) REFERENCES Employees(ID),
  FOREIGN KEY (StatusID) REFERENCES Purchase_Order_Status(StatusID)
);



CREATE TABLE Inventory_Transaction_Types (
  ID int PRIMARY KEY AUTO_INCREMENT,
  TypeName varchar(50) 
);

CREATE TABLE Inventory_Transactions (
  TransactionID int PRIMARY KEY AUTO_INCREMENT,
  TransactionType int,
  TransactionCreatedDate datetime ,
  TransactionModifiedDate datetime ,
  ProductID int,
  Quantity int ,
  PurchaseOrderID int,
  CustomerOrderID int,
  Comments text,
  FOREIGN KEY ( TransactionType) REFERENCES Inventory_Transaction_Types(ID),
  FOREIGN KEY (ProductID) REFERENCES Products(ID),
  FOREIGN KEY (PurchaseOrderID) REFERENCES Purchase_Orders(PurchaseOrderID),
  FOREIGN KEY (CustomerOrderID) REFERENCES Orders(OrderID)
  
);

CREATE TABLE Purchase_Order_Details (
  ID int PRIMARY KEY AUTO_INCREMENT,
  PurchaseOrderID int,
  ProductID int,
  Quantity decimal(10,2) ,
  UnitCost decimal(16,4) ,
  DateReceived datetime ,
  PostedToInventory BOOLEAN NOT NULL,
  InventoryID int,
  FOREIGN KEY (PurchaseOrderID) REFERENCES Purchase_Orders(PurchaseOrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ID),
  FOREIGN KEY (InventoryID) REFERENCES Inventory_Transactions(TransactionID)
);

CREATE TABLE Messages (
  ID int PRIMARY KEY,
  Message varchar(255) 
);


INSERT INTO Employees VALUES (1,'Northwind Traders','Freehafer','Nancy','nancy@northwindtraders.com','Sales Representative','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 1st Avenue','Seattle','WA','99999','USA','#http://northwindtraders.com#',NULL,NULL),(2,'Northwind Traders','Cencini','Andrew','andrew@northwindtraders.com','Vice President, Sales','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 2nd Avenue','Bellevue','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#','Joined the company as a sales representative, was promoted to sales manager and was then named vice president of sales.',NULL),(3,'Northwind Traders','Kotas','Jan','jan@northwindtraders.com','Sales Representative','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 3rd Avenue','Redmond','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#','Was hired as a sales associate and was promoted to sales representative.',NULL),(4,'Northwind Traders','Sergienko','Mariya','mariya@northwindtraders.com','Sales Representative','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 4th Avenue','Kirkland','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#',NULL,NULL),(5,'Northwind Traders','Thorpe','Steven','steven@northwindtraders.com','Sales Manager','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 5th Avenue','Seattle','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#','Joined the company as a sales representative and was promoted to sales manager.  Fluent in French.',NULL),(6,'Northwind Traders','Neipper','Michael','michael@northwindtraders.com','Sales Representative','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 6th Avenue','Redmond','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#','Fluent in Japanese and can read and write French, Portuguese, and Spanish.',NULL),(7,'Northwind Traders','Zare','Robert','robert@northwindtraders.com','Sales Representative','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 7th Avenue','Seattle','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#',NULL,NULL),(8,'Northwind Traders','Giussani','Laura','laura@northwindtraders.com','Sales Coordinator','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 8th Avenue','Redmond','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#','Reads and writes French.',NULL),(9,'Northwind Traders','Hellung-Larsen','Anne','anne@northwindtraders.com','Sales Representative','(123)555-0100','(123)555-0102',NULL,'(123)555-0103','123 9th Avenue','Seattle','WA','99999','USA','http://northwindtraders.com#http://northwindtraders.com/#','Fluent in French and German.',NULL);

INSERT INTO Privileges VALUES (2,'Purchase Approvals');

INSERT INTO Employee_Privileges VALUES (8,2);

INSERT INTO Customers VALUES (1,'Company A','Bedecs','Anna',NULL,'Owner','(123)555-0100',NULL,NULL,'(123)555-0101','123 1st Street','Seattle','WA','99999','USA',NULL,NULL,NULL),(2,'Company B','Gratacos Solsona','Antonio',NULL,'Owner','(123)555-0100',NULL,NULL,'(123)555-0101','123 2nd Street','Boston','MA','99999','USA',NULL,NULL,NULL),(3,'Company C','Axen','Thomas',NULL,'Purchasing Representative','(123)555-0100',NULL,NULL,'(123)555-0101','123 3rd Street','Los Angelas','CA','99999','USA',NULL,NULL,NULL),(4,'Company D','Lee','Christina',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','123 4th Street','New York','NY','99999','USA',NULL,NULL,NULL),(5,'Company E','ODonnell','Martin',NULL,'Owner','(123)555-0100',NULL,NULL,'(123)555-0101','123 5th Street','Minneapolis','MN','99999','USA',NULL,NULL,NULL),(6,'Company F','Perez-Olaeta','Francisco',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','123 6th Street','Milwaukee','WI','99999','USA',NULL,NULL,NULL),(7,'Company G','Xie','Ming-Yang',NULL,'Owner','(123)555-0100',NULL,NULL,'(123)555-0101','123 7th Street','Boise','ID','99999','USA',NULL,NULL,NULL),(8,'Company H','Andersen','Elizabeth',NULL,'Purchasing Representative','(123)555-0100',NULL,NULL,'(123)555-0101','123 8th Street','Portland','OR','99999','USA',NULL,NULL,NULL),(9,'Company I','Mortensen','Sven',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','123 9th Street','Salt Lake City','UT','99999','USA',NULL,NULL,NULL),(10,'Company J','Wacker','Roland',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','123 10th Street','Chicago','IL','99999','USA',NULL,NULL,NULL),(11,'Company K','Krschne','Peter',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','123 11th Street','Miami','FL','99999','USA',NULL,NULL,NULL),(12,'Company L','Edwards','John',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','123 12th Street','Las Vegas','NV','99999','USA',NULL,NULL,NULL),(13,'Company M','Ludick','Andre',NULL,'Purchasing Representative','(123)555-0100',NULL,NULL,'(123)555-0101','456 13th Street','Memphis','TN','99999','USA',NULL,NULL,NULL),(14,'Company N','Grilo','Carlos',NULL,'Purchasing Representative','(123)555-0100',NULL,NULL,'(123)555-0101','456 14th Street','Denver','CO','99999','USA',NULL,NULL,NULL),(15,'Company O','Kupkova','Helena',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','456 15th Street','Honolulu','HI','99999','USA',NULL,NULL,NULL),(16,'Company P','Goldschmidt','Daniel',NULL,'Purchasing Representative','(123)555-0100',NULL,NULL,'(123)555-0101','456 16th Street','San Francisco','CA','99999','USA',NULL,NULL,NULL),(17,'Company Q','Bagel','Jean Philippe',NULL,'Owner','(123)555-0100',NULL,NULL,'(123)555-0101','456 17th Street','Seattle','WA','99999','USA',NULL,NULL,NULL),(18,'Company R','Autier Miconi','Catherine',NULL,'Purchasing Representative','(123)555-0100',NULL,NULL,'(123)555-0101','456 18th Street','Boston','MA','99999','USA',NULL,NULL,NULL),(19,'Company S','Eggerer','Alexander',NULL,'Accounting Assistant','(123)555-0100',NULL,NULL,'(123)555-0101','789 19th Street','Los Angelas','CA','99999','USA',NULL,NULL,NULL),(20,'Company T','Li','George',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','789 20th Street','New York','NY','99999','USA',NULL,NULL,NULL),(21,'Company U','Tham','Bernard',NULL,'Accounting Manager','(123)555-0100',NULL,NULL,'(123)555-0101','789 21th Street','Minneapolis','MN','99999','USA',NULL,NULL,NULL),(22,'Company V','Ramos','Luciana',NULL,'Purchasing Assistant','(123)555-0100',NULL,NULL,'(123)555-0101','789 22th Street','Milwaukee','WI','99999','USA',NULL,NULL,NULL),(23,'Company W','Entin','Michael',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','789 23th Street','Portland','OR','99999','USA',NULL,NULL,NULL),(24,'Company X','Hasselberg','Jonas',NULL,'Owner','(123)555-0100',NULL,NULL,'(123)555-0101','789 24th Street','Salt Lake City','UT','99999','USA',NULL,NULL,NULL),(25,'Company Y','Rodman','John',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','789 25th Street','Chicago','IL','99999','USA',NULL,NULL,NULL),(26,'Company Z','Liu','Run',NULL,'Accounting Assistant','(123)555-0100',NULL,NULL,'(123)555-0101','789 26th Street','Miami','FL','99999','USA',NULL,NULL,NULL),(27,'Company AA','Toh','Karen',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','789 27th Street','Las Vegas','NV','99999','USA',NULL,NULL,NULL),(28,'Company BB','Raghav','Amritansh',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','789 28th Street','Memphis','TN','99999','USA',NULL,NULL,NULL),(29,'Company CC','Lee','Soo Jung',NULL,'Purchasing Manager','(123)555-0100',NULL,NULL,'(123)555-0101','789 29th Street','Denver','CO','99999','USA',NULL,NULL,NULL);

INSERT INTO Suppliers VALUES (1,'Supplier A','Andersen','Elizabeth A.',NULL,'Sales Manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Supplier B','Weiler','Cornelia',NULL,'Sales Manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Supplier C','Kelley','Madeleine',NULL,'Sales Representative',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Supplier D','Sato','Naoki',NULL,'Marketing Manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Supplier E','Hernandez-Echevarria','Amaya',NULL,'Sales Manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Supplier F','Hayakawa','Satomi',NULL,'Marketing Assistant',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'Supplier G','Glasson','Stuart',NULL,'Marketing Manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'Supplier H','Dunton','Bryn Paul',NULL,'Sales Representative',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'Supplier I','Sandberg','Mikael',NULL,'Sales Manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'Supplier J','Sousa','Luis',NULL,'Sales Manager',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

INSERT INTO Shippers VALUES (1,'Shipping Company A',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123 Any Street','Memphis','TN','99999','USA',NULL,NULL,NULL),(2,'Shipping Company B',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123 Any Street','Memphis','TN','99999','USA',NULL,NULL,NULL),(3,'Shipping Company C',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123 Any Street','Memphis','TN','99999','USA',NULL,NULL,NULL);

INSERT INTO Products VALUES ('4',1,'NWTB-1','Northwind Traders Chai',NULL,13.5,18,10,40,'10 boxes x 20 bags',false,10,'Beverages',NULL),('10',3,'NWTCO-3','Northwind Traders Syrup',NULL,7.5,10,25,100,'12 - 550 ml bottles',false,25,'Condiments',NULL),('10',4,'NWTCO-4','Northwind Traders Cajun Seasoning',NULL,16.5,22,10,40,'48 - 6 oz jars',false,10,'Condiments',NULL),('10',5,'NWTO-5','Northwind Traders Olive Oil',NULL,16.0125,21.35,10,40,'36 boxes',false,10,'Oil',NULL),('2;6',6,'NWTJP-6','Northwind Traders Boysenberry Spread',NULL,18.75,25,25,100,'12 - 8 oz jars',false,25,'Jams, Preserves',NULL),('2',7,'NWTDFN-7','Northwind Traders Dried Pears',NULL,22.5,30,10,40,'12 - 1 lb pkgs.',false,10,'Dried Fruit & Nuts',NULL),('8',8,'NWTS-8','Northwind Traders Curry Sauce',NULL,30,40,10,40,'12 - 12 oz jars',false,10,'Sauces',NULL),('2;6',14,'NWTDFN-14','Northwind Traders Walnuts',NULL,17.4375,23.25,10,40,'40 - 100 g pkgs.',false,10,'Dried Fruit & Nuts',NULL),('6',17,'NWTCFV-17','Northwind Traders Fruit Cocktail',NULL,29.25,39,10,40,'15.25 OZ',false,10,'Canned Fruit & Vegetables',NULL),('1',19,'NWTBGM-19','Northwind Traders Chocolate Biscuits Mix',NULL,6.9,9.2,5,20,'10 boxes x 12 pieces',false,5,'Baked Goods & Mixes',NULL),('2;6',20,'NWTJP-6','Northwind Traders Marmalade',NULL,60.75,81,10,40,'30 gift boxes',false,10,'Jams, Preserves',NULL),('1',21,'NWTBGM-21','Northwind Traders Scones',NULL,7.5,10,5,20,'24 pkgs. x 4 pieces',false,5,'Baked Goods & Mixes',NULL),('4',34,'NWTB-34','Northwind Traders Beer',NULL,10.5,14,15,60,'24 - 12 oz bottles',false,15,'Beverages',NULL),('7',40,'NWTCM-40','Northwind Traders Crab Meat',NULL,13.8,18.4,30,120,'24 - 4 oz tins',false,30,'Canned Meat',NULL),('6',41,'NWTSO-41','Northwind Traders Clam Chowder',NULL,7.2375,9.65,10,40,'12 - 12 oz cans',false,10,'Soups',NULL),('3;4',43,'NWTB-43','Northwind Traders Coffee',NULL,34.5,46,25,100,'16 - 500 g tins',false,25,'Beverages',NULL),('10',48,'NWTCA-48','Northwind Traders Chocolate',NULL,9.5625,12.75,25,100,'10 pkgs',false,25,'Candy',NULL),('2',51,'NWTDFN-51','Northwind Traders Dried Apples',NULL,39.75,53,10,40,'50 - 300 g pkgs.',false,10,'Dried Fruit & Nuts',NULL),('1',52,'NWTG-52','Northwind Traders Long Grain Rice',NULL,5.25,7,25,100,'16 - 2 kg boxes',false,25,'Grains',NULL),('1',56,'NWTP-56','Northwind Traders Gnocchi',NULL,28.5,38,30,120,'24 - 250 g pkgs.',false,30,'Pasta',NULL),('1',57,'NWTP-57','Northwind Traders Ravioli',NULL,14.625,19.5,20,80,'24 - 250 g pkgs.',false,20,'Pasta',NULL),('8',65,'NWTS-65','Northwind Traders Hot Pepper Sauce',NULL,15.7875,21.05,10,40,'32 - 8 oz bottles',false,10,'Sauces',NULL),('8',66,'NWTS-66','Northwind Traders Tomato Sauce',NULL,12.75,17,20,80,'24 - 8 oz jars',false,20,'Sauces',NULL),('5',72,'NWTD-72','Northwind Traders Mozzarella',NULL,26.1,34.8,10,40,'24 - 200 g pkgs.',false,10,'Dairy Products',NULL),('2;6',74,'NWTDFN-74','Northwind Traders Almonds',NULL,7.5,10,5,20,'5 kg pkg.',false,5,'Dried Fruit & Nuts',NULL),('10',77,'NWTCO-77','Northwind Traders Mustard',NULL,9.75,13,15,60,'12 boxes',false,15,'Condiments',NULL),('2',80,'NWTDFN-80','Northwind Traders Dried Plums',NULL,3,3.5,50,75,'1 lb bag',false,25,'Dried Fruit & Nuts',NULL),('3',81,'NWTB-81','Northwind Traders Green Tea',NULL,2,2.99,100,125,'20 bags per box',false,25,'Beverages',NULL),('1',82,'NWTC-82','Northwind Traders Granola',NULL,2,4,20,100,NULL,false,NULL,'Cereal',NULL),('9',83,'NWTCS-83','Northwind Traders Potato Chips',NULL,0.5,1.8,30,200,NULL,false,NULL,'Chips, Snacks',NULL),('1',85,'NWTBGM-85','Northwind Traders Brownie Mix',NULL,9,12.49,10,20,'3 boxes',false,5,'Baked Goods & Mixes',NULL),('1',86,'NWTBGM-86','Northwind Traders Cake Mix',NULL,10.5,15.99,10,20,'4 boxes',false,5,'Baked Goods & Mixes',NULL),('7',87,'NWTB-87','Northwind Traders Tea',NULL,2,4,20,50,'100 count per box',false,NULL,'Beverages',NULL),('6',88,'NWTCFV-88','Northwind Traders Pears',NULL,1,1.3,10,40,'15.25 OZ',false,NULL,'Canned Fruit & Vegetables',NULL),('6',89,'NWTCFV-89','Northwind Traders Peaches',NULL,1,1.5,10,40,'15.25 OZ',false,NULL,'Canned Fruit & Vegetables',NULL),('6',90,'NWTCFV-90','Northwind Traders Pineapple',NULL,1,1.8,10,40,'15.25 OZ',false,NULL,'Canned Fruit & Vegetables',NULL),('6',91,'NWTCFV-91','Northwind Traders Cherry Pie Filling',NULL,1,2,10,40,'15.25 OZ',false,NULL,'Canned Fruit & Vegetables',NULL),('6',92,'NWTCFV-92','Northwind Traders Green Beans',NULL,1,1.2,10,40,'14.5 OZ',false,NULL,'Canned Fruit & Vegetables',NULL),('6',93,'NWTCFV-93','Northwind Traders Corn',NULL,1,1.2,10,40,'14.5 OZ',false,NULL,'Canned Fruit & Vegetables',NULL),('6',94,'NWTCFV-94','Northwind Traders Peas',NULL,1,1.5,10,40,'14.5 OZ',false,NULL,'Canned Fruit & Vegetables',NULL),('7',95,'NWTCM-95','Northwind Traders Tuna Fish',NULL,0.5,2,30,50,'5 oz',false,NULL,'Canned Meat',NULL),('7',96,'NWTCM-96','Northwind Traders Smoked Salmon',NULL,2,4,30,50,'5 oz',false,NULL,'Canned Meat',NULL),('1',97,'NWTC-82','Northwind Traders Hot Cereal',NULL,3,5,50,200,NULL,false,NULL,'Cereal',NULL),('6',98,'NWTSO-98','Northwind Traders Vegetable Soup',NULL,1,1.89,100,200,NULL,false,NULL,'Soups',NULL),('6',99,'NWTSO-99','Northwind Traders Chicken Soup',NULL,1,1.95,100,200,NULL,false,NULL,'Soups',NULL);

INSERT INTO Orders_Status VALUES (0,'New'),(1,'Invoiced'),(2,'Shipped'),(3,'Closed');

INSERT INTO Orders_Tax_Status VALUES (0,'Tax Exempt'),(1,'Taxable');

INSERT INTO Orders VALUES (30,9,27,'2006-01-15 00:00:00','2006-01-22 00:00:00',2,'Karen Toh','789 27th Street','Las Vegas','NV','99999','USA',200,0,'Check','2006-01-15 00:00:00',NULL,0,NULL,3),(31,3,4,'2006-01-20 00:00:00','2006-01-22 00:00:00',1,'Christina Lee','123 4th Street','New York','NY','99999','USA',5,0,'Credit Card','2006-01-20 00:00:00',NULL,0,NULL,3),(32,4,12,'2006-01-22 00:00:00','2006-01-22 00:00:00',2,'John Edwards','123 12th Street','Las Vegas','NV','99999','USA',5,0,'Credit Card','2006-01-22 00:00:00',NULL,0,NULL,3),(33,6,8,'2006-01-30 00:00:00','2006-01-31 00:00:00',3,'Elizabeth Andersen','123 8th Street','Portland','OR','99999','USA',50,0,'Credit Card','2006-01-30 00:00:00',NULL,0,NULL,3),(34,9,4,'2006-02-06 00:00:00','2006-02-07 00:00:00',3,'Christina Lee','123 4th Street','New York','NY','99999','USA',4,0,'Check','2006-02-06 00:00:00',NULL,0,NULL,3),(35,3,29,'2006-02-10 00:00:00','2006-02-12 00:00:00',2,'Soo Jung Lee','789 29th Street','Denver','CO','99999','USA',7,0,'Check','2006-02-10 00:00:00',NULL,0,NULL,3),(36,4,3,'2006-02-23 00:00:00','2006-02-25 00:00:00',2,'Thomas Axen','123 3rd Street','Los Angelas','CA','99999','USA',7,0,'Cash','2006-02-23 00:00:00',NULL,0,NULL,3),(37,8,6,'2006-03-06 00:00:00','2006-03-09 00:00:00',2,'Francisco Perez-Olaeta','123 6th Street','Milwaukee','WI','99999','USA',12,0,'Credit Card','2006-03-06 00:00:00',NULL,0,NULL,3),(38,9,28,'2006-03-10 00:00:00','2006-03-11 00:00:00',3,'Amritansh Raghav','789 28th Street','Memphis','TN','99999','USA',10,0,'Check','2006-03-10 00:00:00',NULL,0,NULL,3),(39,3,8,'2006-03-22 00:00:00','2006-03-24 00:00:00',3,'Elizabeth Andersen','123 8th Street','Portland','OR','99999','USA',5,0,'Check','2006-03-22 00:00:00',NULL,0,NULL,3),(40,4,10,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,'Roland Wacker','123 10th Street','Chicago','IL','99999','USA',9,0,'Credit Card','2006-03-24 00:00:00',NULL,0,NULL,3),(41,1,7,'2006-03-24 00:00:00',NULL,NULL,'Ming-Yang Xie','123 7th Street','Boise','ID','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(42,1,10,'2006-03-24 00:00:00','2006-04-07 00:00:00',1,'Roland Wacker','123 10th Street','Chicago','IL','99999','USA',0,0,NULL,NULL,NULL,0,NULL,2),(43,1,11,'2006-03-24 00:00:00',NULL,3,'Peter Krschne','123 11th Street','Miami','FL','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(44,1,1,'2006-03-24 00:00:00',NULL,NULL,'Anna Bedecs','123 1st Street','Seattle','WA','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(45,1,28,'2006-04-07 00:00:00','2006-04-07 00:00:00',3,'Amritansh Raghav','789 28th Street','Memphis','TN','99999','USA',40,0,'Credit Card','2006-04-07 00:00:00',NULL,0,NULL,3),(46,7,9,'2006-04-05 00:00:00','2006-04-05 00:00:00',1,'Sven Mortensen','123 9th Street','Salt Lake City','UT','99999','USA',100,0,'Check','2006-04-05 00:00:00',NULL,0,NULL,3),(47,6,6,'2006-04-08 00:00:00','2006-04-08 00:00:00',2,'Francisco Perez-Olaeta','123 6th Street','Milwaukee','WI','99999','USA',300,0,'Credit Card','2006-04-08 00:00:00',NULL,0,NULL,3),(48,4,8,'2006-04-05 00:00:00','2006-04-05 00:00:00',2,'Elizabeth Andersen','123 8th Street','Portland','OR','99999','USA',50,0,'Check','2006-04-05 00:00:00',NULL,0,NULL,3),(50,9,25,'2006-04-05 00:00:00','2006-04-05 00:00:00',1,'John Rodman','789 25th Street','Chicago','IL','99999','USA',5,0,'Cash','2006-04-05 00:00:00',NULL,0,NULL,3),(51,9,26,'2006-04-05 00:00:00','2006-04-05 00:00:00',3,'Run Liu','789 26th Street','Miami','FL','99999','USA',60,0,'Credit Card','2006-04-05 00:00:00',NULL,0,NULL,3),(55,1,29,'2006-04-05 00:00:00','2006-04-05 00:00:00',2,'Soo Jung Lee','789 29th Street','Denver','CO','99999','USA',200,0,'Check','2006-04-05 00:00:00',NULL,0,NULL,3),(56,2,6,'2006-04-03 00:00:00','2006-04-03 00:00:00',3,'Francisco Perez-Olaeta','123 6th Street','Milwaukee','WI','99999','USA',0,0,'Check','2006-04-03 00:00:00',NULL,0,NULL,3),(57,9,27,'2006-04-22 00:00:00','2006-04-22 00:00:00',2,'Karen Toh','789 27th Street','Las Vegas','NV','99999','USA',200,0,'Check','2006-04-22 00:00:00',NULL,0,NULL,0),(58,3,4,'2006-04-22 00:00:00','2006-04-22 00:00:00',1,'Christina Lee','123 4th Street','New York','NY','99999','USA',5,0,'Credit Card','2006-04-22 00:00:00',NULL,0,NULL,3),(59,4,12,'2006-04-22 00:00:00','2006-04-22 00:00:00',2,'John Edwards','123 12th Street','Las Vegas','NV','99999','USA',5,0,'Credit Card','2006-04-22 00:00:00',NULL,0,NULL,0),(60,6,8,'2006-04-30 00:00:00','2006-04-30 00:00:00',3,'Elizabeth Andersen','123 8th Street','Portland','OR','99999','USA',50,0,'Credit Card','2006-04-30 00:00:00',NULL,0,NULL,3),(61,9,4,'2006-04-07 00:00:00','2006-04-07 00:00:00',3,'Christina Lee','123 4th Street','New York','NY','99999','USA',4,0,'Check','2006-04-07 00:00:00',NULL,0,NULL,0),(62,3,29,'2006-04-12 00:00:00','2006-04-12 00:00:00',2,'Soo Jung Lee','789 29th Street','Denver','CO','99999','USA',7,0,'Check','2006-04-12 00:00:00',NULL,0,NULL,0),(63,4,3,'2006-04-25 00:00:00','2006-04-25 00:00:00',2,'Thomas Axen','123 3rd Street','Los Angelas','CA','99999','USA',7,0,'Cash','2006-04-25 00:00:00',NULL,0,NULL,3),(64,8,6,'2006-05-09 00:00:00','2006-05-09 00:00:00',2,'Francisco Perez-Olaeta','123 6th Street','Milwaukee','WI','99999','USA',12,0,'Credit Card','2006-05-09 00:00:00',NULL,0,NULL,0),(65,9,28,'2006-05-11 00:00:00','2006-05-11 00:00:00',3,'Amritansh Raghav','789 28th Street','Memphis','TN','99999','USA',10,0,'Check','2006-05-11 00:00:00',NULL,0,NULL,0),(66,3,8,'2006-05-24 00:00:00','2006-05-24 00:00:00',3,'Elizabeth Andersen','123 8th Street','Portland','OR','99999','USA',5,0,'Check','2006-05-24 00:00:00',NULL,0,NULL,0),(67,4,10,'2006-05-24 00:00:00','2006-05-24 00:00:00',2,'Roland Wacker','123 10th Street','Chicago','IL','99999','USA',9,0,'Credit Card','2006-05-24 00:00:00',NULL,0,NULL,3),(68,1,7,'2006-05-24 00:00:00',NULL,NULL,'Ming-Yang Xie','123 7th Street','Boise','ID','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(69,1,10,'2006-05-24 00:00:00',NULL,1,'Roland Wacker','123 10th Street','Chicago','IL','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(70,1,11,'2006-05-24 00:00:00',NULL,3,'Peter Krschne','123 11th Street','Miami','FL','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(71,1,1,'2006-05-24 00:00:00',NULL,3,'Anna Bedecs','123 1st Street','Seattle','WA','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(72,1,28,'2006-06-07 00:00:00','2006-06-07 00:00:00',3,'Amritansh Raghav','789 28th Street','Memphis','TN','99999','USA',40,0,'Credit Card','2006-06-07 00:00:00',NULL,0,NULL,3),(73,7,9,'2006-06-05 00:00:00','2006-06-05 00:00:00',1,'Sven Mortensen','123 9th Street','Salt Lake City','UT','99999','USA',100,0,'Check','2006-06-05 00:00:00',NULL,0,NULL,3),(74,6,6,'2006-06-08 00:00:00','2006-06-08 00:00:00',2,'Francisco Perez-Olaeta','123 6th Street','Milwaukee','WI','99999','USA',300,0,'Credit Card','2006-06-08 00:00:00',NULL,0,NULL,3),(75,4,8,'2006-06-05 00:00:00','2006-06-05 00:00:00',2,'Elizabeth Andersen','123 8th Street','Portland','OR','99999','USA',50,0,'Check','2006-06-05 00:00:00',NULL,0,NULL,3),(76,9,25,'2006-06-05 00:00:00','2006-06-05 00:00:00',1,'John Rodman','789 25th Street','Chicago','IL','99999','USA',5,0,'Cash','2006-06-05 00:00:00',NULL,0,NULL,3),(77,9,26,'2006-06-05 00:00:00','2006-06-05 00:00:00',3,'Run Liu','789 26th Street','Miami','FL','99999','USA',60,0,'Credit Card','2006-06-05 00:00:00',NULL,0,NULL,3),(78,1,29,'2006-06-05 00:00:00','2006-06-05 00:00:00',2,'Soo Jung Lee','789 29th Street','Denver','CO','99999','USA',200,0,'Check','2006-06-05 00:00:00',NULL,0,NULL,3),(79,2,6,'2006-06-23 00:00:00','2006-06-23 00:00:00',3,'Francisco Perez-Olaeta','123 6th Street','Milwaukee','WI','99999','USA',0,0,'Check','2006-06-23 00:00:00',NULL,0,NULL,3),(80,2,4,'2006-04-25 17:03:55',NULL,NULL,'Christina Lee','123 4th Street','New York','NY','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0),(81,2,3,'2006-04-25 17:26:53',NULL,NULL,'Thomas Axen','123 3rd Street','Los Angelas','CA','99999','USA',0,0,NULL,NULL,NULL,0,NULL,0);

INSERT INTO Invoices VALUES (5,31,'2006-03-22 16:08:59',NULL,0,0,0),(6,32,'2006-03-22 16:10:27',NULL,0,0,0),(7,40,'2006-03-24 10:41:41',NULL,0,0,0),(8,39,'2006-03-24 10:55:46',NULL,0,0,0),(9,38,'2006-03-24 10:56:57',NULL,0,0,0),(10,37,'2006-03-24 10:57:38',NULL,0,0,0),(11,36,'2006-03-24 10:58:40',NULL,0,0,0),(12,35,'2006-03-24 10:59:41',NULL,0,0,0),(13,34,'2006-03-24 11:00:55',NULL,0,0,0),(14,33,'2006-03-24 11:02:02',NULL,0,0,0),(15,30,'2006-03-24 11:03:00',NULL,0,0,0),(16,56,'2006-04-03 13:50:15',NULL,0,0,0),(17,55,'2006-04-04 11:05:04',NULL,0,0,0),(18,51,'2006-04-04 11:06:13',NULL,0,0,0),(19,50,'2006-04-04 11:06:56',NULL,0,0,0),(20,48,'2006-04-04 11:07:37',NULL,0,0,0),(21,47,'2006-04-04 11:08:14',NULL,0,0,0),(22,46,'2006-04-04 11:08:49',NULL,0,0,0),(23,45,'2006-04-04 11:09:24',NULL,0,0,0),(24,79,'2006-04-04 11:35:54',NULL,0,0,0),(25,78,'2006-04-04 11:36:21',NULL,0,0,0),(26,77,'2006-04-04 11:36:47',NULL,0,0,0),(27,76,'2006-04-04 11:37:09',NULL,0,0,0),(28,75,'2006-04-04 11:37:49',NULL,0,0,0),(29,74,'2006-04-04 11:38:11',NULL,0,0,0),(30,73,'2006-04-04 11:38:32',NULL,0,0,0),(31,72,'2006-04-04 11:38:53',NULL,0,0,0),(32,71,'2006-04-04 11:39:29',NULL,0,0,0),(33,70,'2006-04-04 11:39:53',NULL,0,0,0),(34,69,'2006-04-04 11:40:16',NULL,0,0,0),(35,67,'2006-04-04 11:40:38',NULL,0,0,0),(36,42,'2006-04-04 11:41:14',NULL,0,0,0),(37,60,'2006-04-04 11:41:45',NULL,0,0,0),(38,63,'2006-04-04 11:42:26',NULL,0,0,0),(39,58,'2006-04-04 11:43:08',NULL,0,0,0);

INSERT INTO Order_Details_Status VALUES (0,'None'),(1,'Allocated'),(2,'Invoiced'),(3,'Shipped'),(4,'On Order'),(5,'No Stock');

INSERT INTO Order_Details VALUES (27,30,34,100.0000,14,0,2,NULL,96,83),(28,30,80,30.0000,3.5,0,2,NULL,NULL,63),(29,31,7,10.0000,30,0,2,NULL,NULL,64),(30,31,51,10.0000,53,0,2,NULL,NULL,65),(31,31,80,10.0000,3.5,0,2,NULL,NULL,66),(32,32,1,15.0000,18,0,2,NULL,NULL,67),(33,32,43,20.0000,46,0,2,NULL,NULL,68),(34,33,19,30.0000,9.2,0,2,NULL,97,81),(35,34,19,20.0000,9.2,0,2,NULL,NULL,69),(36,35,48,10.0000,12.75,0,2,NULL,NULL,70),(37,36,41,200.0000,9.65,0,2,NULL,98,79),(38,37,8,17.0000,40,0,2,NULL,NULL,71),(39,38,43,300.0000,46,0,2,NULL,99,77),(40,39,48,100.0000,12.75,0,2,NULL,100,75),(41,40,81,200.0000,2.99,0,2,NULL,101,73),(42,41,43,300.0000,46,0,1,NULL,102,104),(43,42,6,10.0000,25,0,2,NULL,NULL,84),(44,42,4,10.0000,22,0,2,NULL,NULL,85),(45,42,19,10.0000,9.2,0,2,NULL,103,110),(46,43,80,20.0000,3.5,0,1,NULL,NULL,86),(47,43,81,50.0000,2.99,0,1,NULL,NULL,87),(48,44,1,25.0000,18,0,1,NULL,NULL,88),(49,44,43,25.0000,46,0,1,NULL,NULL,89),(50,44,81,25.0000,2.99,0,1,NULL,NULL,90),(51,45,41,50.0000,9.65,0,2,NULL,104,116),(52,45,40,50.0000,18.4,0,2,NULL,NULL,91),(53,46,57,100.0000,19.5,0,2,NULL,105,101),(54,46,72,50.0000,34.8,0,2,NULL,106,114),(55,47,34,300.0000,14,0,2,NULL,107,108),(56,48,8,25.0000,40,0,2,NULL,108,106),(57,48,19,25.0000,9.2,0,2,NULL,109,112),(59,50,21,20.0000,10,0,2,NULL,NULL,92),(60,51,5,25.0000,21.35,0,2,NULL,NULL,93),(61,51,41,30.0000,9.65,0,2,NULL,NULL,94),(62,51,40,30.0000,18.4,0,2,NULL,NULL,95),(66,56,48,10.0000,12.75,0,2,NULL,111,99),(67,55,34,87.0000,14,0,2,NULL,NULL,117),(68,79,7,30.0000,30,0,2,NULL,NULL,119),(69,79,51,30.0000,53,0,2,NULL,NULL,118),(70,78,17,40.0000,39,0,2,NULL,NULL,120),(71,77,6,90.0000,25,0,2,NULL,NULL,121),(72,76,4,30.0000,22,0,2,NULL,NULL,122),(73,75,48,40.0000,12.75,0,2,NULL,NULL,123),(74,74,48,40.0000,12.75,0,2,NULL,NULL,124),(75,73,41,10.0000,9.65,0,2,NULL,NULL,125),(76,72,43,5.0000,46,0,2,NULL,NULL,126),(77,71,40,40.0000,18.4,0,2,NULL,NULL,127),(78,70,8,20.0000,40,0,2,NULL,NULL,128),(79,69,80,15.0000,3.5,0,2,NULL,NULL,129),(80,67,74,20.0000,10,0,2,NULL,NULL,130),(81,60,72,40.0000,34.8,0,2,NULL,NULL,131),(82,63,3,50.0000,10,0,2,NULL,NULL,132),(83,63,8,3.0000,40,0,2,NULL,NULL,133),(84,58,20,40.0000,81,0,2,NULL,NULL,134),(85,58,52,40.0000,7,0,2,NULL,NULL,135),(86,80,56,10.0000,38,0,1,NULL,NULL,136),(90,81,81,0.0000,2.99,0,5,NULL,NULL,NULL),(91,81,56,0.0000,38,0,0,NULL,NULL,NULL);

INSERT INTO Purchase_Order_Status VALUES (0,'New'),(1,'Submitted'),(2,'Approved'),(3,'Closed');

INSERT INTO Purchase_Orders VALUES (90,1,2,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-01-22 00:00:00',2),(91,3,2,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-01-22 00:00:00',2),(92,2,2,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-01-22 00:00:00',2),(93,5,2,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-01-22 00:00:00',2),(94,6,2,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-01-22 00:00:00',2),(95,4,2,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-01-22 00:00:00',2),(96,1,5,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #30',2,'2006-01-22 00:00:00',5),(97,2,7,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #33',2,'2006-01-22 00:00:00',7),(98,2,4,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #36',2,'2006-01-22 00:00:00',4),(99,1,3,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #38',2,'2006-01-22 00:00:00',3),(100,2,9,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #39',2,'2006-01-22 00:00:00',9),(101,1,2,'2006-01-14 00:00:00','2006-01-22 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #40',2,'2006-01-22 00:00:00',2),(102,1,1,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #41',2,'2006-04-04 00:00:00',1),(103,2,1,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #42',2,'2006-04-04 00:00:00',1),(104,2,1,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #45',2,'2006-04-04 00:00:00',1),(105,5,7,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,'Check','Purchase generated based on Order #46',2,'2006-04-04 00:00:00',7),(106,6,7,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #46',2,'2006-04-04 00:00:00',7),(107,1,6,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #47',2,'2006-04-04 00:00:00',6),(108,2,4,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #48',2,'2006-04-04 00:00:00',4),(109,2,4,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #48',2,'2006-04-04 00:00:00',4),(110,1,3,'2006-03-24 00:00:00','2006-03-24 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #49',2,'2006-04-04 00:00:00',3),(111,1,2,'2006-03-31 00:00:00','2006-03-31 00:00:00',2,NULL,0,0,NULL,0,NULL,'Purchase generated based on Order #56',2,'2006-04-04 00:00:00',2),(140,6,NULL,'2006-04-25 00:00:00','2006-04-25 16:40:51',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-04-25 16:41:33',2),(141,8,NULL,'2006-04-25 00:00:00','2006-04-25 17:10:35',2,NULL,0,0,NULL,0,NULL,NULL,2,'2006-04-25 17:10:55',2),(142,8,NULL,'2006-04-25 00:00:00','2006-04-25 17:18:29',2,NULL,0,0,NULL,0,'Check',NULL,2,'2006-04-25 17:18:51',2),(146,2,2,'2006-04-26 18:26:37','2006-04-26 18:26:37',1,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,2),(147,7,2,'2006-04-26 18:33:28','2006-04-26 18:33:28',1,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,2),(148,5,2,'2006-04-26 18:33:52','2006-04-26 18:33:52',1,NULL,0,0,NULL,0,NULL,NULL,NULL,NULL,2);

INSERT INTO Inventory_Transaction_Types VALUES (1,'Purchased'),(2,'Sold'),(3,'On Hold'),(4,'Waste');

INSERT INTO Inventory_Transactions VALUES (35,1,'2006-03-22 16:02:28','2006-03-22 16:02:28',80,75,NULL,NULL,NULL),(36,1,'2006-03-22 16:02:48','2006-03-22 16:02:48',72,40,NULL,NULL,NULL),(37,1,'2006-03-22 16:03:04','2006-03-22 16:03:04',52,100,NULL,NULL,NULL),(38,1,'2006-03-22 16:03:09','2006-03-22 16:03:09',56,120,NULL,NULL,NULL),(39,1,'2006-03-22 16:03:14','2006-03-22 16:03:14',57,80,NULL,NULL,NULL),(40,1,'2006-03-22 16:03:40','2006-03-22 16:03:40',6,100,NULL,NULL,NULL),(41,1,'2006-03-22 16:03:47','2006-03-22 16:03:47',7,40,NULL,NULL,NULL),(42,1,'2006-03-22 16:03:54','2006-03-22 16:03:54',8,40,NULL,NULL,NULL),(43,1,'2006-03-22 16:04:02','2006-03-22 16:04:02',14,40,NULL,NULL,NULL),(44,1,'2006-03-22 16:04:07','2006-03-22 16:04:07',17,40,NULL,NULL,NULL),(45,1,'2006-03-22 16:04:12','2006-03-22 16:04:12',19,20,NULL,NULL,NULL),(46,1,'2006-03-22 16:04:17','2006-03-22 16:04:17',20,40,NULL,NULL,NULL),(47,1,'2006-03-22 16:04:20','2006-03-22 16:04:20',21,20,NULL,NULL,NULL),(48,1,'2006-03-22 16:04:24','2006-03-22 16:04:24',40,120,NULL,NULL,NULL),(49,1,'2006-03-22 16:04:28','2006-03-22 16:04:28',41,40,NULL,NULL,NULL),(50,1,'2006-03-22 16:04:31','2006-03-22 16:04:31',48,100,NULL,NULL,NULL),(51,1,'2006-03-22 16:04:38','2006-03-22 16:04:38',51,40,NULL,NULL,NULL),(52,1,'2006-03-22 16:04:41','2006-03-22 16:04:41',74,20,NULL,NULL,NULL),(53,1,'2006-03-22 16:04:45','2006-03-22 16:04:45',77,60,NULL,NULL,NULL),(54,1,'2006-03-22 16:05:07','2006-03-22 16:05:07',3,100,NULL,NULL,NULL),(55,1,'2006-03-22 16:05:11','2006-03-22 16:05:11',4,40,NULL,NULL,NULL),(56,1,'2006-03-22 16:05:14','2006-03-22 16:05:14',5,40,NULL,NULL,NULL),(57,1,'2006-03-22 16:05:26','2006-03-22 16:05:26',65,40,NULL,NULL,NULL),(58,1,'2006-03-22 16:05:32','2006-03-22 16:05:32',66,80,NULL,NULL,NULL),(59,1,'2006-03-22 16:05:47','2006-03-22 16:05:47',1,40,NULL,NULL,NULL),(60,1,'2006-03-22 16:05:51','2006-03-22 16:05:51',34,60,NULL,NULL,NULL),(61,1,'2006-03-22 16:06:00','2006-03-22 16:06:00',43,100,NULL,NULL,NULL),(62,1,'2006-03-22 16:06:03','2006-03-22 16:06:03',81,125,NULL,NULL,NULL),(63,2,'2006-03-22 16:07:56','2006-03-24 11:03:00',80,30,NULL,NULL,NULL),(64,2,'2006-03-22 16:08:19','2006-03-22 16:08:59',7,10,NULL,NULL,NULL),(65,2,'2006-03-22 16:08:29','2006-03-22 16:08:59',51,10,NULL,NULL,NULL),(66,2,'2006-03-22 16:08:37','2006-03-22 16:08:59',80,10,NULL,NULL,NULL),(67,2,'2006-03-22 16:09:46','2006-03-22 16:10:27',1,15,NULL,NULL,NULL),(68,2,'2006-03-22 16:10:06','2006-03-22 16:10:27',43,20,NULL,NULL,NULL),(69,2,'2006-03-22 16:11:39','2006-03-24 11:00:55',19,20,NULL,NULL,NULL),(70,2,'2006-03-22 16:11:56','2006-03-24 10:59:41',48,10,NULL,NULL,NULL),(71,2,'2006-03-22 16:12:29','2006-03-24 10:57:38',8,17,NULL,NULL,NULL),(72,1,'2006-03-24 10:41:30','2006-03-24 10:41:30',81,200,NULL,NULL,NULL),(73,2,'2006-03-24 10:41:33','2006-03-24 10:41:42',81,200,NULL,NULL,'Fill Back Ordered product, Order #40'),(74,1,'2006-03-24 10:53:13','2006-03-24 10:53:13',48,100,NULL,NULL,NULL),(75,2,'2006-03-24 10:53:16','2006-03-24 10:55:46',48,100,NULL,NULL,'Fill Back Ordered product, Order #39'),(76,1,'2006-03-24 10:53:36','2006-03-24 10:53:36',43,300,NULL,NULL,NULL),(77,2,'2006-03-24 10:53:39','2006-03-24 10:56:57',43,300,NULL,NULL,'Fill Back Ordered product, Order #38'),(78,1,'2006-03-24 10:54:04','2006-03-24 10:54:04',41,200,NULL,NULL,NULL),(79,2,'2006-03-24 10:54:07','2006-03-24 10:58:40',41,200,NULL,NULL,'Fill Back Ordered product, Order #36'),(80,1,'2006-03-24 10:54:33','2006-03-24 10:54:33',19,30,NULL,NULL,NULL),(81,2,'2006-03-24 10:54:35','2006-03-24 11:02:02',19,30,NULL,NULL,'Fill Back Ordered product, Order #33'),(82,1,'2006-03-24 10:54:58','2006-03-24 10:54:58',34,100,NULL,NULL,NULL),(83,2,'2006-03-24 10:55:02','2006-03-24 11:03:00',34,100,NULL,NULL,'Fill Back Ordered product, Order #30'),(84,2,'2006-03-24 14:48:15','2006-04-04 11:41:14',6,10,NULL,NULL,NULL),(85,2,'2006-03-24 14:48:23','2006-04-04 11:41:14',4,10,NULL,NULL,NULL),(86,3,'2006-03-24 14:49:16','2006-03-24 14:49:16',80,20,NULL,NULL,NULL),(87,3,'2006-03-24 14:49:20','2006-03-24 14:49:20',81,50,NULL,NULL,NULL),(88,3,'2006-03-24 14:50:09','2006-03-24 14:50:09',1,25,NULL,NULL,NULL),(89,3,'2006-03-24 14:50:14','2006-03-24 14:50:14',43,25,NULL,NULL,NULL),(90,3,'2006-03-24 14:50:18','2006-03-24 14:50:18',81,25,NULL,NULL,NULL),(91,2,'2006-03-24 14:51:03','2006-04-04 11:09:24',40,50,NULL,NULL,NULL),(92,2,'2006-03-24 14:55:03','2006-04-04 11:06:56',21,20,NULL,NULL,NULL),(93,2,'2006-03-24 14:55:39','2006-04-04 11:06:13',5,25,NULL,NULL,NULL),(94,2,'2006-03-24 14:55:52','2006-04-04 11:06:13',41,30,NULL,NULL,NULL),(95,2,'2006-03-24 14:56:09','2006-04-04 11:06:13',40,30,NULL,NULL,NULL),(96,3,'2006-03-30 16:46:34','2006-03-30 16:46:34',34,12,NULL,NULL,NULL),(97,3,'2006-03-30 17:23:27','2006-03-30 17:23:27',34,10,NULL,NULL,NULL),(98,3,'2006-03-30 17:24:33','2006-03-30 17:24:33',34,1,NULL,NULL,NULL),(99,2,'2006-04-03 13:50:08','2006-04-03 13:50:15',48,10,NULL,NULL,NULL),(100,1,'2006-04-04 11:00:54','2006-04-04 11:00:54',57,100,NULL,NULL,NULL),(101,2,'2006-04-04 11:00:56','2006-04-04 11:08:49',57,100,NULL,NULL,'Fill Back Ordered product, Order #46'),(102,1,'2006-04-04 11:01:14','2006-04-04 11:01:14',34,50,NULL,NULL,NULL),(103,1,'2006-04-04 11:01:35','2006-04-04 11:01:35',43,250,NULL,NULL,NULL),(104,3,'2006-04-04 11:01:37','2006-04-04 11:01:37',43,300,NULL,NULL,'Fill Back Ordered product, Order #41'),(105,1,'2006-04-04 11:01:55','2006-04-04 11:01:55',8,25,NULL,NULL,NULL),(106,2,'2006-04-04 11:01:58','2006-04-04 11:07:37',8,25,NULL,NULL,'Fill Back Ordered product, Order #48'),(107,1,'2006-04-04 11:02:17','2006-04-04 11:02:17',34,300,NULL,NULL,NULL),(108,2,'2006-04-04 11:02:19','2006-04-04 11:08:14',34,300,NULL,NULL,'Fill Back Ordered product, Order #47'),(109,1,'2006-04-04 11:02:37','2006-04-04 11:02:37',19,25,NULL,NULL,NULL),(110,2,'2006-04-04 11:02:39','2006-04-04 11:41:14',19,10,NULL,NULL,'Fill Back Ordered product, Order #42'),(111,1,'2006-04-04 11:02:56','2006-04-04 11:02:56',19,10,NULL,NULL,NULL),(112,2,'2006-04-04 11:02:58','2006-04-04 11:07:37',19,25,NULL,NULL,'Fill Back Ordered product, Order #48'),(113,1,'2006-04-04 11:03:12','2006-04-04 11:03:12',72,50,NULL,NULL,NULL),(114,2,'2006-04-04 11:03:14','2006-04-04 11:08:49',72,50,NULL,NULL,'Fill Back Ordered product, Order #46'),(115,1,'2006-04-04 11:03:38','2006-04-04 11:03:38',41,50,NULL,NULL,NULL),(116,2,'2006-04-04 11:03:39','2006-04-04 11:09:24',41,50,NULL,NULL,'Fill Back Ordered product, Order #45'),(117,2,'2006-04-04 11:04:55','2006-04-04 11:05:04',34,87,NULL,NULL,NULL),(118,2,'2006-04-04 11:35:50','2006-04-04 11:35:54',51,30,NULL,NULL,NULL),(119,2,'2006-04-04 11:35:51','2006-04-04 11:35:54',7,30,NULL,NULL,NULL),(120,2,'2006-04-04 11:36:15','2006-04-04 11:36:21',17,40,NULL,NULL,NULL),(121,2,'2006-04-04 11:36:39','2006-04-04 11:36:47',6,90,NULL,NULL,NULL),(122,2,'2006-04-04 11:37:06','2006-04-04 11:37:09',4,30,NULL,NULL,NULL),(123,2,'2006-04-04 11:37:45','2006-04-04 11:37:49',48,40,NULL,NULL,NULL),(124,2,'2006-04-04 11:38:07','2006-04-04 11:38:11',48,40,NULL,NULL,NULL),(125,2,'2006-04-04 11:38:27','2006-04-04 11:38:32',41,10,NULL,NULL,NULL),(126,2,'2006-04-04 11:38:48','2006-04-04 11:38:53',43,5,NULL,NULL,NULL),(127,2,'2006-04-04 11:39:12','2006-04-04 11:39:29',40,40,NULL,NULL,NULL),(128,2,'2006-04-04 11:39:50','2006-04-04 11:39:53',8,20,NULL,NULL,NULL),(129,2,'2006-04-04 11:40:13','2006-04-04 11:40:16',80,15,NULL,NULL,NULL),(130,2,'2006-04-04 11:40:32','2006-04-04 11:40:38',74,20,NULL,NULL,NULL),(131,2,'2006-04-04 11:41:39','2006-04-04 11:41:45',72,40,NULL,NULL,NULL),(132,2,'2006-04-04 11:42:17','2006-04-04 11:42:26',3,50,NULL,NULL,NULL),(133,2,'2006-04-04 11:42:24','2006-04-04 11:42:26',8,3,NULL,NULL,NULL),(134,2,'2006-04-04 11:42:48','2006-04-04 11:43:08',20,40,NULL,NULL,NULL),(135,2,'2006-04-04 11:43:05','2006-04-04 11:43:08',52,40,NULL,NULL,NULL),(136,3,'2006-04-25 17:04:05','2006-04-25 17:04:57',56,110,NULL,NULL,NULL);

INSERT INTO Messages VALUES (2,'Northwind Traders'),(3,'Cannot remove posted inventory!'),(4,'Back ordered product filled for Order #|'),(5,'Discounted price below cost!'),(6,'Insufficient inventory.'),(7,'Insufficient inventory. Do you want to create a purchase order?'),(8,'Purchase orders were successfully created for | products'),(9,'There are no products below their respective reorder levels'),(10,'Must specify customer name!'),(11,'Restocking will generate purchase orders for all products below desired inventory levels.  Do you want to continue?'),(12,'Cannot create purchase order.  No suppliers listed for specified product'),(13,'Discounted price is below cost!'),(14,'Do you want to continue?'),(15,'Order is already invoiced. Do you want to print the invoice?'),(16,'Order does not contain any line items'),(17,'Cannot create invoice!  Inventory has not been allocated for each specified product.'),(18,'Sorry, there are no sales in the specified time period'),(19,'Product successfully restocked.'),(21,'Product does not need restocking! Product is already at desired inventory level.'),(22,'Product restocking failed!'),(23,'Invalid login specified!'),(24,'Must first select reported!'),(25,'Changing supplier will remove purchase line items, continue?'),(26,'Purchase orders were successfully submitted for | products.  Do you want to view the restocking report?'),(27,'There was an error attempting to restock inventory levels.'),(28,'| product(s) were successfully restocked.  Do you want to view the restocking report?'),(29,'You cannot remove purchase line items already posted to inventory!'),(30,'There was an error removing one or more purchase line items.'),(31,'You cannot modify quantity for purchased product already received or posted to inventory.'),(32,'You cannot modify price for purchased product already received or posted to inventory.'),(33,'Product has been successfully posted to inventory.'),(34,'Sorry, product cannot be successfully posted to inventory.'),(35,'There are orders with this product on back order.  Would you like to fill them now?'),(36,'Cannot post product to inventory without specifying received date!'),(37,'Do you want to post received product to inventory?'),(38,'Initialize purchase, orders, and inventory data?'),(39,'Must first specify employee name!'),(40,'Specified user must be logged in to approve purchase!'),(41,'Purchase order must contain completed line items before it can be approved'),(42,'Sorry, you do not have permission to approve purchases.'),(43,'Purchase successfully approved'),(44,'Purchase cannot be approved'),(45,'Purchase successfully submitted for approval'),(46,'Purchase cannot be submitted for approval'),(47,'Sorry, purchase order does not contain line items'),(48,'Do you want to cancel this order?'),(49,'Canceling an order will permanently delete the order.  Are you sure you want to cancel?'),(100,'Your order was successfully canceled.'),(101,'Cannot cancel an order that has items received and posted to inventory.'),(102,'There was an error trying to cancel this order.'),(103,'The invoice for this order has not yet been created.'),(104,'Shipping information is not complete.  Please specify all shipping information and try again.'),(105,'Cannot mark as shipped.  Order must first be invoiced!'),(106,'Cannot cancel an order that has already shipped!'),(107,'Must first specify salesperson!'),(108,'Order is now marked closed.'),(109,'Order must first be marked shipped before closing.'),(110,'Must first specify payment information!'),(111,'There was an error attempting to restock inventory levels.  | product(s) were successfully restocked.'),(112,'You must supply a Unit Cost.'),(113,'Fill back ordered product, Order #|'),(114,'Purchase generated based on Order #|');

INSERT INTO Purchase_Order_Details VALUES (238,90,1,40.0000,14,'2006-01-22 00:00:00',true,59),(239,91,3,100.0000,8,'2006-01-22 00:00:00',true,54),(240,91,4,40.0000,16,'2006-01-22 00:00:00',true,55),(241,91,5,40.0000,16,'2006-01-22 00:00:00',true,56),(242,92,6,100.0000,19,'2006-01-22 00:00:00',true,40),(243,92,7,40.0000,22,'2006-01-22 00:00:00',true,41),(244,92,8,40.0000,30,'2006-01-22 00:00:00',true,42),(245,92,14,40.0000,17,'2006-01-22 00:00:00',true,43),(246,92,17,40.0000,29,'2006-01-22 00:00:00',true,44),(247,92,19,20.0000,7,'2006-01-22 00:00:00',true,45),(248,92,20,40.0000,61,'2006-01-22 00:00:00',true,46),(249,92,21,20.0000,8,'2006-01-22 00:00:00',true,47),(250,90,34,60.0000,10,'2006-01-22 00:00:00',true,60),(251,92,40,120.0000,14,'2006-01-22 00:00:00',true,48),(252,92,41,40.0000,7,'2006-01-22 00:00:00',true,49),(253,90,43,100.0000,34,'2006-01-22 00:00:00',true,61),(254,92,48,100.0000,10,'2006-01-22 00:00:00',true,50),(255,92,51,40.0000,40,'2006-01-22 00:00:00',true,51),(256,93,52,100.0000,5,'2006-01-22 00:00:00',true,37),(257,93,56,120.0000,28,'2006-01-22 00:00:00',true,38),(258,93,57,80.0000,15,'2006-01-22 00:00:00',true,39),(259,91,65,40.0000,16,'2006-01-22 00:00:00',true,57),(260,91,66,80.0000,13,'2006-01-22 00:00:00',true,58),(261,94,72,40.0000,26,'2006-01-22 00:00:00',true,36),(262,92,74,20.0000,8,'2006-01-22 00:00:00',true,52),(263,92,77,60.0000,10,'2006-01-22 00:00:00',true,53),(264,95,80,75.0000,3,'2006-01-22 00:00:00',true,35),(265,90,81,125.0000,2,'2006-01-22 00:00:00',true,62),(266,96,34,100.0000,10,'2006-01-22 00:00:00',true,82),(267,97,19,30.0000,7,'2006-01-22 00:00:00',true,80),(268,98,41,200.0000,7,'2006-01-22 00:00:00',true,78),(269,99,43,300.0000,34,'2006-01-22 00:00:00',true,76),(270,100,48,100.0000,10,'2006-01-22 00:00:00',true,74),(271,101,81,200.0000,2,'2006-01-22 00:00:00',true,72),(272,102,43,300.0000,34,NULL,false,NULL),(273,103,19,10.0000,7,'2006-04-17 00:00:00',true,111),(274,104,41,50.0000,7,'2006-04-06 00:00:00',true,115),(275,105,57,100.0000,15,'2006-04-05 00:00:00',true,100),(276,106,72,50.0000,26,'2006-04-05 00:00:00',true,113),(277,107,34,300.0000,10,'2006-04-05 00:00:00',true,107),(278,108,8,25.0000,30,'2006-04-05 00:00:00',true,105),(279,109,19,25.0000,7,'2006-04-05 00:00:00',true,109),(280,110,43,250.0000,34,'2006-04-10 00:00:00',true,103),(281,90,1,40.0000,14,NULL,false,NULL),(282,92,19,20.0000,7,NULL,false,NULL),(283,111,34,50.0000,10,'2006-04-04 00:00:00',true,102),(285,91,3,50.0000,8,NULL,false,NULL),(286,91,4,40.0000,16,NULL,false,NULL),(288,140,85,10.0000,9,NULL,false,NULL),(289,141,6,10.0000,18.75,NULL,false,NULL),(290,142,1,1.0000,13.5,NULL,false,NULL),(292,146,20,40.0000,60,NULL,false,NULL),(293,146,51,40.0000,39,NULL,false,NULL),(294,147,40,120.0000,13,NULL,false,NULL),(295,148,72,40.0000,26,NULL,false,NULL);

