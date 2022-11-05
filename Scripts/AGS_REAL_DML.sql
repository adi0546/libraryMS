--Insert initial standing data into Topic table
INSERT INTO ags_topics (topic_id, topic_name) VALUES 
('1', 'History'),
('2', 'Children'),
('3', 'Science'),
('4', 'Arts'),
('5', 'Travel'),
('6', 'Adventures'),
('7', 'Drama'),
('8', 'Thriller'),
('9', 'Science Fiction'),
('10', 'Comedy'),
('11', 'Romance'),
('12', 'Crime'),
('13', 'Suspense'),
('14', 'Documentaries'),
('15', 'Food');

/*Customer table insert data*/
INSERT INTO ags_customer (cust_id, fname, midname, lname, phoneno, email, id_type, id_num) VALUES 
('100', 'Rohan','Pratap','Singh',3450000111,'rp11@gmail.com','P','R34232113'),
('101', 'Jack','Barrtet','Jackson',9872224455,'jack_b@gmail.com','D','J432123654567'),
('102', 'Allen','Marrie','Angel',3472225555,'amarrie24@gmail.com','S','123546523'),
('103', 'Barnard','Shay','Lane',9936666221,'bsl1998@gmail.com','D','B654123653875' ),
('104', 'Bell','Ann','Lillian',3845557799,'annbell57@gmail.com','S','432541234'),
('106', 'David','Jeanne', 'Dylan',9328886547,'dd1988@gmail.com','S','543126542'),
('107', 'Disha','Ravi','Singh',3946854321,'dishasingh21@gmail.com','D','D875234454234'),
('108', 'Fuller','Ruth', 'Diego',3776854674,'full16d@gmail.com','D','F567324321657'),
('109', 'Gibson','Faith','Ross',9655567970,'gib20son@gmail.com','P','G45236521'),
('110', 'Hady','Elizabeth','Ruby',3120867464,'elii30@gmail.com','S','565235176'),
('111', 'Kate','Lillie','Colton',9334441124,'kate1986@gmail.com','S','653126895'),
('112', 'Lawrence','Scott','Joseph',9865554422,'lj15@gmail.com','P','L43123531'),
('114', 'Olive','Rae','Nico',3461154002,'olive21@gmail.com','P','O98321412');

INSERT INTO ags_customer (cust_id, fname, lname, phoneno, email, id_type, id_num) VALUES
('113', 'Mark','Arthur',3485552221,'mark18arthur@gmail.com','D','M234454764342'),
('105', 'Claudia','Isabel',3487775566,'isa18@gmail.com','D','C536324875234');


/*insert data in room table*/
INSERT INTO ags_room(room_id, room_name,capacity) VALUES
('1000','FF0','80'),
('1001','FF1','25'),
('1002','FF2','25'),
('1003','FF3','40'),
('1004','FF4','10'),
('2001','SF1','20'),
('2002','SF2','20'),
('2003','SF3','30'),
('2004','SF4','30'),
('3001','TF1','50'),
('3002','TF2','40'),
('3003','TF3','40'),
('3004','TF4','35'),
('3005','TF5','35'),
('3006','TF6','20'),
('3007','TF7','10');



/*insert data in EVENT table*/
INSERT INTO ags_event (event_id, e_name, description, start_date, end_date, event_type, topic_id) VALUES 
('1', 'Eating Healthy', 'Benefits of eating healthy.', '2022-11-16 11:47:16', '2022-11-17 11:47:16', 'S', '15'),
('2', 'Independence of USA', 'Discussion about the Independence of the USA', '2022-12-11 11:47:16', '2022-12-17 11:47:16', 'S', '1'),
('3', 'Play With Robots', 'Come visit and see top Robots built by top of the line Engineers', '2022-11-01 11:47:16', '2022-11-01 20:00:16', 'E', '3'),
('4', 'Hikathon', 'Hike various trails within USA and Canada', '2022-12-01 12:00:00', '2022-12-01 01:00:00', 'S', '5'),
('5', 'Art Attack', 'Various Artists put up their work on Display', '2022-11-16', '2022-11-17', 'E', '4'),
('6', 'Live Love Laugh', 'Open Mic where varrious comics perform.', '2022-12-16 17:00:00', '2022-11-16 19:00:00', 'S', '10'),
('7', 'Learn Python', 'Learn to use PYTHON', '2022-11-20 11:47:16', '2022-11-20 13:45:00', 'S', '3'),
('8', 'DBMS Basics', 'Learn the basics of DBMS', '2022-11-21 11:47:16', '2022-11-21 13:45:00', 'S', '3'),
('9', 'Food Fest', 'Come taste food from different parts of the country', '2022-12-20 11:00:00', '2022-12-21 20:00:00', 'E', '15'),
('10', 'Movie Screening', 'Watch AVATAR 2 coming Saturday', '2022-11-22 18:00:00', '2022-11-22 21:00:00', 'E', '9'),
('11', 'Advanced Python', 'Learn Advanced Python with us', '2022-11-16 11:00:00', '2022-11-16 12:30:00', 'S', '3'),
('12', 'Coding Bootcamp', 'Learn to code for interview assessments.', '2022-12-01 11:00:00', '2023-02-25 12:30:00', 'S', '3'),
('13', 'Handicraft Expo', 'Various artists put up their handicrafts for sale.', '2022-11-02 16:00:00', '2022-11-02 18:00:00', 'E', '4')
;

/*Subtype Data Insertion Start*/
INSERT INTO ags_seminar (event_id, invitation_code) VALUES 
('1', 'CODEEH1'),
('2', 'CODEINDIP1'),
('4', 'CODEHIKA1'),
('6', 'CODELLL01'),
('7', 'CODEPYTHON01'),
('8', 'CODEDBMS01'),
('11', 'CODEPYTH02'),
('12', 'CODECOMPCODING01');

INSERT INTO ags_exhibition (event_id, expenses) VALUES 
('3', '7000'),
('5', '15000'),
('9', '5000'),
('10', '4500.5'),
('13', '3000.5');
/*Subtype Data Insertion END*/

INSERT INTO ags_cust_exh (registration_id, registration_date, cust_id, event_id) VALUES 
('10001', '2022-11-02 12:00:00', '101', '9'),
('10002', '2022-10-01 13:00:00', '107', '13'),
('10003', '2022-11-02 04:00:00', '112', '10'),
('10004', '2022-11-02 15:30:00', '104', '5'),
('10005', '2022-11-02 15:45:00', '109', '9'),
('10006', '2022-11-02 17:23:00', '105', '9'),
('10007', '2022-11-02 09:24:00', '102', '13'),
('10008', '2022-11-02 21:00:00', '100', '10'),
('10009', '2022-11-02 22:34:00', '102', '10'),
('100010', '2022-11-02 18:00:00', '112', '5'),
('100011', '2022-11-02 17:43:00', '114', '13'),
('100012', '2022-11-02 12:23:00', '113', '9'),
('100013', '2022-11-02 14:14:00', '111', '3'),
('100014', '2022-11-02 15:52:00', '110', '9'),
('100015', '2022-11-02 11:12:00', '101', '3'),
('100016', '2022-11-02 19:11:00', '100', '9');


/*Insert into sponsor start*/
INSERT INTO ags_sponsor (sponsor_id, fname, phoneno, email) VALUES 
('10000','Techno_Corp',3359553223,'tc@technocorp.inc'),
('10004','AB_Group',9541943813,'ab1@abgroup.inc'),
('10008','Techboom',9925435153,'tb12@techboom.inc'),
('10011','Renault',9321475321,'ab12@renault.inc'),
('10012','Mongo',9231513453,'dbs@mongo.inc'),
('10013','BOFA',9152346431,'ad9@bofa.inc');

INSERT INTO ags_sponsor (sponsor_id, fname,lname, phoneno, email) VALUES 
('10001','Matthew','Wade',3856553224,'mwade@gmail.com'),
('10002','Lina','Marie',3439663217,'linam28@gmail.com'),
('10003','Adi','Chan',3985955324,'chanadi2@gmail.com'),
('10005','Gaurang','Sen',3652413535,'gaursen12@gamil.com'),
('10006','Yash','Chauhan',3234562371,'yashc1995@gmail.com'),
('10007','Mark', 'Colton',3098541431,'coltonmark23@gmail.com'),
('10009','Sam','Billings',3654113571,'samb32@gmail.com'),
('10010','Olivia','Shaw',3863511544,'shawoli11@gmail.com'),
('10014','Lauren','Ruth',3542246114,'ruthlauren32@gmail.com');
/*Insert into sponsor end*/

/*Insert into sponsor-event intersect table*/
INSERT INTO ags_sem_spn (event_id, sponsor_id, sponsor_amount) VALUES 
('2', '10002', '1000'),
('8', '10012', '1000'),
('7', '10004', '1000'),
('1', '10008', '1000'),
('2', '10001', '1000'),
('11', '10013', '1000'),
('4', '10012', '1000'),
('2', '10014', '1000'),
('12', '10001', '1000'),
('6', '10002', '1000'),
('8', '10010', '1000'),
('2', '10011', '1000'),
('1', '10002', '1000');


--Insert initial standing data into Author table
INSERT INTO ags_author
	(author_id,fname,lname,email,street_addr1,street_addr2,city,state,zipcode)
VALUES
	(1,'STEPHEN','KING','stephenking@gmail.com','71 ST. NICHOLAS DRIVE','','NORTH POLE','ALASKA','99705'),
    (2,'STAN','LEE','stanlee@yahoo.com','2200 HWY 98 STE 5','','DAPHNE','ALABAMA','36526'),
    (3,'J.K.','ROWLING','jkrowling@gmail','2528 W 28TH ST','','PINE BLUFF','ARKANSAS','71603'),
    (4,'JOHN','GRISHAM','johngrisham@yahoo.com','9565 E 22ND ST','SUITE 115','TUCSON','ARIZONA','85748'),
    (5,'R.L.','STINE','rlstine@gmail.com','16232 FOOTHILL BLVD','','UPLAND','CALIFORNIA','91768'),
    (6,'JAMES','PATTERSON','jamespatterson@yahoo.com','850 HARTFORD TNPK','CRYSTAL MALL','WATERFORD','CINCINNATI','06385'),
    (7,'ANNE','RICE','annerice@gmail.com','1630 CONNECTICUT AVE','','WASHINGTON','DC','20009'),
    (8,'DEAN','KOONTZ','deankoontz@yahoo.com','3601 CONCORD PIKE','','WILMNINGTON','DELAWARE','19702'),
    (9,'DANIELLE','STEEL','daniellesteel@gmail.com','1110 AIRPORT BOULEVARD','','PENSACOLA','FLORIDA','32504'),
    (10,'MARY','CLARK','maryclark@yahoo.com','4375 LEXINGTON RD','SUITE C-4','ATHENS','GEORGIA','30605'),
    (11,'GEORGE','MARTIN','georgemartin@gmail.com','95-1249 MEHEULA PKWY','STE D-13','MILILANI','HAWAII','96789'),
    (12,'NORA','ROBERTS','noraroberts@yahoo.com','4100 UNIVERSITY AVE','SUITE 114','WEST DES MOINES','ITHACA','50266'),
    (13,'TONI','MORRISON','tonimorrison@gmail.com','2000 W PULLMAN RD','','MOSCOW','IDAHO','83843'),
    (14,'CLIVE','BARKER','clivebarker@yahoo.com','729 W MAIN ST','','WEST DUNDEE','ILLINOIS','60118'),
    (15,'MARGARET','ATWOOD','margaretatwood@gmail.com','160 MONTAGUE STREET','','BROOKLYN','NEW YORK','11201'),
    (16,'DOUGLAS','PRESTON','douglaspreston@yahoo.com','7911 MALL RD','','FLORENCE','KENTUCKY','41042'),
	(17,'LINCOLN','CHILD','lincolnchild@gmail.com','4801 OUTER LOOP','','LOUISVILLE','KENTUCKY','40219'),
    (18,'CHRIS','GRABENSTEIN','chrisgrabenstein@yahoo.com','61103 AIRPORT RD','','SLIDELL','LOS ANGELES','70460');

--Insert initial standing data into Books table
INSERT INTO ags_books
(book_id,book_name,publish_date)
VALUES
(1,'THE STAND','1978-10-03'),
(2,'THE DEAD ZONE','1979-08-30'),
(3,'BALANCE OF POWER','2017-03-07'),
(4,'THE ICKABOG','2020-11-10'),
(5,'TROUBLED BLOOD','2020-09-15'),
(6,'THE ULTIMATE SPIDER MAN','2011-06-06'),
(7,'A TIME TO KILL','1989-05-09'),
(8,'THE FIRM','1991-02-01'),
(9,'THE WRONG NUMBER','1990-09-08'),
(10,'I FUNNY','2012-08-03'),
(11,'THE HOUSE OF KENNEDY','2020-04-13'),
(12,'A GAME OF THRONES','1996-02-01'),
(13,'THE TESTAMENTS','2019-09-10'),
(14,'LEGACY','2021-05-25'),
(15,'VISION IN WHITE','2009-04-28'),
(16,'RELIC','1996-01-15');

--Insert initial standing data into books and author intercept table
INSERT INTO	ags_bks_aut
(book_id,author_id)
VALUES
(4,2),
(5,2),
(14,14),
(9,5),
(11,6),
(10,6),
(10,18),
(4,3),
(16,16),
(16,17);

--Insert initial standing data into books and topic intercept table
INSERT INTO	ags_bks_tpc
(book_id,topic_id)
VALUES
(3,8),
(3,13),
(5,8),
(5,12),
(6,9),
(9,2),
(9,8),
(9,13),
(15,11),
(16,8),
(16,9);


INSERT INTO ags_inventory (copy_id, status, book_id) VALUES 
('101', 'A', '1'),
('102', 'A', '1'),
('103', 'U', '1'),
('104', 'A', '12'),
('105', 'A', '11'),
('106', 'U', '13'),
('107', 'A', '14'),
('108', 'A', '16'),
('109', 'U', '3'),
('110', 'A', '4'),
('111', 'U', '5'),
('112', 'A', '1'),
('113', 'A', '8'),
('114', 'U', '9'),
('115', 'A', '11'),
('116', 'A', '15'),
('117', 'U', '10'),
('118', 'A', '12');


/*RENTAL WILL ONLY INSERT VALUES WITH NO ACTUAL_RET DATE. ACTUAL RET DATE WILL BE ONLY POPUILATED IN UPDATES*/
INSERT INTO ags_rental (rental_id, rental_status, borrow_date, actual_ret_dt, copy_id, cust_id) VALUES 
('101', 'B', '2022-11-01 13:12:00', NULL, '115', '102'),
('102', 'B', '2022-12-01 13:12:00', NULL, '108', '108'),
('103', 'B', '2022-01-23 15:12:00', NULL, '104', '111'),
('104', 'B', '2022-02-01 13:12:00', NULL, '101', '101'),
('105', 'B', '2022-03-21 23:12:00', NULL, '114', '102'),
('106', 'B', '2022-04-01 13:12:00', NULL, '111', '111'),
('107', 'B', '2022-05-11 13:12:00', NULL, '112', '102'),
('108', 'B', '2022-11-01 13:12:00', NULL, '101', '103'),
('109', 'B', '2022-11-01 11:12:00', NULL, '115', '106'),
('110', 'B', '2022-10-23 13:12:00', NULL, '103', '109'),
('111', 'B', '2022-11-01 10:12:00', NULL, '109', '111'),
('112', 'B', '2022-03-13 13:12:00', NULL, '114', '107'),
('113', 'B', '2022-10-01 09:12:00', NULL, '109', '113'),
('114', 'B', '2022-08-01 13:12:00', NULL, '109', '107'),
('115', 'B', '2022-11-11 13:12:00', NULL, '114', '111'),
('116', 'B', '2022-09-01 15:12:00', NULL, '104', '101'),
('117', 'B', '2022-11-17 13:12:00', NULL, '109', '107'),
('118', 'B', '2022-01-01 20:12:00', NULL, '114', '106'),
('119', 'B', '2022-04-18 21:12:00', NULL, '111', '110'),
('120', 'B', '2022-05-13 22:12:00', NULL, '112', '104');


/*UPDATES IN RENTAL TABLE ACTUAL_RET_DATE WILL TRIGGER INSERT VALUES IN INVOICE TABLE
SO, INSTEAD OF INSERTING IN INVOICE, WRITING MODIFY QUERY ON RENTAL TABLE*/
UPDATE ags_rental
SET actual_ret_dt = '2022-12-03 13:12:00'
WHERE rental_id in (101,102,103,104,105,106,107,108,109,110,111,112)

INSERT INTO ags_payment (payment_id, payment_method, payment_amount, payment_name, invoice_no) VALUES
 ('1001', 'Cash', '6.80', 'Adi', '1'),
 ('1002', 'Credit Card', '6.20', 'Allen''s credit card', '2'),
 ('1003', 'Paypal', '59.4', 'Kate''s Paypal', '3'),
 ('1004', 'Cash', '30', 'Kate', '3'),
 ('1005', 'Credit Card', '30', 'Kate''s Credit Card', '3'),
 ('1006', 'Cash', '116.4', 'Jack', '4'),
 ('1007', 'Credit Card', '96.60', 'Allen''s credit card', '5'),
 ('1009', 'Paypal', '36.20', 'Barnard', '7'),
 ('1010', 'Credit Card', '30', 'Barnard ''s Credit Card', '7'),
 ('1011', 'Cash', '10', 'Barnard', '7');

 INSERT INTO ags_reservation (reservation_id, time_slot, cust_id, room_id, reservation_date) VALUES 
 ('1001', '1', '101', '2003','2022-11-05'),
 ('1002', '2', '103', '1004','2022-10-12'),
 ('1003', '3', '113', '1000','2022-10-13'),
 ('1004', '4', '104', '2003','2022-11-14'),
 ('1005', '2', '105', '3001','2022-09-16'),
 ('1006', '4', '111', '3002','2022-11-23'),
 ('1007', '2', '111', '3003','2022-07-25'),
 ('1008', '1', '114', '3005','2022-11-28'),
 ('1009', '1', '104', '2003','2022-12-05'),
 ('1010', '4', '103', '2001','2022-11-05'),
 ('1011', '4', '108', '2002','2022-11-05'),
 ('1012', '1', '107', '2003','2022-01-05'),
 ('1013', '2', '109', '3002','2022-11-06'),
 ('1014', '3', '110', '3005','2022-11-02');