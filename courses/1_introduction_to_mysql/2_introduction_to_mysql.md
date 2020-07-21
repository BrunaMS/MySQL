# 2nd Class: Manipulating the data

> July 17, 2020

## Definitions

- The higher entity is the database itself.
	- Into the database there is a lot of other **entities**, that organize and storage the data and can be of several formats.

### Tables
- Have columns and rows;
- When we create a table we have to define its features (data type, number of fields - or columns);
- **Field types**: numeric (int or float), logic, text / string, binary, etc.
- The records (or rows) can be "infinite" and edited later, only the fields need to be defined before;
- The first field is named **Primary key field**, used to identify the user, data, or any information specific of this record;
	- It's like an index or a identity document, the code of the product or something like this;
	- This value can not repeat in two different records;
	- This column is optional;
	- We can have to primary key fields. In this case, the combination of these two informations can not be repeated. There is no problem if only one is being used in another record.
	
- **Foreign key fields:** Used to connect to tables with different data related to only one record;
	- For example, we can have one table with user data (e-mail, address, phone number etc) and other table with the products that this user bought;
	- This relationship between entities with foreign key fields is a feature of relational databases.

- We can have a **table schema**, dividing tables in different groups, according to their contents. 

### Query
- It is like a search into a lot of tables, usualy conected by foreign keys, generating a result/output.
- Using the `join` command, we can search in several tables and use **filters** to find records with the features that we want. E.g.: users that spent more than $150 in our online store or only products containing milk or only people living in USA or Brazil.

### View
- The output of a query can be placed into a view, that can be seen as a table, but with some rules and specific data.

### Procedures and functions
- A serie of calculations created to manipulate, compare etc with the data.

### Trigger
- A thing like an alarm that "goes off" when something happens. E.g.: Always I include a new record, create a new value in another table saying a tax, according to its profile.


## Creating a Database
- In the MySQL syntax, `DATABASE` and `SCHEMA` are synonyms.

> MySQL Reference Manual is available [here](https://dev.mysql.com/doc/refman/8.0/en/create-database.html). In it we can see how to create a database.

- In Ubuntu, we can find the datasets in the directory `/var/lib/mysql`.

- To use only english characters, we can set the encoding format as ASCII. But, we want to write the code using portuguese/brazilian characters, for example, we'll need to use utf-8 encoding.

## Dropping databases

- Syntax: `DROP DATABASE <database_name>`;
- This is a very useful and dangerous command. It will completely delete your database. Thereat sometimes only a **DBA** (Database administrator) has permission to create drop databases and use this command.
 
## Using mySQL from command line (Ubuntu bash)
```
mysql -u root -p
```

- `u root` - root is the user
- `p` - Using password

Now, into the MySQL, type:

```
create DATABASE JUICES_2;
```

> Don't Forget the `;`, the sql will consider that your comand is not finished

Output:

```
Query OK, 1 row affected (0.00 sec)
```

```
use <database>;
select * from <table>;
```

Example:

```
use world;
select * from city;
```
Output:

```
> Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

> +------+------------------------------------+-------------+------------------------+------------+
| ID   | Name                               | CountryCode | District               | Population |
+------+------------------------------------+-------------+------------------------+------------+
|    1 | Kabul                              | AFG         | Kabol                  |    1780000 |
|    2 | Qandahar                           | AFG         | Qandahar               |     237500 |
|    3 | Herat                              | AFG         | Herat                  |     186800 |
|    4 | Mazar-e-Sharif                     | AFG         | Balkh                  |     127800 |
|    5 | Amsterdam                          | NLD         | Noord-Holland          |     731200 |
|    6 | Rotterdam                          | NLD         | Zuid-Holland           |     593321 |
|    7 | Haag                               | NLD         | Zuid-Holland           |     440900 |
|    8 | Utrecht                            | NLD         | Utrecht                |     234323 |
|    9 | Eindhoven                          | NLD         | Noord-Brabant          |     201843 |
|   10 | Tilburg                            | NLD         | Noord-Brabant          |     193238 |
|   11 | Groningen                          | NLD         | Groningen              |     172701 |
|   12 | Breda                              | NLD         | Noord-Brabant          |     160398 |
|   13 | Apeldoorn                          | NLD         | Gelderland             |     153491 |
|   14 | Nijmegen                           | NLD         | Gelderland             |     152463 |
|   15 | Enschede                           | NLD         | Overijssel             |     149544 |
...
```
> The table has "just" 4079 rows and I decided don't put it all here. 
