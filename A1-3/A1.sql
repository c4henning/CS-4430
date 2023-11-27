--
-- Question 1 (4 points)
--

CREATE TABLE `Product`
(
    `maker` VARCHAR(50) NOT NULL,
    `model` VARCHAR(50) NOT NULL,
    `type`  CHAR(10),
    PRIMARY KEY (`maker`, `model`)
);


CREATE TABLE `PC`
(
    `model` VARCHAR(50) NOT NULL,
    `speed` DECIMAL(1, 2),
    `ram`   INT(6),
    `hdisk` INT(5),
    `price` DECIMAL(5, 2),
    PRIMARY KEY (`model`)
);


CREATE TABLE `Laptop`
(
    `model`  VARCHAR(50) NOT NULL,
    `speed`  DECIMAL(1, 2),
    `ram`    INT(6),
    `hdisk`  INT(5),
    `screen` DECIMAL(2, 2),
    `price`  DECIMAL(5, 2),
    PRIMARY KEY (`model`)
);


CREATE TABLE `Printer`
(
    `model` VARCHAR(50) NOT NULL,
    `color` BIT,
    `type`  CHAR(6),
    `price` DECIMAL(5, 2),
    PRIMARY KEY (`model`)
);

--
-- Question 2 (6 points)
--

CREATE TABLE `Employees`
(
    `ENO`       INT(7),
    `Ename`     VARCHAR(50),
    `Hire_Date` DATE,
    PRIMARY KEY (`ENO`)
);

CREATE TABLE `Books`
(
    `ISBN`     VARCHAR(17),
    `Bname`    VARCHAR(255),
    `Quantity` SMALLINT,
    `Price`    DECIMAL(5, 2),
    PRIMARY KEY (`ISBN`)
);

CREATE TABLE `Customers`
(
    `CNO`    INT,
    `Cname`  VARCHAR(50),
    `Street` VARCHAR(255),
    `Zip`    VARCHAR(10),
    `Phone`  VARCHAR(20),
    PRIMARY KEY (`CNO`)
);

CREATE TABLE `Orders`
(
    `ONO`      INT,
    `CNO`      INT,
    `ENO`      INT(7),
    `Received` DATETIME,
    `Shipped`  DATETIME,
    PRIMARY KEY (`ONO`)
);

CREATE TABLE `Orderline`
(
    `ONO`  INT,
    `ISBN` VARCHAR(17),
    `Qty`  TINYINT,
    PRIMARY KEY (`ONO`, `ISBN`)
);

CREATE TABLE `Zipcodes`
(
    `Zip`   VARCHAR(10),
    `City`  VARCHAR(50),
    `State` CHAR(2),
    PRIMARY KEY (`Zip`)
);

/*--
  Question 3  (1 point)
  List customers (cno, name) the zip of whose address is 49008.
  \pi_{CNO,Cname}(\sigma_{Zip='49008'}Customers)
  
  Question 4  (1 point)
  List customers (cno, name) who live in Michigan.
  \pi_{CNO,Cname}\left(\sigma_{State=^\prime{MI}^\prime}(Customers\bowtie Zipcodes)\right)

  Question 5 (1 point)
  List employees (name) who have customers in Michigan.
  \pi_{Ename}\left(Employees\bowtie \pi_{ENO}\left(Orders\bowtie \sigma_{State=^\prime{MI}^\prime}(Customers\bowtie Zipcodes)\right)\right)

  Question 6 (1 point)
  List employees (name) who have both 49008-zipcode customers and 49009-zipcode customers.
  \pi_{Ename}\left(Employees\bowtie\left(\pi_{ENO}\left(\sigma_{Zip=^\prime 49008^\prime\ \vee\  Zip=^\prime 49009^\prime}(Orders\bowtie Customers)\right)\right)\right)

  Question 7 (1 point)
  List customers (name) who've ordered books through an employee named 'Jones'.
  \pi_{Cname}\left(Customers\bowtie\left(\pi_{CNO}\left(\sigma_{Ename=^\prime Jones^\prime}(Orders\bowtie Employees)\right)\right)\right)

  Question 8 (1 point)
  List customers (name) who've NOT ordered the book "Database".
  \pi_{Cname}Customers-\left(Customers\bowtie\pi_{CNO}\left(Orders\bowtie\left(\pi_{ONO}\left(Orderline\bowtie\left(\sigma_{Bname=^\prime Database^\prime}Books\right)\right)\right)\right)\right)

  Question 9 (1 point)
  All possible pairs of books (Bname). (A pair should be listed only once).
  \sigma_{Bname1\le Bname2}\left(\rho_{Books1(Bname1)}\left(\pi_{Bname}Books\right)\times\rho_{Books2(Bname2)}\left(\pi_{Bname}Books\right)\right)

  Question 10 (1 point)
  All possible pairs of books (Bname) where the first has a price of 24.99 and the second has a price of 19.99.
  \pi_{Bname}\left(\sigma_{Price=24.99}Books\right)\times\pi_{Bname}\left(\sigma_{Price=19.99}Books\right)

  Question 11 (1 point)
  Customers (name) who ordered at least one book that customer #1111 ordered.
  \rho_{TempCustBooks}\left(\pi_{Cname,ISBN}\left(\pi_{Cname,CNO}\left(Customers\right)\bowtie\pi_{CNO,ONO}\left(Orders\right)\bowtie\pi_{ONO,ISBN}\left(Orderline\right)\right)\right)\newline\newline \rho_{Temp1111}\left(\pi_{ISBN}\left(Orderline\bowtie\left(\sigma_{CNO=1111}Orders\right)\right)\right)\newline\newline \pi_{Cname}\left(TempCustBooks\bowtie Temp1111\right)

  Question 12 (1 point) 
  Customers (name) who ordered all the books as customer #11111 ordered (although, they may have ordered additional books).
  \rho_{TempCustBooks}\left(\pi_{Cname,ISBN}\left(\pi_{Cname,CNO}\left(Customers\right)\bowtie\pi_{CNO,ONO}\left(Orders\right)\bowtie\pi_{ONO,ISBN}\left(Orderline\right)\right)\right)\newline\newline \rho_{Temp11111}\left(\pi_{ISBN}\left(Orderline\bowtie\left(\sigma_{CNO=11111}Orders\right)\right)\right)\newline\newline \pi_{Cname}\left(TempCustBooks\cap Temp1111\right)
*/































