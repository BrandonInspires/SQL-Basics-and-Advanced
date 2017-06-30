# SQL-Basics-and-Advanced
## Conventions
- UPPERCASE - Indicates a SQL Keyword (e.g. ```SELECT```, ```JOIN```, ```CREATE```)
- lowecase - Indicates a user defined item like a table name or column name
- _Italics_ - 
- ```code block``` - used for code examples

TODO: 
- Refactor example to be based on SQLPR sample data
- Examples for ACID Properties
- Get MySQL sample data file to work in POSTGRES

 ### All the examples in this repo use the sample data found in the sample data folder
# Foundational SQL
- [ ] Can describe primary key in SQL
```sql
-- A unique identifier for each record in a database table
-- Setting the primary key constraint
CREATE TABLE persons (
	ID Integer NOT NULL,
	FirstName VARCHAR(255),
	LastName VARCHAR(255),
	Age Integer, 
	PRIMARY KEY (ID)
)
-- OR 
CREATE TABLE people (
	ID Integer PRIMARY KEY NOT NULL,
)
```
Setting the primary key constraint on multiple fields
```sql
 CREATE TABLE people (
	 ID INTEGER NOT NULL,
	 LastName VARCHAR(255) NOT NULL,
	 FirstName VARCHAR(255),
	 CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
 )
```
- [ ] Can describe foreign key in SQL
```sql
/* A foreign key is a key that links two tables together
It's a field or collection of fields that refer to the primary key 
in another table
*/

CREATE TABLE addresses (
	Street VARCHAR(255),
	City VARCHAR(255),
	State VARCHAR(12)
	Name VARCHAR(255) FOREIGN KEY REFERENCES persons(ID)
)

```
- [ ] Can use select statement to return everything from a single table in SQL
```sql
SELECT * FROM addresses
```
- [ ] Can use select statement to return specific columns from a single table in - [ ] SQL
```sql
SELECT street FROM addresses
```
- [ ] Can use where clause to return a subset of the rows in a table in SQL
```sql
SELECT Name FROM addresses WHERE City = "Oakland"
```
- [ ] Can use join clause to join two tables on a primary key id in SQL
```sql
SELECT * FROM persons 
INNER JOIN addresses ON = 
```
- [ ] Can describe the difference between a left, right, inner and outer joins - [ ] in SQL
```sql

```
- [ ] Can use serial keyword to define a table with a auto sequencing primary - [ ] key in SQL
```sql

```
- [ ] Can select a subset of a table using a join in SQL
```sql

```
- [ ] Can define a table with a auto sequencing primary key in SQL
```sql

```
# Relational Database Design
- [ ] Can convert a mental model into a SQL schema
```sql

```
- [ ] Can describe a 1 to 1 relationship in SQL
```sql

```
- [ ] Can describe a 1 to many relationship in SQL
```sql

```
- [ ] Can describe a many to many relationship in SQL
```sql

```
- [ ] Can describe a SQL join
```sql

```
- [ ] Can describe a SQL join table
```sql

```
- [ ] Can describe SQL normalization
```sql

```
- [ ] Can describe SQL de-normalization
```sql

```
- [ ] Can describe SQL ACID principals
```
Atomicity - Is an indivisable and irreducible series of database operations where either all occur or nothing occurs. Atomicity prevents partial database updates by rejecting or reversing all partial transactions
Consistency - Is the guarantee that all specified rules including constraints, cascades, and triggers are followed when the database is updated
Isolation - is the principle of controlling concurrency effects across a database. Systems with higher levels of isolation have less concurrency effects (i.e. effects from multiple operations working on the same data) but consume higher levels of system resources and higher chances that one ongoing transaction will block another.
Durability - is the principle that committed transactions will permenantly survive (for instance, in the case of a system crash). This is usually accomplished by flushing the transaction's log records to non-volatile storage.
```
