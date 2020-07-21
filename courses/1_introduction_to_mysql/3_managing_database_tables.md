# Managing database tables

> Date: July 20, 2020

## Table field types

### Numerics

- Integers

Type		| Value (bytes)	| Max Value (signed) |
------------|---------------|--------------------|
TINYINT		|		1		|	127				 |
SMALLINT	|		2		|	32767			 |
MEDIUMINT 	|		3		|	8388607			 |
INT			|		4		|	2147483647		 |
BIGINT		|		8		|	2xE63 - 1		 |

> **UNSIGNED:** If the number type is unsigned, its min value is 0 and the max is 2 * <Max_signed> 

- Floating numbers
	- Float: simple precision (4 bytes)
		- Ex.: FLOAT(7,4): Declared a number up to 7 digits in total and 4 in the right side
		- In this case, if the number is 999.0000754, the storaged number will be 999.0001	

	- Double: double precision (8 bytes)

- Fixed decimals 
	- Size: Up to 65 digits
		- Ex.: DECIMAL(5,2): Declared a number up to 5 digits in total and 2 in the right side
		- In this case, the number have to be between -999.99 and 999.99
- Bit
	- Size: Up to 64 bits
		- Ex.: 
			- BIT(1): 0 or 1
			- BIT(2): 00, 01, 10 or 11	
	- Used when there is logic fields

- Attributes
	- Signed or unsigned;
	- Zerofill;
	- Auto increment
- OUT OF RANGE: When the number overflows its limit.

### Date and hour

- Formats and ranges
	- DATE: 1000-01-01 to 9999-12-31 23:59:59
	- DATETIME: 1000-01-01 00:00:00 to 9999-12-31 23:59:59 
	- TIMESTAMP:1970-01-01 00:00:01 UTC to 2038-01-19 UTC 
	- TIME: -838:59:59 to 839:59:59 
	- YEAR: 1901 - 2155 (can be expressed in the format of 2 or 4 bits)

### Strings

- CHAR: Chain with fixed value (0 to 255)
	- Ex.: CHAR(4): If the input is "aa", the storaged value will be "  aa"
- VARCHAR: Chain with variable value (0 to 255)
	- Ex.: VARCHAR(4): If the input is "aa", the storaged value will be "aa"
- BINARY: Chain with fixed value (0 to 255), storaged in binary
- VARBINARY: Chain with variable value (0 to 255), storaged in binary
- BLOB: Long Binary
	- TINYBLOB
	- BLOB
	- MEDIUMBLOB
	- LONGBLOB
- TEXT: Long text
	- TINYTEXT
	- TEXT
	- MEDIUMTEXT
	- LONGTEXT	
- ENUM: Allow to storage a pre-defined list of values
	- Ex.: Size ENUM('x-small', 'small', 'medium', 'large', 'x-large'). These are the only texts that can be storaged in the field.

- Attibutes:
	- SET and COLLATE: What kind of encoding text type we want to use.

### SPACIAL

- GEOMETRY
- POINT: Point in a graph
- LINESTRING: Line
- POLYGON
