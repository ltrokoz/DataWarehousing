USE dbw624;

-- 5 performance enhancements to the data warehouse

-- ********************************************************************************
-- #1 SUMMARY TABLE is a performance necessity for large and complex table. 
-- Summary table conveys information about the organization of the data in a table and helps users navigate it.
SELECT 
	employee.EmployeeFirstName AS Employee,
    stores.StoreName AS Store,
    SUM(sales.Amount) AS Amount
FROM sales
INNER JOIN employee 
ON (sales.EmployeeID = employee.id) 
INNER JOIN stores 
ON (sales.StoreID = stores.id) 
GROUP BY stores.StoreName, employee.id
ORDER BY stores.StoreName, Amount DESC;

-- ********************************************************************************
-- #2 INDEX improves the speed of data retrieval operations on a database table 
-- at the cost of additional writes and storage space to maintain the index data structure. 
-- Indexes are used to quickly locate data without having to search every row in a database 
-- table every time a database table is accessed. Indexes can be created using one or 
-- more columns of a database table, providing the basis for both rapid random lookups 
-- and efficient access of ordered records (Source: https://en.wikipedia.org/wiki/Database_index).
DROP INDEX amount_index ON sales;

CREATE INDEX amount_index ON sales (Amount);

-- ********************************************************************************
-- #3 HASH PARTITIONING is a method of separating out rows and spreading them evenly in sub-tables within databases. 
-- It is selected based on the value returned by a user-defined expression. 
-- This expression operates on column values in rows that will be inserted into the table 

DROP TABLE IF EXISTS hash_partition_products;
CREATE TABLE hash_partition_products (
	id int,
	ProductName varchar(30) NOT NULL,
	SKU varchar(30) NOT NULL,
	ProductColor varchar(30) NOT NULL,
	ProductDescr varchar(100) NOT NULL,
	ProductCost decimal(6,2) NOT NULL DEFAULT 0.00,
	ProductPrice decimal(6,2) NOT NULL DEFAULT 0.00,
	DemogrGrID int,
	PRIMARY KEY (id)
)
PARTITION BY HASH(id)
PARTITIONS 4;

-- ********************************************************************************
-- #4 RANGE PARTITION allows to partition the rows of a table based on column values that fall within a specified range.
-- The given range is always in a contiguous form but should not overlap each other.

DROP TABLE IF EXISTS range_partition_employee;
CREATE TABLE range_partition_employee (
  id int,
  EmployeeFirstName varchar(30) NOT NULL,
  EmployeeLastName varchar(30) NOT NULL,
  EmployeeTitle varchar(30) NOT NULL,
  EmployeeGender varchar(30) NOT NULL,
  PRIMARY KEY (id)
)
PARTITION BY RANGE (id) (
  PARTITION e0 VALUES LESS THAN (120001),
  PARTITION e1 VALUES LESS THAN (120005),
  PARTITION e2 VALUES LESS THAN (120010),
  PARTITION e3 VALUES LESS THAN MAXVALUE
);
  
-- ********************************************************************************
-- #5 COMPRESSION allows to create tables where the data is stored in compressed form.
-- Compression helps to improve both raw performance and scalability. 
-- The compression means less data is transferred between disk and memory, 
-- and takes up less space on disk and in memory. 
-- The benefits are amplified for tables with secondary indexes, 
-- because index data is compressed also (Source: https://dev.mysql.com/doc/refman/8.0/en/innodb-compression.html).

DROP TABLE IF EXISTS compression_employee;
DROP TABLESPACE ts01;
CREATE TABLESPACE ts01 ADD DATAFILE 'ts01.ibd' FILE_BLOCK_SIZE = 8192 Engine=InnoDB;
CREATE TABLE compression_employee (
  id int,
  EmployeeFirstName varchar(30) NOT NULL,
  EmployeeLastName varchar(30) NOT NULL,
  EmployeeTitle varchar(30) NOT NULL,
  EmployeeGender varchar(30) NOT NULL,
  PRIMARY KEY (id)
)
TABLESPACE ts01 
ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8;

SELECT * FROM compression_employee;
  
-- ********************************************************************************
-- #6 STORED PROCEDURE reduces the traffic between application and database server, 
-- centralizes business logic in the database, makes database more secure. 

DROP PROCEDURE IF EXISTS productcount;

DELIMITER //
CREATE PROCEDURE productcount (OUT productTotal int)
BEGIN
SELECT COUNT(*) INTO productTotal
FROM products;    
END//
DELIMITER ;
CALL productcount(@productTotal);
SELECT @productTotal;