USE dominos_sales_db;

LOAD DATA LOCAL INFILE
'D:/docs/projects/dominos_mysql_simple_github_ready/dominos_mysql_simple_project/data/dominos_sales.csv'
INTO TABLE dominos_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT *
FROM dominos_sales
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM dominos_sales;