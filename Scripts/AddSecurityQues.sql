CREATE TABLE ags_questions (
  quesId INT PRIMARY KEY AUTO_INCREMENT,
  questions VARCHAR(100)
);

INSERT INTO ags_questions (questions) VALUES
  ("What is your mother's maiden name?"),
  ("In what city were you born?"),
  ("What is your favorite color?"),
  ("What is the name of your first pet?"),
  ("What is the name of your favorite teacher?"),
  ("What is your favorite sports team?"),
  ("What is your favorite movie?"),
  ("What is your favorite book?"),
  ("What is your favorite food?"),
  ("What is your favorite vacation spot?");



CREATE TABLE ags_ques_cust (
  cust_id INT,
  ques_id INT,
  answer varchar(100) not null,
  primary key (cust_id,ques_id)
);

insert into ags_ques_cust 
values
(100,2,'New Jersey'),
(100,3,'Blue'),
(100,10,'Bali'),
(101,2,'New Jersey'),
(101,3,'Blue'),
(101,10,'Bali'),
(102,2,'New Jersey'),
(102,3,'Blue'),
(102,10,'Bali'),
(103,2,'New Jersey'),
(103,3,'Blue'),
(103,10,'Bali'),
(104,2,'New Jersey'),
(104,3,'Blue'),
(104,10,'Bali'),
(105,2,'New Jersey'),
(105,3,'Blue'),
(105,10,'Bali'),
(106,2,'New Jersey'),
(106,3,'Blue'),
(106,10,'Bali'),
(107,2,'New Jersey'),
(107,3,'Blue'),
(107,10,'Bali'),
(108,2,'New Jersey'),
(108,3,'Blue'),
(108,10,'Bali'),
(109,2,'New Jersey'),
(109,3,'Blue'),
(109,10,'Bali'),
(110,2,'New Jersey'),
(110,3,'Blue'),
(110,10,'Bali'),
(111,2,'New Jersey'),
(111,3,'Blue'),
(111,10,'Bali'),
(112,2,'New Jersey'),
(112,3,'Blue'),
(112,10,'Bali'),
(113,2,'New Jersey'),
(113,3,'Blue'),
(113,10,'Bali'),
(114,2,'New Jersey'),
(114,3,'Blue'),
(114,10,'Bali')