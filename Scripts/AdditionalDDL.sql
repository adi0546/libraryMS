/*MANUALLY ADDED CONSTRAINTS*/
ALTER TABLE AGS_CUSTOMER
ADD CONSTRAINT CHK_cust_id_psd CHECK (id_type = 'P' OR id_type = 'S' OR id_type = 'D');

ALTER TABLE ags_rental
ADD CONSTRAINT CHK_rental_status_BRL CHECK (rental_status = 'B' OR rental_status = 'R' OR rental_status = 'L');

ALTER TABLE ags_inventory ADD CONSTRAINT CHK_STATUS_AU CHECK (status = 'A' OR status = 'U');

ALTER TABLE ags_reservation
ADD CONSTRAINT CHK_TIME_SLOT_1234 CHECK (time_slot = '1' OR time_slot = '2' OR time_slot = '3' OR time_slot = '4');


/*TRIGGER TO GENERATE INVOICE*/
DROP TRIGGER IF EXISTS trigger_ags_rental_upd;

DELIMITER //

CREATE TRIGGER trigger_ags_rental_upd BEFORE UPDATE ON ags_rental
    FOR EACH ROW
    
BEGIN
	DECLARE d DATETIME;
    SELECT
        r.actual_ret_dt
    INTO d
    FROM
        ags_rental r
    WHERE
        r.rental_id = new.rental_id;

    IF (new.actual_ret_dt IS NOT NULL) THEN
    BEGIN
    set @actDate = new.actual_ret_dt;
    set @brwDate = (SELECT borrow_date FROM ags_rental where rental_id = new.rental_id);
    set @expDate = (SELECT DATE_ADD(@brwDate, INTERVAL 1 MONTH));
    set @dateDiff = (SELECT DATEDIFF(@expDate,@actDate));
    IF @dateDiff < 0 THEN 
    BEGIN
    SET @amt = (SELECT ((DATEDIFF(@expDate,@brwDate)*0.2) + (DATEDIFF(@actDate,@expDate)*0.4)));
    SET @status = 'L';
    END;
    ELSE
    BEGIN
    SET @amt = (SELECT DATEDIFF(@expDate,@brwDate)*0.2);
    SET @status = 'R';
    END;
    END IF;
    
    SET @lastInv = (SELECT MAX(INVOICE_NO) FROM ags_invoice);
    INSERT INTO ags_invoice(invoice_no,invoice_date, invoice_amount,rental_id) VALUES
    (IFNULL(@lastInv,0) + 1, NOW(), @amt, new.rental_id);

    SET new.rental_status = @status;
    
    END;
    END IF;
    
END;
//
DELIMITER ;

ALTER TABLE `ags_invoice` CHANGE `invoice_amount` `invoice_amount` DECIMAL(6,2) NOT NULL COMMENT 'INVOICE AMOUNT';