USE dbw624;

-- ********************************************************************************
-- **********************************   NAMES   ***********************************
-- ********************************************************************************

DROP TABLE IF EXISTS csv_baby_names;

CREATE TABLE csv_baby_names (
`Year` int,
`Name` varchar(30),
Frequency int,
Gender varchar(10)
);

SELECT * FROM csv_baby_names;

LOAD DATA INFILE 'C:/Program Files/MySQL/tmp/1_baby_names.csv' 
INTO TABLE csv_baby_names 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS names_;

CREATE TABLE names_ (
  NameID int AUTO_INCREMENT,
  Name_ varchar(30) NOT NULL,  
  Gender varchar(20) NOT NULL,
  NameRank int NOT NULL,
  Year_n int NOT NULL,
  PRIMARY KEY (NameID),
  CONSTRAINT NameRank CHECK (NameRank > 0),
  CONSTRAINT Year_n CHECK (Year_n > 0)
)
SELECT 
	`Name` AS Name_,
    Gender,
	Frequency AS NameRank,
	`Year` AS Year_n
FROM csv_baby_names
WHERE Frequency >= 200;

SELECT * FROM names_;

-- ********************************************************************************
-- *******************************   POPULATION   *********************************
-- ********************************************************************************

DROP TABLE IF EXISTS csv_population;

CREATE TABLE csv_population (
REF_DATE varchar(10),
GEO varchar(50),
DGUID varchar(20) DEFAULT '',
Sex varchar(12),
`Age group` varchar(20),
UOM varchar(10),
UOM_ID int,
SCALAR_FACTOR varchar(10),
SCALAR_ID int,
VECTOR varchar(12),
COORDINATE varchar(10),
`VALUE` int,
`STATUS` varchar(10) DEFAULT '',
SYMBOL varchar(10) DEFAULT '',
`TERMINATED` varchar(10) DEFAULT '',
DECIMALS int
);

SELECT * FROM csv_population;

LOAD DATA INFILE 'C:/Program Files/MySQL/tmp/2_population.csv' 
INTO TABLE csv_population 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS city_population;

CREATE TABLE city_population (
  CityPopulationID int AUTO_INCREMENT,
  GEO varchar(50) NOT NULL,
  Population int DEFAULT 0,
  Year_p int DEFAULT 2021,
  PRIMARY KEY (CityPopulationID),
  CONSTRAINT Population CHECK (Population > 0),
  CONSTRAINT Year_p CHECK (Year_p > 0)
)
SELECT 
	GEO,    
	`VALUE` as Population,
	REF_DATE as Year_p    
FROM csv_population
WHERE `Age group`='All ages';

SELECT * FROM city_population;

-- ********************************************************************************
-- *******************************   LIFE EXPANSY   *******************************
-- ********************************************************************************

DROP TABLE IF EXISTS csv_life_expansy;

CREATE TABLE csv_life_expansy (
REF_DATE varchar(10),
GEO varchar(50),
DGUID varchar(10) DEFAULT '',
Sex varchar(12),
`Life expectancy` varchar(12),
UOM varchar(10),
UOM_ID int,
SCALAR_FACTOR varchar(10),
SCALAR_ID int,
VECTOR varchar(12),
COORDINATE varchar(10),
`VALUE` int,
`STATUS` varchar(10) DEFAULT '',
SYMBOL varchar(10) DEFAULT '',
`TERMINATED` varchar(10) DEFAULT '',
DECIMALS int
);

SELECT * FROM csv_life_expansy;

LOAD DATA INFILE 'C:/Program Files/MySQL/tmp/3_life_expansy.csv' 
INTO TABLE csv_life_expansy 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE IF EXISTS life_expectancy;

CREATE TABLE life_expectancy (
  LifeExpectancyID int AUTO_INCREMENT,
  GEO varchar(30) NOT NULL,
  Gender varchar(30) NOT NULL,
  LifeExpectancy int NOT NULL,
  YearOfBirth_from int DEFAULT '2020',
  YearOfBirth_to int DEFAULT '2021',
  PRIMARY KEY (LifeExpectancyID),
  CONSTRAINT LifeExpectancy CHECK (LifeExpectancy > 0),
  CONSTRAINT YearOfBirth_from CHECK (YearOfBirth_from > 0),
  CONSTRAINT YearOfBirth_to CHECK (YearOfBirth_to > 0)
)
SELECT 
	GEO,    
    Sex AS Gender,
	`VALUE` AS LifeExpectancy,
	SUBSTRING_INDEX(REF_DATE, '/', 1) AS YearOfBirth_from,
    SUBSTRING_INDEX(SUBSTRING_INDEX(REF_DATE, '/', 2), '/', -1) AS YearOfBirth_to
FROM csv_life_expansy
WHERE `Life expectancy`='At birth';

SELECT * FROM life_expectancy;