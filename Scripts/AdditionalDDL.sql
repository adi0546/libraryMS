--MANUALLY ADDED CONSTRAINTS
ALTER TABLE AGS_CUSTOMER
ADD CONSTRAINT CHK_cust_id_psd CHECK (cust_id = 'P' OR cust_id = 'S' OR cust_id = 'D');

ALTER TABLE ags_rental
ADD CONSTRAINT CHK_rental_status_BRL CHECK (rental_status = 'B' OR rental_status = 'R' OR rental_status = 'L');

ALTER TABLE ags_inventory ADD CONSTRAINT CHK_STATUS_AU CHECK (status = 'A' OR status = 'U');

ALTER TABLE ags_reservation
ADD CONSTRAINT CHK_TIME_SLOT_1234 CHECK (time_slot = '1' OR time_slot = '2' OR time_slot = '3' OR time_slot = '4');