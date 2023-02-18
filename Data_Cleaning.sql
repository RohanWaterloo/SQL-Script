-- check if there is any invalid value for zip in IO_Utilities
SELECT "zip"
FROM "IO_Utilities"
WHERE "zip" NOT SIMILAR TO '\d{5}'
-- there is no output on the console

-- check if there is any invalid value for zip in NIO_Utilities
SELECT "zip"
FROM "NIO_Utilities"
WHERE "zip" NOT SIMILAR TO '\d{5}'
-- there is no output on the console

-- check if there is any inavlid state abbreviation in IO_Utilities
SELECT *
FROM "IO_Utilities"
WHERE "state" NOT SIMILAR TO '[A-Z][A-Z]'
-- there is no output on the console

-- check if there is any inavlid state abbreviation in NIO_Utilities
SELECT *
FROM "NIO_Utilities"
WHERE "state" NOT SIMILAR TO '[A-Z][A-Z]'
-- there is no output on the console

-- checking for duplicate eiaid column values in both tables
SELECT "eiaid"
FROM "IO_Utilities"
INTERSECT
SELECT "eiaid"
FROM "NIO_Utilities"
-- no output on the console

-- checking for duplicate utility_name column values in both tables
SELECT "utility_name"
FROM "IO_Utilities"
INTERSECT
SELECT "utility_name"
FROM "NIO_Utilities"
-- no output on the console

-- checking for duplicate ownership column values in both tables
SELECT "ownership"
FROM "IO_Utilities"
INTERSECT
SELECT "ownership"
FROM "NIO_Utilities"
-- no output on the console
-- this is required because the ownerships need to be different for Investor Owned Utilties and Non Investor Owned Utilities

-- extracting the final table to be used for analysis in Tableau
WITH "utilities" AS 
(
	SELECT *
	FROM "IO_Utilities"
	UNION
	SELECT *
	FROM "NIO_Utilities"
)

SELECT "utilities".*,"StateAbbs"."state name"
FROM "StateAbbs"
LEFT OUTER JOIN "utilities"
ON "utilities"."state" = "StateAbbs"."state"
-- this table is downloaded and then used in Tableau for further visualization
