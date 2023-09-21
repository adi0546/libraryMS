
DELIMITER $$

CREATE FUNCTION getTimeSlot(time_slot INT)
RETURNS VARCHAR(20)
BEGIN
  DECLARE timeSlot VARCHAR(20);
  CASE time_slot
    WHEN 1 THEN SET timeSlot = '8 AM - 10 AM';
    WHEN 2 THEN SET timeSlot = '11 AM - 1 PM';
    WHEN 3 THEN SET timeSlot = '1 PM - 3 PM';
    ELSE SET timeSlot = '4 PM - 6 PM';
  END CASE;
  RETURN timeSlot;
END$$

DELIMITER ;