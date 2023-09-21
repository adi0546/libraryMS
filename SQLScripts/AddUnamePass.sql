select * from ags_customer;

delete from ags_customer where cust_id = 115;

ALTER TABLE ags_customer
ADD password nvarchar(70);

update ags_customer
set password = sha2('default',256)
where cust_id between 100 and 114;

ALTER TABLE ags_customer
ADD username nvarchar(30);

update ags_customer
set username = email
where cust_id between 100 and 114;

ALTER TABLE ags_customer
ADD username nvarchar(30);

ALTER TABLE ags_customer
ADD CONSTRAINT UC_customer_uName UNIQUE (username);





