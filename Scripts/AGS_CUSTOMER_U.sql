DROP PROCEDURE IF EXISTS AGS_CUSTOMER_U;
DELIMITER //  
CREATE PROCEDURE AGS_CUSTOMER_U(IN custid bigint, IN emailP varchar(30), IN fnameP varchar(30), IN idnum varchar(30), IN idtype char, IN lnameP varchar(30), IN midnameP varchar(30), IN phonenoP bigint)
BEGIN    
    update AGS_CUSTOMER set 
    email = ifnull(emailP, email),
    fname = ifnull(fnameP,fname), 
    id_num = ifnull(idnum, id_num),
    id_type = ifnull(idtype, id_type),
    lname = ifnull(lnameP, lname),
    midname = ifnull(midnameP,midname), 
    phoneno = ifnull(phonenoP, phoneno)
    where cust_id = custid ;
END //  
DELIMITER ;