-- ------------------------------------------- Entities ------------------------------------------- --
/*
	1. Tables
		- Fields / columns (defined when the table was created)
        - Records / rows (can be added during the code)
        - Keys
			- Primary key (identifier of the records, can not be repeated)
            - Foreign key (identifier between data into different tables)
            - Index (record positions into a table)
				- When a Primary or foreign key is created, automatically the SQL create index to this records
	2. View (logic table built using queries)
	3. Query - Search into one or various tables 
	4. Procedures and functions - Functions out of the ANSI standard. Different between each SQL (MySQL, Microsoft SQL Server etc)
	5. Triggers - Rules that can be made into the script
*/


-- ----------------------------------------- Data Types ----------------------------------------- --
/*
1. Numeric types
	- Integer types
		- TINYINT 	| 	1 Byte
		- SMALLINT	| 	2 Bytes
		- MEDIUMINT | 	3 Bytes
		- INT 		| 	4 Bytes
		- BIGINT 	| 	8 Bytes
	- Decimal types
		- FLOAT (4 bytes): single precision 
		- DOUBLE (8 bytes): double precision
        - DECIMAL OR NUMERIC: Up to 65 digits. Its size is defined (does not change according to the number)
	- Binary types
		- BIT: Contains only zeros or/and ones
	- Properties 
		- UNSIGNED: Only zero and positive numbers
        - SIGNED: Negative, positive numbers and zero
        - ZEROFILL: Fill out the number with zeros
        - AUTO_INCREMENT: Create a sequency grows or wanes automatically
	- Errors
		- OUT OF RANGE: Overflow
2. Date Types
	- DATE: 1000-01-01 up to 9999-12-31
    - DATETIME: 1000-01-01 00:00:00 up to 9999-12-31 23:59:59
    - TIMESTAMP: 1970-01-01 00:00:01 UTC up to 2038-01-19 UTC
    - TIME: +/- 838:59:59
    - YEAR: 1901 -> 20155 (2 or 4 digits)
3. Strings
	- CHAR (0 to 255 characters)
    - VARCHAR (0 to 255 characters)
    - BINARY (0 to 255 characters)
    - BLOB (long binary) 
    - TEXT
    - ENUM: Values pre-defined
    
    - Atributes
		- SET
        - COLLATE
4. Spacial
	-- Usualy used with maps and graphs
    - GEOMETRY
    - POINT
    - LINESTRING
    - POLYGON
        
*/

-- ----------------------------------------- MODELING ----------------------------------------- --
/*
- DATABASE PROJECT
	1. Requirements analysis
		- According to the reality of the company
    2. Conceptual Model
		- Relationship Diagram

*/