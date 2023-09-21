DROP PROCEDURE IF EXISTS AGS_BOOK_HIST_BY_ID;
DELIMITER //  
CREATE PROCEDURE AGS_BOOK_HIST_BY_ID(IN custid bigint)
BEGIN    

select r.cust_id,b.book_name,r.borrow_date,r.actual_ret_dt, inv.invoice_amount,
IFNULL(SUM(P.payment_amount),0) AS amount_paid,
inv.invoice_amount - IFNULL(SUM(P.payment_amount),0) AS balance
from ags_rental r
left join ags_inventory i on r.copy_id = i.copy_id
left join ags_books b on i.book_id = b.book_id
inner join ags_invoice inv on inv.rental_id = r.rental_id 
left join ags_payment p on inv.invoice_no = p.invoice_no
where r.rental_status <> 'B'
AND r.cust_id = custid
group by r.rental_id
order by actual_ret_dt desc,borrow_date desc;

END //  
DELIMITER ;

-- call AGS_BOOK_HIST_BY_ID(111)