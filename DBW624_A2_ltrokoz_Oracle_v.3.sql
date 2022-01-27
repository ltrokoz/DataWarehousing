CREATE TABLE DEMOGRAFIC_GROUPS (
DemogrGrID int,
AgeGroupName varchar(30) not null,
AgeBegin int,
AgeEnd int not null,
PRIMARY KEY (DemogrGrID),
CONSTRAINT CHK_AgeBegin CHECK (AgeBegin >= 0),
CONSTRAINT CHK_AgeEnd CHECK (AgeEnd > 0)
);

CREATE TABLE PRODUCTS (
ProductID int,
ProductName varchar(30) not null,  
SKU varchar(30) not null,
ProductColor varchar(30) not null,
ProductDescr varchar(100) not null,
ProductCost decimal(6,2) default 0.00,
ProductPrice decimal(6,2) default 0.00,
DemogrGrID int,
PRIMARY KEY (ProductID),
FOREIGN KEY (DemogrGrID) REFERENCES DEMOGRAFIC_GROUPS(DemogrGrID), 
CONSTRAINT CHK_ProductCost CHECK (ProductCost >= 0),
CONSTRAINT CHK_ProductPrice CHECK (ProductPrice >= 0)
);

CREATE TABLE MARKETING_CAMPAIGN (
MCampID int,
MCampName varchar(30) not null,
MCampDescr varchar(100) not null,
DiscountAmount decimal(6,2) default 0.00,
MCampStartDate char(10) check (TO_DATE(MCampStartDate,'MM-DD-YYYY')>DATE '2021-01-01') not null,
MCampEndDate char(10) check (TO_DATE(MCampEndDate,'MM-DD-YYYY')>DATE '2021-01-01') not null,
PRIMARY KEY (MCampID),
CONSTRAINT CHK_DiscountAmount CHECK (DiscountAmount >= 0)
);

CREATE TABLE PAYMENT_METHODS (
PayMethodID int,
PayMethod varchar(30) not null,
PayMethodAmount decimal(6,2) default 0.00,
PRIMARY KEY (PayMethodID),
CONSTRAINT CHK_PayMethodAmount CHECK (PayMethodAmount >= 0)
);

CREATE TABLE DATE_ (
DateID int,
Date_ char(10) check (TO_DATE(Date_,'MM-DD-YYYY')>DATE '2021-01-01'),
Day_ int not null,
DayOfWeek int not null,
WeekNumber int not null,
Month_ int not null,
Quater int not null,
Year_ int not null,
PRIMARY KEY (DateID),
CONSTRAINT CHK_Day CHECK (Day_ > 0),
CONSTRAINT CHK_DayOfWeek CHECK (DayOfWeek > 0),
CONSTRAINT CHK_WeekNumber CHECK (WeekNumber > 0),
CONSTRAINT CHK_Month CHECK (Month_ > 0),
CONSTRAINT CHK_Quater CHECK (Quater > 0),
CONSTRAINT CHK_Year CHECK (Year_ > 0)
);

CREATE TABLE STORES (
StoreID int,
StoreName varchar(30) not null,
StoreCity varchar(30) not null,
StoreProvince varchar(50) not null,
StorePostalCode varchar(7) not null,
PRIMARY KEY (StoreID)
);

CREATE TABLE EMPLOYEE (
EmployeeID int,
EmployeeFirstName varchar(30) not null,
EmployeeLastName varchar(30) not null,
EmployeeTitle varchar(30) not null,
EmployeeGender varchar(30) not null,
PRIMARY KEY (EmployeeID)
);

CREATE TABLE CUSTOMERS (
CustomerID int,
CustomerFirstName varchar(30) not null,
CustomerLastName varchar(30) not null,
CustomerGender varchar(30) DEFAULT 'Male',
CustomerDOB char(10) check (TO_DATE(CustomerDOB,'MM-DD-YYYY')>DATE '1900-01-01'),
PRIMARY KEY (CustomerID)
);



CREATE TABLE SALES (
ProductID int not null,
MCampID int not null,
PayMethodID int not null,
DateID int not null,
StoreID int not null,
EmployeeID int not null,
CustomerID int not null,
DemogrGrID int not null,
SurrogateID int,
PurchaseTransactionID int not null,
AgeGroupName varchar(30) not null,
Quantity int not null,
Amount decimal(6,2) default 0.00,
Taxes decimal(6,2) default 0.00,
DiscountAmount decimal(6,2) default 0.00,
Cost_ decimal(6,2) default 0.00,
Profit decimal(6,2) default 0.00,
EmployeeFirstName varchar(30) not null,
EmployeeGender varchar(30) not null,
CustomerFirstName varchar(30) not null,
CustomerGender varchar(30) not null,
PRIMARY KEY (SurrogateID),
CONSTRAINT CHK_Amount CHECK (Amount >= 0),
CONSTRAINT CHK_Taxes CHECK (Taxes >= 0),
CONSTRAINT CHK_DiscountAmountS CHECK (DiscountAmount >= 0),
CONSTRAINT CHK_Cost CHECK (Cost_ >= 0),
CONSTRAINT CHK_Profit CHECK (Profit >= 0),
CONSTRAINT fk_Product FOREIGN KEY (ProductID) REFERENCES PRODUCTS (ProductID),
CONSTRAINT fk_MCamp FOREIGN KEY (MCampID) REFERENCES MARKETING_CAMPAIGN (MCampID),
CONSTRAINT fk_PayMethod FOREIGN KEY (PayMethodID) REFERENCES PAYMENT_METHODS (PayMethodID),
CONSTRAINT fk_Date FOREIGN KEY (DateID) REFERENCES DATE_ (DateID),
CONSTRAINT fk_Store FOREIGN KEY (StoreID) REFERENCES STORES (StoreID),
CONSTRAINT fk_Employee FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE (EmployeeID),
CONSTRAINT fk_Customer FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS (CustomerID),
CONSTRAINT fk_DemogrGr FOREIGN KEY (DemogrGrID) REFERENCES DEMOGRAFIC_GROUPS (DemogrGrID)
);

CREATE TABLE DEFINITION_ (
ID_ int,
TableName varchar(30) not null,
ColumnName varchar(30) not null,
Description_ varchar(100) not null,
Comments  varchar(100) DEFAULT '',
PRIMARY KEY (ID_)
);

CREATE TABLE CITY_POPULATION (
CityPopulationID int,
City varchar(30) not null,
Province varchar(30) not null,
Population int DEFAULT 0,
Year_ int DEFAULT 2021,
PRIMARY KEY (CityPopulationID),
CONSTRAINT CHK_YearP CHECK (Year_ > 0)
);

CREATE TABLE LIFE_EXPECTANCY (
LifeExpectancyID int,
City varchar(30) not null,
Gender varchar(30) not null,
LifeExpectancy int not null,
YearOfBirth int DEFAULT 2021,
PRIMARY KEY (LifeExpectancyID),
CONSTRAINT CHK_LifeExpectancy CHECK (LifeExpectancy > 0),
CONSTRAINT CHK_YearOfBirth CHECK (YearOfBirth > 0)
);

CREATE TABLE NAMES (
NameID int,
Name_ varchar(30) not null,
Gender varchar(30) not null,
NameRank int DEFAULT 0,
Year_ int DEFAULT 0,
PRIMARY KEY (NameID),
CONSTRAINT CHK_NameRank CHECK (NameRank > 0),
CONSTRAINT CHK_YearN CHECK (Year_ > 0)
);



INSERT ALL 
INTO PRODUCTS VALUES (1000001, 'Magnet', 'JJF-TS-SML-GN', 'Multi', 'Magnet for metal surface', 1.55, 5.00, 2)
INTO PRODUCTS VALUES (1000002, 'Bedroom door sign', 'AE-TB-LT-W7-BL', 'Gray', 'Bedroom door sign in gender classification', 1.05, 7.00, 2)
INTO PRODUCTS VALUES (1000003, 'Graduation plaque', 'RAH-MT-SCD-WHT', 'White', 'Graduation plaque for front yard', 1.25, 8.00, 2)
INTO PRODUCTS VALUES (1000004, 'License plate', 'PO-TS-34-WHT', 'White', 'License plate for vehicle', 3.00, 14.00, 2)
INTO PRODUCTS VALUES (1000005, 'Basket ball', 'BB-011-AQ-RNG', 'Orange', 'Ball for playing in bascketball sport', 5.00, 25.00, 2)
INTO PRODUCTS VALUES (1000006, 'Paint', 'GN-TS-AE-JJF', 'Multi', 'Paint, 10 colors', 8.55, 25.00, 1)
INTO PRODUCTS VALUES (1000007, 'Candle', 'SML-TB-SML-GN', 'Multi', 'Candle', 5.55, 15.00, 3)
INTO PRODUCTS VALUES (1000008, 'Gift box', 'TS-W7-LT-GN', 'Multi', 'Gift box for new year gifts', 0.50, 4.99, 3)
INTO PRODUCTS VALUES (1000009, 'Notebook', 'BL-JJF-SML-GN', 'Multi', 'Notebook, 90 pages', 1.75, 15.00, 2)
INTO PRODUCTS VALUES (1000010, 'Postcard', 'SLMM-RAH-PO-GN', 'Multi', 'Postcard', 0.05, 3.00, 3)
INTO PRODUCTS VALUES (1000011, 'Pen', 'MT-5S-SML-2WN', 'Black', 'Black pen', 1.55, 5.00, 2)
INTO PRODUCTS VALUES (1000012, 'Marker', 'CSD-T8-SML-GE', 'Multi', 'Marker in diferent colors', 1.55, 5.00, 2)
INTO PRODUCTS VALUES (1000013, 'Candy', 'WHT-AQ-RNG-CDD', 'Multi', 'Candy, 200 g', 1.55, 5.00, 1)
INTO PRODUCTS VALUES (1000014, 'Chocolate', 'JJF-47-SML-ASA', 'Brown', 'Chocolate, 100 g, 70% cacao, brown box', 1.55, 5.00, 1)
INTO PRODUCTS VALUES (1000015, 'Coffee', 'JTE-RNG-SML-GX', 'Multi', 'Coffee in black-white box', 4.00, 20.00, 3)
INTO PRODUCTS VALUES (1000016, 'Tea Black', 'WQ-TS-AQ-GZ', 'Multi', 'Black tea in red-blue box', 1.50, 5.50, 3)
INTO PRODUCTS VALUES (1000017, 'Tea Green', 'R56-TS-SML-BN', 'Multi', 'Green tea in green-white box', 1.85, 7.70, 3)
INTO PRODUCTS VALUES (1000018, 'Canadian Flag', 'J4E-TS-SML-BDN', 'Multi', 'Canadian flag, Red-White colors', 1.00, 25.00, 2)
INTO PRODUCTS VALUES (1000019, 'Mug', 'RNG-85-SML-FNG', 'Multi', 'Mug 550 ml, Red-White colors', 3.00, 12.00, 3)
INTO PRODUCTS VALUES (1000020, 'Cup', 'AQ-99-SML-LK', 'Multi', 'Tea cup 300 ml, Red-White colors', 1.00, 9.90, 3)
SELECT * FROM dual;


INSERT ALL 
INTO PAYMENT_METHODS VALUES (90101, 'Cash', 19.99)
INTO PAYMENT_METHODS VALUES (90102, 'Debit Card', 20.44)
SELECT * FROM dual;


INSERT ALL 
INTO MARKETING_CAMPAIGN VALUES (8001, 'Buy 2 get 1 free', 'Three items for price of two items', 2.99, '12-01-2021', '12-31-2021')
SELECT * FROM dual;


INSERT ALL 
INTO DATE_ VALUES (101010100, '11-08-2021', 8, 1, 45, 11, 4, 2021)
INTO DATE_ VALUES (101010101, '11-09-2021', 9, 1, 45, 11, 4, 2021)
SELECT * FROM dual;


INSERT ALL 
INTO STORES VALUES (10001, 'Best Choise', 'Toronto', 'Ontario', 'M1W 5N2')
INTO STORES VALUES (10002, 'Lucky Jimmy', 'London', 'Ontario', 'L1J 0B5')
INTO STORES VALUES (10003, 'Falls Sights', 'Niagra Falls', 'Ontario', 'L2T 2K9')
INTO STORES VALUES (10004, 'Big Ban', 'Markham', 'Ontario', 'L9C 2Z5')
INTO STORES VALUES (10005, 'Best Friend', 'Simcoe', 'Ontario', 'L4M 5A2')
SELECT * FROM dual;


INSERT ALL 
INTO EMPLOYEE VALUES (120001, 'Margaret', 'Brown', 'Sale Representative', 'Female')
INTO EMPLOYEE VALUES (120002, 'Elizabeth', 'Tremblay', 'Sale Representative', 'Female')
INTO EMPLOYEE VALUES (120003, 'Gladys', 'Martin', 'Sale Representative', 'Female')
INTO EMPLOYEE VALUES (120004, 'Alex', 'Russell', 'Sale Representative', 'Male')
INTO EMPLOYEE VALUES (120005, 'Amelia', 'Smith', 'Sale Representative', 'Female')
INTO EMPLOYEE VALUES (120006, 'Logan', 'Roy', 'Sale Representative', 'Male')
INTO EMPLOYEE VALUES (120007, 'Leo', 'Lee', 'Sale Representative', 'Male')
INTO EMPLOYEE VALUES (120008, 'Adam', 'Wilson', 'Sale Representative', 'Male')
INTO EMPLOYEE VALUES (120009, 'Amelia', 'MacDonald', 'Sale Representative', 'Female')
INTO EMPLOYEE VALUES (120010, 'Emma', 'Campbell', 'Sale Representative', 'Female')
SELECT * FROM dual;


INSERT ALL 
INTO CUSTOMERS VALUES (2000001, 'Olivia', 'Leblanc', 'Female', '12-15-1980')
INTO CUSTOMERS VALUES (2000002, 'Liam', 'Cote', 'Male', '02-14-1982')
INTO CUSTOMERS VALUES (2000003, 'James', 'Jones', 'Male', '10-05-1988')
INTO CUSTOMERS VALUES (2000004, 'Mia', 'Miller', 'Female', '07-12-1990')
INTO CUSTOMERS VALUES (2000005, 'Noah', 'Scott', 'Male', '11-19-1997')
SELECT * FROM dual;


INSERT ALL 
INTO DEMOGRAFIC_GROUPS VALUES (1, 'Infants (ages 0-12', 0, 12)
INTO DEMOGRAFIC_GROUPS VALUES (2, 'Teenagers (ages 13-25)', 13, 25)
INTO DEMOGRAFIC_GROUPS VALUES (3, 'Adults (ages 26-59)', 26, 59)
INTO DEMOGRAFIC_GROUPS VALUES (4, 'Senior (ages 60+)', 60, 120)
SELECT * FROM dual;


INSERT ALL 
INTO SALES VALUES (1000001, 8001, 90101, 101010100, 10001, 120001, 2000001, 3, 103000001, 3000001, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000002, 8001, 90101, 101010100, 10002, 120002, 2000002, 3, 103000002, 3000002, 'Adults (ages 26-59)', 1, 7.00, 0.91, 0.00, 1.05, 5.95, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000003, 8001, 90101, 101010100, 10003, 120003, 2000003, 3, 103000003, 3000003, 'Adults (ages 26-59)', 1, 8.00, 1.04, 0.00, 1.25, 6.75, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000004, 8001, 90101, 101010100, 10004, 120004, 2000004, 3, 103000004, 3000004, 'Adults (ages 26-59)', 1, 14.00, 1.82, 0.00, 3.00, 11.00, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000005, 8001, 90101, 101010100, 10005, 120005, 2000005, 2, 103000005, 3000005, 'Teenagers (ages 13-25)', 1, 25.00, 3.25, 0.00, 5.00, 20.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000006, 8001, 90101, 101010100, 10001, 120006, 2000001, 3, 103000006, 3000006, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 8.55, 16.45, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000007, 8001, 90101, 101010100, 10002, 120007, 2000002, 3, 103000007, 3000007, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 5.55, 9.45, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000008, 8001, 90101, 101010100, 10003, 120008, 2000003, 3, 103000008, 3000008, 'Adults (ages 26-59)', 1, 4.99, 0.65, 0.00, 0.50, 4.49, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000009, 8001, 90101, 101010100, 10004, 120009, 2000004, 3, 103000009, 3000009, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 1.75, 13.25, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000010, 8001, 90101, 101010100, 10005, 120010, 2000005, 2, 103000010, 3000010, 'Teenagers (ages 13-25)', 1, 3.00, 0.39, 0.00, 0.05, 2.95, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000011, 8001, 90101, 101010100, 10001, 120001, 2000001, 3, 103000011, 3000011, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000012, 8001, 90101, 101010100, 10002, 120002, 2000002, 3, 103000012, 3000012, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000013, 8001, 90101, 101010100, 10003, 120003, 2000003, 3, 103000013, 3000013, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000014, 8001, 90101, 101010100, 10004, 120004, 2000004, 3, 103000014, 3000014, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000015, 8001, 90101, 101010100, 10005, 120005, 2000005, 2, 103000015, 3000015, 'Teenagers (ages 13-25)', 1, 20.00, 2.60, 0.00, 4.00, 16.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000016, 8001, 90101, 101010100, 10001, 120006, 2000001, 3, 103000016, 3000016, 'Adults (ages 26-59)', 1, 5.50, 0.72, 0.00, 1.50, 4.00, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000017, 8001, 90101, 101010100, 10002, 120007, 2000002, 3, 103000017, 3000017, 'Adults (ages 26-59)', 1, 7.70, 1.00, 0.00, 1.85, 5.85, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000018, 8001, 90101, 101010100, 10003, 120008, 2000003, 3, 103000018, 3000018, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 1.00, 24.00, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000019, 8001, 90101, 101010100, 10004, 120009, 2000004, 3, 103000019, 3000019, 'Adults (ages 26-59)', 1, 12.00, 1.56, 0.00, 3.00, 9.00, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000020, 8001, 90101, 101010100, 10005, 120010, 2000005, 2, 103000020, 3000020, 'Teenagers (ages 13-25)', 1, 9.90, 1.29, 0.00, 1.00, 8.90, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000001, 8001, 90101, 101010100, 10001, 120001, 2000001, 3, 103000021, 3000021, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000002, 8001, 90101, 101010100, 10002, 120002, 2000002, 3, 103000022, 3000022, 'Adults (ages 26-59)', 1, 7.00, 0.91, 0.00, 1.05, 5.95, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000003, 8001, 90101, 101010100, 10003, 120003, 2000003, 3, 103000023, 3000023, 'Adults (ages 26-59)', 1, 8.00, 1.04, 0.00, 1.25, 6.75, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000004, 8001, 90101, 101010100, 10004, 120004, 2000004, 3, 103000024, 3000024, 'Adults (ages 26-59)', 1, 14.00, 1.82, 0.00, 3.00, 11.00, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000005, 8001, 90101, 101010100, 10005, 120005, 2000005, 2, 103000025, 3000025, 'Teenagers (ages 13-25)', 1, 25.00, 3.25, 0.00, 5.00, 20.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000006, 8001, 90101, 101010100, 10001, 120006, 2000001, 3, 103000026, 3000026, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 8.55, 16.45, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000007, 8001, 90101, 101010100, 10002, 120007, 2000002, 3, 103000027, 3000027, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 5.55, 9.45, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000008, 8001, 90101, 101010100, 10003, 120008, 2000003, 3, 103000028, 3000028, 'Adults (ages 26-59)', 1, 4.99, 0.65, 0.00, 0.50, 4.49, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000009, 8001, 90101, 101010100, 10004, 120009, 2000004, 3, 103000029, 3000029, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 1.75, 13.25, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000010, 8001, 90101, 101010100, 10005, 120010, 2000005, 2, 103000030, 3000030, 'Teenagers (ages 13-25)', 1, 3.00, 0.39, 0.00, 0.05, 2.95, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000011, 8001, 90101, 101010100, 10001, 120001, 2000001, 3, 103000031, 3000031, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000012, 8001, 90101, 101010100, 10002, 120002, 2000002, 3, 103000032, 3000032, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000013, 8001, 90101, 101010100, 10003, 120003, 2000003, 3, 103000033, 3000033, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000014, 8001, 90101, 101010100, 10004, 120004, 2000004, 3, 103000034, 3000034, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000015, 8001, 90101, 101010100, 10005, 120005, 2000005, 2, 103000035, 3000035, 'Teenagers (ages 13-25)', 1, 20.00, 2.60, 0.00, 4.00, 16.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000016, 8001, 90101, 101010100, 10001, 120006, 2000001, 3, 103000036, 3000036, 'Adults (ages 26-59)', 1, 5.50, 0.72, 0.00, 1.50, 4.00, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000017, 8001, 90101, 101010100, 10002, 120007, 2000002, 3, 103000037, 3000037, 'Adults (ages 26-59)', 1, 7.70, 1.00, 0.00, 1.85, 5.85, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000018, 8001, 90101, 101010100, 10003, 120008, 2000003, 3, 103000038, 3000038, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 1.00, 24.00, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000019, 8001, 90101, 101010100, 10004, 120009, 2000004, 3, 103000039, 3000039, 'Adults (ages 26-59)', 1, 12.00, 1.56, 0.00, 3.00, 9.00, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000020, 8001, 90101, 101010100, 10005, 120010, 2000005, 2, 103000040, 3000040, 'Teenagers (ages 13-25)', 1, 9.90, 1.29, 0.00, 1.00, 8.90, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000001, 8001, 90101, 101010101, 10001, 120001, 2000001, 3, 103000041, 3000041, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000002, 8001, 90101, 101010101, 10002, 120002, 2000002, 3, 103000042, 3000042, 'Adults (ages 26-59)', 1, 7.00, 0.91, 0.00, 1.05, 5.95, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000003, 8001, 90101, 101010101, 10003, 120003, 2000003, 3, 103000043, 3000043, 'Adults (ages 26-59)', 1, 8.00, 1.04, 0.00, 1.25, 6.75, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000004, 8001, 90101, 101010101, 10004, 120004, 2000004, 3, 103000044, 3000044, 'Adults (ages 26-59)', 1, 14.00, 1.82, 0.00, 3.00, 11.00, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000005, 8001, 90101, 101010101, 10005, 120005, 2000005, 2, 103000045, 3000045, 'Teenagers (ages 13-25)', 1, 25.00, 3.25, 0.00, 5.00, 20.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000006, 8001, 90101, 101010101, 10001, 120006, 2000001, 3, 103000046, 3000046, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 8.55, 16.45, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000007, 8001, 90101, 101010101, 10002, 120007, 2000002, 3, 103000047, 3000047, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 5.55, 9.45, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000008, 8001, 90101, 101010101, 10003, 120008, 2000003, 3, 103000048, 3000048, 'Adults (ages 26-59)', 1, 4.99, 0.65, 0.00, 0.50, 4.49, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000009, 8001, 90101, 101010101, 10004, 120009, 2000004, 3, 103000049, 3000049, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 1.75, 13.25, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000010, 8001, 90101, 101010101, 10005, 120010, 2000005, 2, 103000050, 3000050, 'Teenagers (ages 13-25)', 1, 3.00, 0.39, 0.00, 0.05, 2.95, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000011, 8001, 90101, 101010101, 10001, 120001, 2000001, 3, 103000051, 3000051, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000012, 8001, 90101, 101010101, 10002, 120002, 2000002, 3, 103000052, 3000052, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000013, 8001, 90101, 101010101, 10003, 120003, 2000003, 3, 103000053, 3000053, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000014, 8001, 90101, 101010101, 10004, 120004, 2000004, 3, 103000054, 3000054, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000015, 8001, 90101, 101010101, 10005, 120005, 2000005, 2, 103000055, 3000055, 'Teenagers (ages 13-25)', 1, 20.00, 2.60, 0.00, 4.00, 16.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000016, 8001, 90101, 101010101, 10001, 120006, 2000001, 3, 103000056, 3000056, 'Adults (ages 26-59)', 1, 5.50, 0.72, 0.00, 1.50, 4.00, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000017, 8001, 90101, 101010101, 10002, 120007, 2000002, 3, 103000057, 3000057, 'Adults (ages 26-59)', 1, 7.70, 1.00, 0.00, 1.85, 5.85, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000018, 8001, 90101, 101010101, 10003, 120008, 2000003, 3, 103000058, 3000058, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 1.00, 24.00, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000019, 8001, 90101, 101010101, 10004, 120009, 2000004, 3, 103000059, 3000059, 'Adults (ages 26-59)', 1, 12.00, 1.56, 0.00, 3.00, 9.00, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000020, 8001, 90101, 101010101, 10005, 120010, 2000005, 2, 103000060, 3000060, 'Teenagers (ages 13-25)', 1, 9.90, 1.29, 0.00, 1.00, 8.90, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000001, 8001, 90101, 101010101, 10001, 120001, 2000001, 3, 103000061, 3000061, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000002, 8001, 90101, 101010101, 10002, 120002, 2000002, 3, 103000062, 3000062, 'Adults (ages 26-59)', 1, 7.00, 0.91, 0.00, 1.05, 5.95, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000003, 8001, 90101, 101010101, 10003, 120003, 2000003, 3, 103000063, 3000063, 'Adults (ages 26-59)', 1, 8.00, 1.04, 0.00, 1.25, 6.75, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000004, 8001, 90101, 101010101, 10004, 120004, 2000004, 3, 103000064, 3000064, 'Adults (ages 26-59)', 1, 14.00, 1.82, 0.00, 3.00, 11.00, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000005, 8001, 90101, 101010101, 10005, 120005, 2000005, 2, 103000065, 3000065, 'Teenagers (ages 13-25)', 1, 25.00, 3.25, 0.00, 5.00, 20.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000006, 8001, 90101, 101010101, 10001, 120006, 2000001, 3, 103000066, 3000066, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 8.55, 16.45, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000007, 8001, 90101, 101010101, 10002, 120007, 2000002, 3, 103000067, 3000067, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 5.55, 9.45, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000008, 8001, 90101, 101010101, 10003, 120008, 2000003, 3, 103000068, 3000068, 'Adults (ages 26-59)', 1, 4.99, 0.65, 0.00, 0.50, 4.49, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000009, 8001, 90101, 101010101, 10004, 120009, 2000004, 3, 103000069, 3000069, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 1.75, 13.25, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000010, 8001, 90101, 101010101, 10005, 120010, 2000005, 2, 103000070, 3000070, 'Teenagers (ages 13-25)', 1, 3.00, 0.39, 0.00, 0.05, 2.95, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000011, 8001, 90101, 101010101, 10001, 120001, 2000001, 3, 103000071, 3000071, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000012, 8001, 90101, 101010101, 10002, 120002, 2000002, 3, 103000072, 3000072, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000013, 8001, 90101, 101010101, 10003, 120003, 2000003, 3, 103000073, 3000073, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000014, 8001, 90101, 101010101, 10004, 120004, 2000004, 3, 103000074, 3000074, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000015, 8001, 90101, 101010101, 10005, 120005, 2000005, 2, 103000075, 3000075, 'Teenagers (ages 13-25)', 1, 20.00, 2.60, 0.00, 4.00, 16.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000016, 8001, 90101, 101010101, 10001, 120006, 2000001, 3, 103000076, 3000076, 'Adults (ages 26-59)', 1, 5.50, 0.72, 0.00, 1.50, 4.00, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000017, 8001, 90101, 101010101, 10002, 120007, 2000002, 3, 103000077, 3000077, 'Adults (ages 26-59)', 1, 7.70, 1.00, 0.00, 1.85, 5.85, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000018, 8001, 90101, 101010101, 10003, 120008, 2000003, 3, 103000078, 3000078, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 1.00, 24.00, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000019, 8001, 90101, 101010101, 10004, 120009, 2000004, 3, 103000079, 3000079, 'Adults (ages 26-59)', 1, 12.00, 1.56, 0.00, 3.00, 9.00, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000020, 8001, 90101, 101010101, 10005, 120010, 2000005, 2, 103000080, 3000080, 'Teenagers (ages 13-25)', 1, 9.90, 1.29, 0.00, 1.00, 8.90, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000001, 8001, 90101, 101010101, 10001, 120001, 2000001, 3, 103000081, 3000081, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000002, 8001, 90101, 101010101, 10002, 120002, 2000002, 3, 103000082, 3000082, 'Adults (ages 26-59)', 1, 7.00, 0.91, 0.00, 1.05, 5.95, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000003, 8001, 90101, 101010101, 10003, 120003, 2000003, 3, 103000083, 3000083, 'Adults (ages 26-59)', 1, 8.00, 1.04, 0.00, 1.25, 6.75, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000004, 8001, 90101, 101010101, 10004, 120004, 2000004, 3, 103000084, 3000084, 'Adults (ages 26-59)', 1, 14.00, 1.82, 0.00, 3.00, 11.00, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000005, 8001, 90101, 101010101, 10005, 120005, 2000005, 2, 103000085, 3000085, 'Teenagers (ages 13-25)', 1, 25.00, 3.25, 0.00, 5.00, 20.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000006, 8001, 90101, 101010101, 10001, 120006, 2000001, 3, 103000086, 3000086, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 8.55, 16.45, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000007, 8001, 90101, 101010101, 10002, 120007, 2000002, 3, 103000087, 3000087, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 5.55, 9.45, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000008, 8001, 90101, 101010101, 10003, 120008, 2000003, 3, 103000088, 3000088, 'Adults (ages 26-59)', 1, 4.99, 0.65, 0.00, 0.50, 4.49, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000009, 8001, 90101, 101010101, 10004, 120009, 2000004, 3, 103000089, 3000089, 'Adults (ages 26-59)', 1, 15.00, 1.95, 0.00, 1.75, 13.25, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000010, 8001, 90101, 101010101, 10005, 120010, 2000005, 2, 103000090, 3000090, 'Teenagers (ages 13-25)', 1, 3.00, 0.39, 0.00, 0.05, 2.95, 'Emma', 'Female', 'Noah', 'Male')


INTO SALES VALUES (1000011, 8001, 90101, 101010101, 10001, 120001, 2000001, 3, 103000091, 3000091, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Margaret', 'Female', 'Olivia', 'Female')
INTO SALES VALUES (1000012, 8001, 90101, 101010101, 10002, 120002, 2000002, 3, 103000092, 3000092, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Elizabeth', 'Female', 'Liam', 'Male')
INTO SALES VALUES (1000013, 8001, 90101, 101010101, 10003, 120003, 2000003, 3, 103000093, 3000093, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Gladys', 'Female', 'James', 'Male')
INTO SALES VALUES (1000014, 8001, 90101, 101010101, 10004, 120004, 2000004, 3, 103000094, 3000094, 'Adults (ages 26-59)', 1, 5.00, 0.65, 0.00, 1.55, 3.45, 'Alex', 'Male', 'Mia', 'Female')
INTO SALES VALUES (1000015, 8001, 90101, 101010101, 10005, 120005, 2000005, 2, 103000095, 3000095, 'Teenagers (ages 13-25)', 1, 20.00, 2.60, 0.00, 4.00, 16.00, 'Amelia', 'Female', 'Noah', 'Male')

INTO SALES VALUES (1000016, 8001, 90101, 101010101, 10001, 120006, 2000001, 3, 103000096, 3000096, 'Adults (ages 26-59)', 1, 5.50, 0.72, 0.00, 1.50, 4.00, 'Logan', 'Male', 'Olivia', 'Female')
INTO SALES VALUES (1000017, 8001, 90101, 101010101, 10002, 120007, 2000002, 3, 103000097, 3000097, 'Adults (ages 26-59)', 1, 7.70, 1.00, 0.00, 1.85, 5.85, 'Leo', 'Male', 'Liam', 'Male')
INTO SALES VALUES (1000018, 8001, 90101, 101010101, 10003, 120008, 2000003, 3, 103000098, 3000098, 'Adults (ages 26-59)', 1, 25.00, 3.25, 0.00, 1.00, 24.00, 'Adam', 'Male', 'James', 'Male')
INTO SALES VALUES (1000019, 8001, 90101, 101010101, 10004, 120009, 2000004, 3, 103000099, 3000099, 'Adults (ages 26-59)', 1, 12.00, 1.56, 0.00, 3.00, 9.00, 'Amelia', 'Female', 'Mia', 'Female')
INTO SALES VALUES (1000020, 8001, 90101, 101010101, 10005, 120010, 2000005, 2, 103000100, 3000100, 'Teenagers (ages 13-25)', 1, 9.90, 1.29, 0.00, 1.00, 8.90, 'Emma', 'Female', 'Noah', 'Male')

SELECT * FROM dual;


INSERT ALL 
INTO DEFINITION_ VALUES (101, 'PRODUCTS', 'ProductID', 'Product identification code', '')
INTO DEFINITION_ VALUES (102, 'PRODUCTS', 'ProductName', 'Name of product', '')
INTO DEFINITION_ VALUES (103, 'PRODUCTS', 'SKU', 'Produact SKU code', '')
INTO DEFINITION_ VALUES (104, 'PRODUCTS', 'ProductColor', 'Color of product', '')
INTO DEFINITION_ VALUES (105, 'PRODUCTS', 'ProductDescr', 'Product description', '')
INTO DEFINITION_ VALUES (106, 'PRODUCTS', 'ProductCost', 'Product cost, CAD', '')
INTO DEFINITION_ VALUES (107, 'PRODUCTS', 'ProductPrice', 'Product price, CAD', '')
INTO DEFINITION_ VALUES (201, 'MARKETING_CAMPAIGN', 'MCampID', 'Marketing compaign identification code', '')
INTO DEFINITION_ VALUES (202, 'MARKETING_CAMPAIGN', 'MCampName', 'Marketing compaign name', '')
INTO DEFINITION_ VALUES (203, 'MARKETING_CAMPAIGN', 'MCampDescr', 'Marketing compaign description', '')
INTO DEFINITION_ VALUES (204, 'MARKETING_CAMPAIGN', 'DiscountAmount', 'Marketing compaign discount amount', '')
INTO DEFINITION_ VALUES (205, 'MARKETING_CAMPAIGN', 'MCampStartDate', 'Marketing compaign start date', '')
INTO DEFINITION_ VALUES (206, 'MARKETING_CAMPAIGN', 'MCampEndDate', 'Marketing compaign end date', '')
INTO DEFINITION_ VALUES (301, 'PAYMENT_METHODS', 'PayMethodID', 'Payment method identification code', '')
INTO DEFINITION_ VALUES (302, 'PAYMENT_METHODS', 'PayMethod', 'Payment method name', '')
INTO DEFINITION_ VALUES (303, 'PAYMENT_METHODS', 'PayMethodAmount', 'Payment method amount, CAD', '')
SELECT * FROM dual;


SELECT * FROM PRODUCTS;
SELECT * FROM MARKETING_CAMPAIGN;
SELECT * FROM PAYMENT_METHODS;
SELECT * FROM DATE_;
SELECT * FROM STORES;
SELECT * FROM EMPLOYEE;
SELECT * FROM CUSTOMERS;
SELECT * FROM DEMOGRAFIC_GROUPS;
SELECT * FROM SALES;
SELECT * FROM DEFINITION_;


DROP TABLE PRODUCTS;
DROP TABLE MARKETING_CAMPAIGN;
DROP TABLE PAYMENT_METHODS;
DROP TABLE DATE_;
DROP TABLE STORES;
DROP TABLE EMPLOYEE;
DROP TABLE CUSTOMERS;
DROP TABLE DEMOGRAFIC_GROUPS;
DROP TABLE SALES;
DROP TABLE DEFINITION_;
DROP TABLE CITY_POPULATION;
DROP TABLE LIFE_EXPECTANCY;
DROP TABLE NAMES;