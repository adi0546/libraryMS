select count(1) from ags_topics;

select count(1) from ags_customer;

select count(1) from ags_room;

select count(1) from ags_event;

/*Since seminar and exhibition are subtypes, they have less initial/standing data than.*/
select count(1) from ags_seminar;

select count(1) from ags_exhibition;

select count(1) from ags_cust_exh;

select count(1) from ags_sponsor;

select count(1) from ags_author;

select count(1) from ags_books;

select count(1) from ags_bks_aut;

select count(1) from ags_rental;

select count(1) from ags_bks_tpc;

select count(1) from ags_sem_spn;

SELECT count(1) from ags_inventory;

select count(1) from ags_invoice;

select count(1) from ags_payment;

select count(1) from ags_reservation;