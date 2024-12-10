SELECT *
FROM customer_sweepstakes_1
;

-- Rename column 
ALTER TABLE customer_sweepstakes_1
RENAME COLUMN `ï»¿sweepstake_id` TO `sweepstake_id`;

-- remove duplicates 
SELECT *
FROM customer_sweepstakes_1
;

-- find the duplicates - any row_num > 1  is a duplicate
SELECT 
	customer_id,
    ROW_NUMBER() OVER(partition by customer_id ORDER BY customer_id) AS row_num
FROM customer_sweepstakes_1;

-- removing duplicate- try to use with a cte
WITH duplicate_cte AS (
	SELECT
		customer_id,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id) AS row_num
    FROM customer_sweepstakes_1
)
DELETE FROM customer_sweepstakes_1
WHERE customer_id IN (
	SELECT customer_id
    FROM duplicate_cte
    WHERE row_num > 1

);

-- standardize phone column in (xxx-xxx-xxxx) format
SELECT
	phone,
    REGEXP_REPLACE(phone, '[-()/]', '')
FROM customer_sweepstakes_1;

UPDATE customer_sweepstakes_1
SET phone =   REGEXP_REPLACE(phone, '[-()/]', '')
;

SELECT
	phone,
    CONCAT( SUBSTRING(phone,1,3), '-',  SUBSTRING(phone,4,3), '-', SUBSTRING(phone,7,4)) AS phone_num

FROM customer_sweepstakes_1
WHERE phone <> '';

UPDATE customer_sweepstakes_1
SET phone = CONCAT( SUBSTRING(phone,1,3), '-',  SUBSTRING(phone,4,3), '-', SUBSTRING(phone,7,4))
WHERE phone <> '';

-- format the birth_date
SELECT birth_date,
		str_to_date(birth_date, '%m/%d/%Y'),
        str_to_date(birth_date, '%Y/%d/%m')
FROm customer_sweepstakes_1
;

SELECT birth_date,
str_to_date(birth_date, '%m/%d/%Y'),
        str_to_date(birth_date, '%Y/%d/%m')
FROm customer_sweepstakes_1
;

SELECT birth_date,
IF( str_to_date(birth_date, '%m/%d/%Y') IS NOT NULL,   str_to_date(birth_date, '%m/%d/%Y'),
str_to_date(birth_date, '%Y/%d/%m')),
str_to_date(birth_date, '%m/%d.%Y'),
str_to_date(birth_date, '%Y/%d/%m')
FROM customer_sweepstakes_1;

# use case statement, if statement
UPDATE  customer_sweepstakes_1
SET birth_date = CASE WHEN str_to_date(birth_date, '%m/%d/%Y') IS NOT NULL THEN str_to_date(birth_date, '%m/%d/%Y')
WHEN str_to_date(birth_date, '%m/%d/%Y') IS NULL THEN str_to_date(birth_date, '%Y/%d/%m')
END;

SELECT
	*,
	birth_date,
CONCAT(
    SUBSTRING(birth_date,9,2),'/',
    SUBSTRING(birth_date,6,2),'/',
    SUBSTRING(birth_date,1,4))
FROM customer_sweepstakes;

update customer_sweepstakes_1
SET  birth_date = CONCAT(
    SUBSTRING(birth_date,9,2),'/',
    SUBSTRING(birth_date,6,2),'/',
    SUBSTRING(birth_date,1,4))
WHERE sweepstake_id IN(9,11)
;


-- Are you over 18? standardize to 'Y' or 'N'
SELECT 
	`Are you over 18?`
FROM customer_sweepstakes_1
;

SELECT 
	`Are you over 18?`,
CASE
	WHEN `Are you over 18?` = 'Yes' THEN 'Y'
	WHEN `Are you over 18?` = 'No' THEN 'N'
    ELSE `Are you over 18?`
END
FROM customer_sweepstakes_1
;

update customer_sweepstakes_1 
SET `Are you over 18?` = 
CASE
	WHEN `Are you over 18?` = 'Yes' THEN 'Y'
	WHEN `Are you over 18?` = 'No' THEN 'N'
    ELSE `Are you over 18?`
END
;




-- Breaking down address column
SELECT Address,
	SUBSTRING_INDEX(address, ',',1) AS street
FROM customer_sweepstakes;

SELECT Address,
	SUBSTRING_INDEX(address, ',',-1) AS state
FROM customer_sweepstakes;

-- combine 
SELECT Address,
	SUBSTRING_INDEX(address, ',',1) AS street,
	SUBSTRING_INDEX(SUBSTRING_INDEX(address,',',2),',',-1) AS city,
    SUBSTRING_INDEX(address, ',',-1) AS state
FROM customer_sweepstakes;

-- add columns
ALTER TABLE  customer_sweepstakes_1
ADD COLUMN street VARCHAR(50) AFTER address
;


ALTER TABLE  customer_sweepstakes_1
ADD COLUMN city VARCHAR(50) AFTER street,
ADD COLUMN state VARCHAR(50) AFTER city
;

-- insert values in street, city, state
UPDATE customer_sweepstakes_1
SET street = SUBSTRING_INDEX(address, ',',1) ;

UPDATE customer_sweepstakes_1
SET city = SUBSTRING_INDEX(SUBSTRING_INDEX(address,',',2),',',-1) ;

UPDATE customer_sweepstakes_1
SET state =  SUBSTRING_INDEX(address, ',',-1);


-- After adding values to the state field, some state were lower case and not to standard
-- Play it safe trim all field to remove whitespace to clean it up
UPDATE customer_sweepstakes_1
SET state = UPPER(state)
;

-- Trim whitespace from street field 
UPDATE customer_sweepstakes_1
SET street = TRIM(street)
;

-- Trim whitespace in city field
UPDATE customer_sweepstakes_1
SET city = TRIM(city)
;

SELECT *
FROM customer_sweepstakes_1
;


-- notice phone have empty, to make it easier to evaluate and to later add
UPDATE customer_sweepstakes_1
SET phone = null
WHERE phone = ''
;

-- change empty records of income to null
UPDATE customer_sweepstakes_1
SET income = null 
WHERE income = '';

-- check if records were updated
SELECT *
FROM customer_sweepstakes_1
;

-- some of are you over 18? is incorrect
SELECT 
	birth_date,
    `Are you over 18?`
FROM customer_sweepstakes_1;

UPDATE customer_sweepstakes_1
SET `Are you over 18?` = 'Y'
WHERE YEAR(CURDATE()) - YEAR(birth_date) >= 18;


-- removing uncessary column
ALTER TABLE customer_sweepstakes_1
DROP COLUMN Address;

ALTER TABLE customer_sweepstakes_1
DROP COLUMN favorite_color;