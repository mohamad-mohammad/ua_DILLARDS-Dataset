create view SDeInfo as
# JOINING SKUINFO WITH DEPTINFO TABLES
SELECT s.sku, s.dept, s.classid, s.upc, s.style, s.color, s.size, s.packsize, s.vendor, s.brand, de.deptdesc from
 skuinfo s left join deptinfo de on s.dept=de.dept;
 #........................................................................
 CREATE VIEW SKTR AS
 #joining skstinfo with strinfo
 SELECT sk.sku, sk.store, sk.cost, sk.retail, str.city, str.state, str.zip FROM
 FIXED_SKSTINFO sk left join strinfo str ON sk.store=str.store;
 #..........................................................................
CREATE VIEW table_1 AS
# joining Many-To-Many tables (strinfo, skstinfo, skuinfo)
SELECT SKTR.sku, SDeInfo.dept, SDeInfo.classid, SDeInfo.upc, SDeInfo.style, SDeInfo.color, SDeInfo.size, SDeInfo.packsize
, SDeInfo.vendor, SDeInfo.brand, SDeInfo.deptdesc, SKTR.store, SKTR.cost, SKTR.retail,
 SKTR.city, SKTR.state, SKTR.zip 
 FROM
SDeInfo
JOIN
SKTR
ON SDeInfo.sku=SKTR.sku;
#..............................................................................

create view table_2 AS

#This view contain join of trnsact with strore_msa

SELECT tr.sku, tr.store, tr.register, tr.trannum, tr.interid, tr.saledate, tr.stype, tr.quantity,
tr.orgprice, tr.sprice, tr.amt, tr.seq, tr.mic,
msa.state, msa.zip, msa.msa, msa.msa_name, msa.msa_pop, msa.census_region, msa.latitude,
 msa.longitude, msa.msa_income, msa.msa_high, msa.msa_bach FROM
 
 FIXED_TRNSACT tr left join store_msa msa ON tr.store=msa.store;


#..............................................................................
CREATE VIEW table_3 AS
#jOIN ALL TABLES TOGETHER
SELECT "sku", "dept", "classid", "upc", "style", "color", "size", "packsize",
 "vendor", "brand", "deptdesc", "store", "cost", "retail",
"state", "zip", 
 "register", "trannum", "interid", "saledate", "stype", "quantity",
"orgprice", "sprice", "amt", "seq", "mic",
"msa", "msa_name", "msa_pop", "census_region", "latitude",
 "longitude", "msa_income", "msa_high", "msa_bach"
UNION ALL

SELECT tb1.sku, tb1.dept, tb1.classid, tb1.upc, tb1.style, tb1.color, tb1.size, tb1.packsize,
 tb1.vendor, tb1.brand, tb1.deptdesc, tb1.store, tb1.cost, tb1.retail,
 tb1.state, tb1.zip, 
 tb2.register, tb2.trannum, tb2.interid, tb2.saledate, tb2.stype, tb2.quantity,
tb2.orgprice, tb2.sprice, tb2.amt, tb2.seq, tb2.mic,
tb2.msa, tb2.msa_name, tb2.msa_pop, tb2.census_region, tb2.latitude,
 tb2.longitude, tb2.msa_income, tb2.msa_high, tb2.msa_bach
FROM
table_1 tb1
INNER JOIN
table_2 tb2
ON tb1.sku=tb2.sku ;
#..................................................................................

SELECT * FROM table_3
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CDILLARDS_DatasetINNER3.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"';
 
