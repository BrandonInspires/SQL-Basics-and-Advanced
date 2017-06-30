# SQL-Basics-and-Advanced
# Foundational SQL
- [ ] Can describe primary key in SQL
```sql
-- A unique identifier for each record a database table
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

```
- [ ] Can use select statement to return everything from a single table in SQL
```sql

```
- [ ] Can use select statement to return specific columns from a single table in - [ ] SQL
```sql

```
- [ ] Can use where clause to return a subset of the rows in a table in SQL
```sql

```
- [ ] Can use join clause to join two tables on a primary key id in SQL
```sql

```
- [ ] Can use limit clause to select a subset of a rows in SQL
```sql

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
```sql

```
