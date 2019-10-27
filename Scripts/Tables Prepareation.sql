#The data in the tables are Inconsistent (Foreign keys and #Primary keys)
#Table skstinfo, Rerieve only the rows that have "sku" that exists in skuinfo table
CREATE VIEW FIXED_SKSTINFO AS
SELECT * 
FROM SKSTINFO SK
WHERE  EXISTS 
(SELECT *
FROM SKUINFO S
WHERE SK.SKU=S.SKU);

#..........................................................................

#Table trnsact, Retrieve only the rows that have "sku" that exists in skuinfo table
CREATE VIEW FIXED_TRNSACT AS
SELECT * 
FROM TRNSACT TR
WHERE  EXISTS 
(SELECT *
FROM SKUINFO S
WHERE TR.SKU=S.SKU);