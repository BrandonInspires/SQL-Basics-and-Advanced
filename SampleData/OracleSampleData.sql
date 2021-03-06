SET ECHO ON
SET DEFINE OFF
SPOOL OracleSampleData

ALTER SESSION SET NLS_DATE_FORMAT = 'dd-Mon-yyyy';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'English';

/*****************************************
 U.P. Attraction Tables
*****************************************/
DROP TABLE attraction;
DROP TABLE alger_attractions;
DROP TABLE marquette_attractions;
DROP TABLE other_attractions;
DROP TABLE attraction_urls;
DROP TABLE attraction_names;
DROP TABLE city;
DROP TABLE county;
DROP VIEW city_attractions;

CREATE TABLE county (
   county_id NUMBER,
   county_name VARCHAR2(15),
   state CHAR(2),
   CONSTRAINT county_pkey
      PRIMARY KEY (county_id))
   PARTITION BY RANGE (state)
   SUBPARTITION BY HASH (county_id) (
      PARTITION county_01 VALUES LESS THAN ('MI'),
      PARTITION michigan VALUES LESS THAN ('MJ')
         (SUBPARTITION michigan01),
      PARTITION county_02 VALUES LESS THAN (MAXVALUE));

CREATE TABLE new_counties (
   county_id NUMBER,
   county_name VARCHAR2(15),
   state CHAR(2));

CREATE TABLE city (
   city_id NUMBER,
   city_name VARCHAR2(16),
   county_id NUMBER,
   CONSTRAINT city_pkey
      PRIMARY KEY (city_id),
   CONSTRAINT city_in_county
      FOREIGN KEY (county_id)
      REFERENCES county);

CREATE TABLE attraction (
   attraction_id NUMBER,
   attraction_name VARCHAR2(35),
   attraction_url VARCHAR2(40),
   government_owned CHAR(1),
   city_id NUMBER,
   CONSTRAINT attraction_pkey
      PRIMARY KEY (attraction_id),
   CONSTRAINT attraction_in_city
      FOREIGN KEY (city_id)
      REFERENCES city,
   CONSTRAINT government_owned_yn
      CHECK (government_owned IN ('Y','N')));

CREATE TABLE alger_attractions (
   attraction_id NUMBER,
   attraction_name VARCHAR2(35),
   attraction_url VARCHAR2(40),
   government_owned CHAR(1),
   city_id NUMBER);

CREATE TABLE marquette_attractions (
   attraction_id NUMBER,
   attraction_name VARCHAR2(35),
   attraction_url VARCHAR2(40),
   government_owned CHAR(1),
   city_id NUMBER);

CREATE TABLE other_attractions (
   attraction_id NUMBER,
   attraction_name VARCHAR2(35),
   attraction_url VARCHAR2(40),
   government_owned CHAR(1),
   city_id NUMBER);

CREATE TABLE attraction_urls (
   id NUMBER,
   url VARCHAR2(40));

CREATE TABLE attraction_names (
   id NUMBER,
   name VARCHAR2(35));

CREATE VIEW city_attractions
(city_name, attraction_name)
AS SELECT city_name, attraction_name
FROM city c INNER JOIN attraction a
     ON c.city_id = a.city_id;

INSERT INTO county VALUES (1,'Alger','MI');
INSERT INTO county VALUES (2,'Marquette','MI');
INSERT INTO county VALUES (3,'Chippewa','MI');
INSERT INTO county VALUES (4,'Mackinac','MI');
INSERT INTO county VALUES (5, 'Delta','MI');
INSERT INTO county VALUES (6, 'Luce','MI');
INSERT INTO county VALUES (7, 'Schoolcraft','MI');
INSERT INTO county VALUES (8, 'Menominee','MI');
INSERT INTO county VALUES (9, 'Dickenson','MI');
INSERT INTO county VALUES (10, 'Baraga','MI');
INSERT INTO county VALUES (11, 'Houghton','MI');
INSERT INTO county VALUES (12, 'Keweenaw','MI');
INSERT INTO county VALUES (13, 'Ontonagon','MI');
INSERT INTO county VALUES (14, 'Gogebic','MI');
INSERT INTO county VALUES (15, 'Iron','MI');
INSERT INTO county VALUES (16, 'Wane','MI');
INSERT INTO county VALUES (18, 'McComb','MI');

INSERT INTO new_counties VALUES (1,'Alger','MI');
INSERT INTO new_counties VALUES (2,'Marquette','MI');
INSERT INTO new_counties VALUES (3,'Chippewa','MI');
INSERT INTO new_counties VALUES (16,'Wayne','MI');
INSERT INTO new_counties VALUES (17,'Oakland','MI');
INSERT INTO new_counties VALUES (18,'Macomb','MI');

INSERT INTO city VALUES (1,'Munising',1);
INSERT INTO city VALUES (2,'St. Ignace',4);
INSERT INTO city VALUES (3,'Marquette',2);
INSERT INTO city VALUES (4,'Iron River',15);
INSERT INTO city VALUES (5,'Bessemer',14);
INSERT INTO city VALUES (6,'Silver City',13);
INSERT INTO city VALUES (7,'Copper Harbor',12);
INSERT INTO city VALUES (8,'Hancock',11);
INSERT INTO city VALUES (9,'L''Anse',10);
INSERT INTO city VALUES (10,'Vulcan',9);
INSERT INTO city VALUES (11,'Carbondale',8);
INSERT INTO city VALUES (12,'Germfask',7);
INSERT INTO city VALUES (13,'Newberry',6);
INSERT INTO city VALUES (14,'Gladstone',5);
INSERT INTO city VALUES (15,'Sault Ste. Marie',3);
INSERT INTO city VALUES (16,'Ishpeming',2);
INSERT INTO city VALUES (17,NULL,1);
INSERT INTO city VALUES (18,'Brimley',3);


/* Alger County */
INSERT INTO attraction VALUES (1, 'Pictured Rocks',
                               'www.nps.gov/piro/',
                               'Y', 1);
INSERT INTO attraction VALUES (2, 'Valley Spur',
                               'www.valleyspur.com',
                               'Y', 1);
INSERT INTO attraction VALUES (3, 'Shipwreck Tours',
                               'www.shipwrecktours.com',
                               'N', 1);

INSERT INTO attraction VALUES (23, 'Grand Sable Dunes',
                               NULL, NULL, NULL);

/* Marquette County */
INSERT INTO attraction VALUES (4, 'Ski Hall of Fame',
                               'www.skihall.com',
                               'N', 16);
INSERT INTO attraction VALUES (5, 'Da Yoopers Tourist Trap',
                               'www.dayoopers.com',
                               'N', 16);
INSERT INTO attraction VALUES (6, 'Marquette County Historical Museum',
                               'www.marquettecohistory.org',
                               'N', 3);
INSERT INTO attraction VALUES (7, 'Upper Peninsula Children''s Museum',
                               'www.upcmkids.org',
                               'N', 3);
INSERT INTO attraction VALUES (8, 'Marquette Maritime Museum',
                               'mqtmaritimemuseum.com',
                               'N', 3);

/* Chippewa County */
INSERT INTO attraction VALUES (9, 'Valley Camp',
                               'www.thevalleycamp.com',
                               'N', 15);

/* Mackinac County */
INSERT INTO attraction VALUES (10, 'Mackinac Bridge',
                               'www.mackinacbridge.org',
                               'Y', 2);

/* Delta County */
INSERT INTO attraction VALUES (11, 'Hoegh Pet Casket Company',
                               'hoegh.abka.com',
                               'N', 14);

/* Luce County */
/* Nothing for Luce County. This is on purpose, because
   I need one county with no attractions to demonstrate
   certain GROUP BY behavior. */

/* Schoolcraft County */
INSERT INTO attraction VALUES (12, 'Seney National Wildlife Refuge',
                               'midwest.fws.gov/seney/',
                               'Y', 12);

/* Menominee */
INSERT INTO attraction VALUES (13, 'Wells State Park',
                               NULL,'Y',NULL);

/* Dickenson */
/* Nothing for Dickenson either. */

/* Baraga */
INSERT INTO attraction VALUES (14, 'Bishop Baraga Shrine',
                               'www.baragashrine.com',
                               'N', 9);

INSERT INTO attraction VALUES (15, 'Mount Arvon',
                               NULL,NULL,NULL);

/* Houghton */
INSERT INTO attraction VALUES (16,'Quincy Steam Hoist',
                               'www.quincymine.com',
                               'N',8);
INSERT INTO attraction VALUES (17,'Temple Jacob',
                               'www.uahc.org/mi/mi010',
                               'N',8);
INSERT INTO attraction VALUES (18,'Finlandia University',
                               'www.finlandia.edu',
                               'N',8);

/* Keweenaw */
INSERT INTO attraction VALUES (19,'Fort Wilkins State Park',
                               NULL,'Y',7);

/* Ontonagon */
INSERT INTO attraction VALUES (20,'Porcupine Mountain Wilderness',
                               NULL,'Y',6);

/* Gogebic */
INSERT INTO attraction VALUES (21,'Copper Peak Ski Flying Hill',
                               'www.westernup.com/copperpeak/',
                               'N',5);

/* Iron */
INSERT INTO attraction VALUES (22,'Iron County Historical Museum',
                               'www.ironcountymuseum.com',
                               'N',4);

COMMIT;



/*****************************************
 CD Tables
*****************************************/
DROP VIEW cd_song;
DROP TYPE song_table;
DROP TYPE song_type;
DROP TABLE song;
DROP TABLE cd;
DROP TABLE "CD Table";
DROP TABLE artist;

CREATE TABLE artist (
    name VARCHAR2(15),
    website VARCHAR2(25) DEFAULT 'no URL',
    CONSTRAINT artist_pk
        PRIMARY KEY (name));

CREATE TABLE cd (
    cd_id NUMBER,
    title VARCHAR2(35),
    price NUMBER(4,2),
    total_time NUMBER,
    artist VARCHAR2(15),
    first_track VARCHAR2(36),
    CONSTRAINT cd_pk
        PRIMARY KEY (cd_id),
    CONSTRAINT cd_unique
        UNIQUE (title));

CREATE TABLE song (
    cd_id NUMBER,
    track NUMBER,
    title VARCHAR2(36),
    playing_time NUMBER,
    artist VARCHAR2(15),
    CONSTRAINT song_pk
        PRIMARY KEY (cd_id, track),
    CONSTRAINT cd_fk
        FOREIGN KEY (cd_id)
        REFERENCES cd,
    CONSTRAINT artist_fk
        FOREIGN KEY (artist)
        REFERENCES artist);

CREATE TYPE song_type AS OBJECT (
    track NUMBER,
    title VARCHAR2(36),
    playing_time NUMBER);
/

CREATE TYPE song_table
   AS TABLE OF song_type;
/

CREATE VIEW cd_song
   (cd_id, title, songs)
AS (SELECT c.cd_id, c.title,
           CAST(MULTISET
               (SELECT s.track, s.title, s.playing_time
               FROM song s
               WHERE s.cd_id = c.cd_id) AS song_table)
    FROM cd c);

INSERT INTO artist VALUES ('Carl Behrend','www.GreatLakesLegends.com');
INSERT INTO artist VALUES ('Rondi Olson','www.milknhoney.org');
INSERT INTO artist VALUES ('Jenny Gennick');

INSERT INTO cd VALUES (1,'Legends of the Great Lakes',17.95);
INSERT INTO cd VALUES (2,'Nothing Less',10.00);
INSERT INTO cd VALUES (3,'More Legends of the Great Lakes',17.95);
INSERT INTO cd VALUES (4,'The Ballad of Seul Choix',17.95);
INSERT INTO cd VALUES (5,'Seeing the Unseen',10);

/* Legends of the Great Lakes */
INSERT INTO song VALUES (1,1,'The Christmas Ship',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,2,'Lake Superior Song',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,3,'Captain Bundy''s Gospel Ship',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,4,'Ballad of Seul Choix',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,5,'What Do You Do With a Drunken Sailor',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,6,'Dream on a Winters Night',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,7,'Porcupine Mountains Wilderness Song',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,8,'Just a Memory',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,9,'Wanda Fey',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,10,'What Would I Be Without Love',NULL,'Carl Behrend');
INSERT INTO song VALUES (1,11,'How Many Stars',NULL,'Carl Behrend');

/* Nothing Less */
INSERT INTO song VALUES (2,1,'Joyfully Lord',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,2,'Open My Heart',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,3,'Nothing Less',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,4,'Where You Want Me to Go',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,5,'Do You Love Me',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,6,'In the Light of the Cross',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,7,'Yeshua, Messiah',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,8,'Into the River',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,9,'Worthy to be Praised',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,10,'Michael Stand Up',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,11,'What You Saw',NULL,'Rondi Olson');
INSERT INTO song VALUES (2,12,'Listen',NULL,'Rondi Olson');

/* More Legends of the Great Lakes */
INSERT INTO song VALUES (3,1,'Dan Seavy the Great Lakes Pirate',296,'Carl Behrend');
INSERT INTO song VALUES (3,2,'The Captain and the Lady',313,'Carl Behrend');
INSERT INTO song VALUES (3,3,'Wreck of the Mary Ellen Carter',301,'Carl Behrend');
INSERT INTO song VALUES (3,4,'Three Sheets to the Wind',285,'Carl Behrend');
INSERT INTO song VALUES (3,5,'Face on the Rock',285,'Carl Behrend');
INSERT INTO song VALUES (3,6,'On the Boat Again',186,'Carl Behrend');
INSERT INTO song VALUES (3,7,'Great Lakes Fisherman',259,'Carl Behrend');
INSERT INTO song VALUES (3,8,'Wreck of the Edmund Fitzgerald',305,'Carl Behrend');
INSERT INTO song VALUES (3,9,'Lady Sing Your Songs Tonight',269,'Carl Behrend');
INSERT INTO song VALUES (3,10,'Grandma''s Feather Bed',189,'Carl Behrend');

COMMIT;

CREATE TABLE "CD Table" (
    "CD ID",
    "CD Title",
    "Price",
    CONSTRAINT cd2_pk
        PRIMARY KEY ("CD ID"),
    CONSTRAINT cd2_unique
        UNIQUE ("CD Title"))
AS SELECT * FROM CD;



/*****************************************
 Pivot Table
*****************************************/
DROP TABLE pivot;

CREATE TABLE pivot (
   x NUMBER
   );

INSERT INTO PIVOT
SELECT huns.x+tens.x+ones.x FROM
  (SELECT 0 x FROM dual
   UNION SELECT 1 FROM dual
   UNION SELECT 2 FROM dual
   UNION SELECT 3 FROM dual
   UNION SELECT 4 FROM dual
   UNION SELECT 5 FROM dual
   UNION SELECT 6 FROM dual
   UNION SELECT 7 FROM dual
   UNION SELECT 8 FROM dual
   UNION SELECT 9 FROM dual) ones,
  (SELECT 0 x FROM dual
   UNION SELECT 10 FROM dual
   UNION SELECT 20 FROM dual
   UNION SELECT 30 FROM dual
   UNION SELECT 40 FROM dual
   UNION SELECT 50 FROM dual
   UNION SELECT 60 FROM dual
   UNION SELECT 70 FROM dual
   UNION SELECT 80 FROM dual
   UNION SELECT 90 FROM dual) tens,
  (SELECT 0 x FROM dual
   UNION SELECT 100 FROM dual
   UNION SELECT 200 FROM dual
   UNION SELECT 300 FROM dual
   UNION SELECT 400 FROM dual
   UNION SELECT 500 FROM dual
   UNION SELECT 600 FROM dual
   UNION SELECT 700 FROM dual
   UNION SELECT 800 FROM dual
   UNION SELECT 900 FROM dual) huns;

COMMIT;

/*****************************************
Exposure tables
*****************************************/
DROP TABLE worker_location;
DROP TABLE building_exposure;

CREATE TABLE worker_location (
   worker_id NUMBER,
   building_number NUMBER,
   begin_date DATE,
   end_date DATE);

CREATE TABLE building_exposure (
   building_number NUMBER,
   chemical VARCHAR2(20),
   begin_date DATE,
   end_date DATE);

INSERT INTO worker_location VALUES (1,1,'15-Nov-2000','1-Jan-2002');
INSERT INTO worker_location VALUES (1,2,'2-Jan-2002',NULL);
INSERT INTO worker_location VALUES (2,1,'26-Dec-1995','4-Jul-1997');
INSERT INTO worker_location VALUES (2,2,'1-Jul-1997','31-Dec-2001');
INSERT INTO worker_location VALUES (2,3,'31-Dec-2001',NULL);

--The chemical names below come from the Online NIOSH
--Pocket Guide to Chemical Hazards. I just picked them
--at random from a list found at:
--
--    http://www.cdc.gov/niosh/npg/npgd0000.html

INSERT INTO building_exposure
   VALUES (1,'Acetaldehyde','1-Nov-1999','1-Mar-2001');
INSERT INTO building_exposure
   VALUES (1,'Unslaked lime','1-Dec-2000',NULL);
INSERT INTO building_exposure
   VALUES (1,'Tetrachloroethylene','1-Jan-2001','31-Dec-2001');
INSERT INTO building_exposure
   VALUES (1,'Prussic acid','1-Jan-1995','1-Jan-1997');

INSERT INTO building_exposure
   VALUES (2,'Osmium oxide','2-Feb-1996','13-Aug-1997');
INSERT INTO building_exposure
   VALUES (2,'Methyl iodide','27-Apr-1998','2-Jan-2002');
INSERT INTO building_exposure
   VALUES (2,'Slag wool','30-Sep-2000','31-Oct-2000');
INSERT INTO building_exposure
   VALUES (2,'Cement','1-Jan-2002',NULL);

INSERT INTO building_exposure
   VALUES (3,'Heptane','1-Jan-2002',NULL);
INSERT INTO building_exposure
   VALUES (3,'Tin powder','1-Oct-2001','31-Dec-2001');

COMMIT;

/*****************************************
Hierarchical bill-of-material tables
*****************************************/
DROP TABLE part;
DROP TABLE bill_of_materials;

CREATE TABLE part (
	part_number		  NUMBER,
	part_name         VARCHAR2(23),
	manufactured_by   VARCHAR2(30),
	current_inventory NUMBER);

/* Automobile parts */
INSERT INTO part VALUES (1001,'Piston','Munising Tool & Die',500);
INSERT INTO part VALUES (1002,'Air Filter','Germfask Filter Company', 200);
INSERT INTO part VALUES (1003,'Spark Plug','Pyro Plugs, Inc.',2000);
INSERT INTO part VALUES (1004,'Engine Block','Munising Tool & Die',100);
INSERT INTO part VALUES (1005,'Alternator','Pyro Plugs, Inc.',300);
INSERT INTO part VALUES (1006,'Two-year Battery','Low-flow Battery Corp.',250);
INSERT INTO part VALUES (1007,'Starter Motor','Pyro Plugs, Inc.',400);
INSERT INTO part VALUES (1008,'Sedan Roof','Shingleton Stamping',700);
INSERT INTO part VALUES (1017,'Left Door Frame','Shingleton Stamping',250);
INSERT INTO part VALUES (1018,'Left Window','Shards & Splinters Glass Fab',250);
INSERT INTO part VALUES (1019,'Car Door Lock','Grand Marais Motors',250);
INSERT INTO part VALUES (1020,'Right Door Frame','Shingleton Stamping',250);
INSERT INTO part VALUES (1021,'Right Window','Shards & Splinters Glass Fab',650);

/* Airplane parts */
INSERT INTO part VALUES (2001,'Full-width Cushion','Seney Seats',333);
INSERT INTO part VALUES (2002,'Cupholder Armrest','Seney Seats',444);
INSERT INTO part VALUES (2003,'Reclining Ergo-Seatback','Seney Seats',374);
INSERT INTO part VALUES (2004,'Extra-narrow Cushion','Seney Seats',432);
INSERT INTO part VALUES (2005,'Broken Armrest','Seney Seats',521);
INSERT INTO part VALUES (2006,'Hard, rigid Seatback','Seney Seats',978);

COMMIT;

CREATE TABLE bill_of_materials (
	assembly_id     NUMBER,
	assembly_name   VARCHAR2(23),
	parent_assembly NUMBER,
	part_number	    NUMBER,
	quantity        NUMBER);

/* Automobile */
INSERT INTO bill_of_materials VALUES (100,'Automobile',NULL,NULL,NULL);
INSERT INTO bill_of_materials VALUES (110,'Combustion Engine',100,NULL,1);
INSERT INTO bill_of_materials VALUES (120,'Body',100,NULL,1);
INSERT INTO bill_of_materials VALUES (130,'Interior',100,NULL,1);

/* Automobile/Combustion Engine */
INSERT INTO bill_of_materials VALUES (111,'Piston',110,1001,6);
INSERT INTO bill_of_materials VALUES (112,'Air Filter',110,1002,1);
INSERT INTO bill_of_materials VALUES (113,'Spark Plug',110,1003,6);
INSERT INTO bill_of_materials VALUES (114,'Block',110,1004,1);
INSERT INTO bill_of_materials VALUES (115,'Starter System',110,NULL,1);

/* Automobile/Compustion Engine/Starter System */
INSERT INTO bill_of_materials VALUES (116,'Alternator',115,1005,1);
INSERT INTO bill_of_materials VALUES (117,'Battery',115,1006,1);
INSERT INTO bill_of_materials VALUES (118,'Starter Motor',115,1007,1);

/* Automobile/Body */
INSERT INTO bill_of_materials VALUES (121,'Roof',120,1008,1);
INSERT INTO bill_of_materials VALUES (122,'Left Door',120,NULL,2);
INSERT INTO bill_of_materials VALUES (123,'Right Door',120,NULL,2);

/* Automobile/Body/Left Door */
INSERT INTO bill_of_materials VALUES (139,'Left Door Frame',122,1017,1);
INSERT INTO bill_of_materials VALUES (140,'Left Window',122,1018,1);
INSERT INTO bill_of_materials VALUES (141,'Lock',122,1019,1);

/* Automobile/Body/Right Door */
INSERT INTO bill_of_materials VALUES (142,'Right Door Frame',123,1020,1);
INSERT INTO bill_of_materials VALUES (143,'Right Window',123,1021,1);
INSERT INTO bill_of_materials VALUES (144,'Lock',123,1019,1);

/* Automobile/Interior */
INSERT INTO bill_of_materials VALUES (131,'Front Seat',130,NULL,2);
INSERT INTO bill_of_materials VALUES (132,'Back Seat',130,NULL,1);
INSERT INTO bill_of_materials VALUES (133,'Carpet',130,1011,1);

/* Automobile/Interor/Front Seat */
INSERT INTO bill_of_materials VALUES (134,'Seat Cushion',131,1012,1);
INSERT INTO bill_of_materials VALUES (135,'Seat Back',131,1013,1);
INSERT INTO bill_of_materials VALUES (136,'Headrest',131,1014,1);

/* Automobile/Interor/Back Seat */
INSERT INTO bill_of_materials VALUES (137,'Seat Cushion',132,1015,1);
INSERT INTO bill_of_materials VALUES (138,'Seat Back',132,1016,1);

/* Airplane */
INSERT INTO bill_of_materials VALUES (200,'Airplane',NULL,NULL,NULL);
INSERT INTO bill_of_materials VALUES (201,'Jet Engine',200,NULL,2);
INSERT INTO bill_of_materials VALUES (202,'Left Wing',200,NULL,1);
INSERT INTO bill_of_materials VALUES (203,'Right Wing',200,NULL,1);
INSERT INTO bill_of_materials VALUES (204,'Body',200,NULL,1);

/* Airplane/Body */
INSERT INTO bill_of_materials VALUES (205,'First-class Seat',204,NULL,12);
INSERT INTO bill_of_materials VALUES (206,'Coach Seat',204,NULL,300);

/* Airplane/Body/First-class Seat */
INSERT INTO bill_of_materials VALUES (207,'Full-width Cushion',205,2001,1);
INSERT INTO bill_of_materials VALUES (208,'Cupholder Armrest',205,2002,2);
INSERT INTO bill_of_materials VALUES (209,'Reclining Ergo-Seatback',205, 2003,1);

/* Airplane/Body/First-class Seat */
INSERT INTO bill_of_materials VALUES (210,'Extra-narrow Cushion',206,2004,1);
INSERT INTO bill_of_materials VALUES (211,'Broken Armrest',206,2005,1);
INSERT INTO bill_of_materials VALUES (212,'Hard, rigid Seatback',206, 2006,1);

COMMIT;

--Force user to reconnect, because this script has
--altered two session settings: NLS_DATE_FORMAT and
--NLS_DATE_LANGUAGE.
DISCONNECT;

SPOOL OFF
SET ECHO OFF
SET DEFINE ON
