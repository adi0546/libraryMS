-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2022-11-03 15:55:15 GMT-04:00
--   site:      Oracle Database 21c
--   type:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE ags_author (
    author_id    NUMBER(10) NOT NULL,
    fname        VARCHAR2(30) NOT NULL,
    lname        VARCHAR2(30) NOT NULL,
    email        NVARCHAR2(30) NOT NULL,
    street_addr1 NVARCHAR2(30) NOT NULL,
    street_addr2 NVARCHAR2(30),
    city         VARCHAR2(30) NOT NULL,
    state        VARCHAR2(30) NOT NULL,
    zipcode      NVARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN ags_author.author_id IS
    'UNIQUE AUTHOR ID';

COMMENT ON COLUMN ags_author.fname IS
    'AUTHOR FIRST NAME';

COMMENT ON COLUMN ags_author.lname IS
    'AUTHOR LAST NAME';

COMMENT ON COLUMN ags_author.email IS
    'AUTHOR EMAIL ID';

COMMENT ON COLUMN ags_author.street_addr1 IS
    'AUTHOR STREET ADDRESS1';

COMMENT ON COLUMN ags_author.street_addr2 IS
    'AUTHOR STREET ADDRESS2';

COMMENT ON COLUMN ags_author.city IS
    'AUTHOR CITY ADDRESS';

COMMENT ON COLUMN ags_author.state IS
    'AUTHOR STATE';

COMMENT ON COLUMN ags_author.zipcode IS
    'AUTHOR ZIPCODE ADDRESS';

ALTER TABLE ags_author ADD CONSTRAINT ags_author_pk PRIMARY KEY ( author_id );

CREATE TABLE ags_bks_aut (
    book_id   NUMBER(10) NOT NULL,
    author_id NUMBER(10) NOT NULL
);

ALTER TABLE ags_bks_aut ADD CONSTRAINT ags_bks_aut_pk PRIMARY KEY ( author_id,
                                                                    book_id );

CREATE TABLE ags_bks_tpc (
    book_id  NUMBER(10) NOT NULL,
    topic_id NUMBER(3) NOT NULL
);

ALTER TABLE ags_bks_tpc ADD CONSTRAINT ags_bks_tpc_pk PRIMARY KEY ( topic_id,
                                                                    book_id );

CREATE TABLE ags_books (
    book_id      NUMBER(10) NOT NULL,
    book_name    NVARCHAR2(30) NOT NULL,
    publish_date DATE NOT NULL
);

COMMENT ON COLUMN ags_books.book_id IS
    'UNIQUE BOOK ID';

COMMENT ON COLUMN ags_books.book_name IS
    'BOOK NAME';

COMMENT ON COLUMN ags_books.publish_date IS
    'BOOK PUBLISH DATE';

ALTER TABLE ags_books ADD CONSTRAINT ags_books_pk PRIMARY KEY ( book_id );

CREATE TABLE ags_cust_exh (
    registration_id   NUMBER(10) NOT NULL,
    registration_date DATE NOT NULL,
    cust_id           NUMBER(10) NOT NULL,
    event_id          NUMBER(10) NOT NULL
);

COMMENT ON COLUMN ags_cust_exh.registration_id IS
    'UNIQUE REGISTRATION ID FOR EACH CUSTOMER FOR EACH EXHIBITION';

COMMENT ON COLUMN ags_cust_exh.registration_date IS
    'REGISTRATION DATE';

ALTER TABLE ags_cust_exh ADD CONSTRAINT ags_cust_exh_pk PRIMARY KEY ( registration_id );

CREATE TABLE ags_customer (
    cust_id NUMBER(10) NOT NULL,
    fname   VARCHAR2(30) NOT NULL,
    midname VARCHAR2(30),
    lname   VARCHAR2(30) NOT NULL,
    phoneno NUMBER(10) NOT NULL,
    email   NVARCHAR2(30) NOT NULL,
    id_type CHAR(1) NOT NULL,
    id_num  NVARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN ags_customer.cust_id IS
    'UNIQUE CUSTOMER ID';

COMMENT ON COLUMN ags_customer.fname IS
    'CUSTOMER FIRST NAME';

COMMENT ON COLUMN ags_customer.midname IS
    'CUSTOMER MID NAME';

COMMENT ON COLUMN ags_customer.lname IS
    'CUSTOMER LAST NAME';

COMMENT ON COLUMN ags_customer.phoneno IS
    'CUSTOMER US PHONE NUMBER';

COMMENT ON COLUMN ags_customer.email IS
    'CUSTOMER EMAIL ID';

COMMENT ON COLUMN ags_customer.id_type IS
    'CUSTOMER ID TYPE IN ''P''(PASSPORT), ''S''(SSN) OR ''D''(DRIVING LICENSE)';

COMMENT ON COLUMN ags_customer.id_num IS
    'CUSTOMER ID NUMBER';

ALTER TABLE ags_customer ADD CONSTRAINT ags_customer_pk PRIMARY KEY ( cust_id );

CREATE TABLE ags_event (
    event_id    NUMBER(10) NOT NULL,
    e_name      VARCHAR2(20) NOT NULL,
    description NVARCHAR2(150),
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,
    event_type  CHAR(1) NOT NULL,
    topic_id    NUMBER(3) NOT NULL
);

ALTER TABLE ags_event
    ADD CONSTRAINT ch_inh_ags_event CHECK ( event_type IN ( 'E', 'S' ) );

COMMENT ON COLUMN ags_event.event_id IS
    'UNIQUE EVENT ID';

COMMENT ON COLUMN ags_event.e_name IS
    'EVENT NAME';

COMMENT ON COLUMN ags_event.description IS
    'EVENT DESCRIPTION';

COMMENT ON COLUMN ags_event.start_date IS
    'EVENT START DATE';

COMMENT ON COLUMN ags_event.end_date IS
    'EVENT END DATE';

COMMENT ON COLUMN ags_event.event_type IS
    'EVENT TYPE ''S''(SEMINAR) OR ''E''(EXHIBITION)';

ALTER TABLE ags_event ADD CONSTRAINT ags_event_pk PRIMARY KEY ( event_id );

CREATE TABLE ags_exhibition (
    event_id NUMBER(10) NOT NULL,
    expenses NUMBER(10, 2) NOT NULL
);

COMMENT ON COLUMN ags_exhibition.event_id IS
    'UNIQUE EVENT ID';

COMMENT ON COLUMN ags_exhibition.expenses IS
    'EXHIBITION EXPENSES IN USD';

ALTER TABLE ags_exhibition ADD CONSTRAINT ags_exhibition_pk PRIMARY KEY ( event_id );

CREATE TABLE ags_inventory (
    copy_id NUMBER(10) NOT NULL,
    status  CHAR(1) NOT NULL,
    book_id NUMBER(10) NOT NULL
);

COMMENT ON COLUMN ags_inventory.copy_id IS
    'UNIQUE COPY ID';

COMMENT ON COLUMN ags_inventory.status IS
    'COPY STATUS ''A''(AVAILABLE) OR ''U''(UNAVAILABLE)';

ALTER TABLE ags_inventory ADD CONSTRAINT ags_inventory_pk PRIMARY KEY ( copy_id );

CREATE TABLE ags_invoice (
    invoice_no   NUMBER(10) NOT NULL,
    invoice_date DATE NOT NULL,
    rental_id    NUMBER(10) NOT NULL
);

COMMENT ON COLUMN ags_invoice.invoice_no IS
    'UNIQUE INVOICE NUMBER';

COMMENT ON COLUMN ags_invoice.invoice_date IS
    'INVOICE GENERATION DATE';

CREATE UNIQUE INDEX ags_invoice__idx ON
    ags_invoice (
        rental_id
    ASC );

ALTER TABLE ags_invoice ADD CONSTRAINT ags_invoice_pk PRIMARY KEY ( invoice_no );

CREATE TABLE ags_payment (
    payment_id     NUMBER(10) NOT NULL,
    payment_method NVARCHAR2(30) NOT NULL,
    payment_amount NUMBER(6, 2) NOT NULL,
    payment_name   NVARCHAR2(30) NOT NULL,
    invoice_no     NUMBER(10) NOT NULL
);

COMMENT ON COLUMN ags_payment.payment_id IS
    'UNIQUE PAYMENT ID';

COMMENT ON COLUMN ags_payment.payment_method IS
    'PAYMENT METHOD FOR RENTAL';

COMMENT ON COLUMN ags_payment.payment_amount IS
    'PAYMENT AMOUNT FOR RENTAL IN USD';

COMMENT ON COLUMN ags_payment.payment_name IS
    'CARD HOLDER NAME OR NAME OF PERSON WHO MADE PAYMENT';

ALTER TABLE ags_payment ADD CONSTRAINT ags_payment_pk PRIMARY KEY ( payment_id );

CREATE TABLE ags_rental (
    rental_id     NUMBER(10) NOT NULL,
    rental_status CHAR(1) NOT NULL,
    borrow_date   DATE NOT NULL,
    actual_ret_dt DATE NOT NULL,
    copy_id       NUMBER(10) NOT NULL,
    cust_id       NUMBER(10) NOT NULL
);

COMMENT ON COLUMN ags_rental.rental_id IS
    'UNIQUE RENTAL ID';

COMMENT ON COLUMN ags_rental.rental_status IS
    'RENTAL STATUS: ''B'' BORROWED, ''R'' RETURNED OR ''L'' LATE';

COMMENT ON COLUMN ags_rental.borrow_date IS
    'RENTAL BORROW DATE';

COMMENT ON COLUMN ags_rental.actual_ret_dt IS
    'ACTUAL RENTAL RETURN DATE';

ALTER TABLE ags_rental ADD CONSTRAINT ags_rental_pk PRIMARY KEY ( rental_id );

CREATE TABLE ags_reservation (
    reservation_id NUMBER(10) NOT NULL,
    time_slot      CHAR(1) NOT NULL,
    cust_id        NUMBER(10) NOT NULL,
    room_id        NUMBER(4) NOT NULL
);

COMMENT ON COLUMN ags_reservation.reservation_id IS
    'UNIQUE RESERVATION ID';

COMMENT ON COLUMN ags_reservation.time_slot IS
    'ONE OF THE 4 TIME SLOTS OF RESERVATION';

ALTER TABLE ags_reservation ADD CONSTRAINT ags_reservation_pk PRIMARY KEY ( reservation_id );

CREATE TABLE ags_room (
    room_id   NUMBER(4) NOT NULL,
    room_name NVARCHAR2(30) NOT NULL,
    capacity  NUMBER(3) NOT NULL
);

COMMENT ON COLUMN ags_room.room_id IS
    'UNIQUE ROOM ID';

COMMENT ON COLUMN ags_room.room_name IS
    'NAME OF THE ROOM';

COMMENT ON COLUMN ags_room.capacity IS
    'MAXIMUM NUMBER OF PEOPLE IN THE ROOM AT A TIME';

ALTER TABLE ags_room ADD CONSTRAINT ags_room_pk PRIMARY KEY ( room_id );

CREATE TABLE ags_sem_spn (
    event_id       NUMBER(10) NOT NULL,
    sponsor_id     NUMBER(10) NOT NULL,
    sponsor_amount NUMBER(12, 2) NOT NULL
);

COMMENT ON COLUMN ags_sem_spn.sponsor_amount IS
    'SPONSORSHIP AMOUNT IN USD';

ALTER TABLE ags_sem_spn ADD CONSTRAINT ags_sem_spn_pk PRIMARY KEY ( event_id,
                                                                    sponsor_id );

CREATE TABLE ags_seminar (
    event_id        NUMBER(10) NOT NULL,
    invitation_code NVARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN ags_seminar.event_id IS
    'UNIQUE EVENT ID';

COMMENT ON COLUMN ags_seminar.invitation_code IS
    'SEMINAR INVITATION ID/CODE';

ALTER TABLE ags_seminar ADD CONSTRAINT ags_seminar_pk PRIMARY KEY ( event_id );

CREATE TABLE ags_sponsor (
    sponsor_id NUMBER(10) NOT NULL,
    fname      VARCHAR2(30) NOT NULL,
    lname      VARCHAR2(30),
    phoneno    NUMBER(10) NOT NULL,
    email      NVARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN ags_sponsor.sponsor_id IS
    'UNIQUE SPONSOR ID';

COMMENT ON COLUMN ags_sponsor.fname IS
    'SPONSOR FIRST NAME';

COMMENT ON COLUMN ags_sponsor.lname IS
    'SPONSOR LAST NAME';

COMMENT ON COLUMN ags_sponsor.phoneno IS
    'SPONSOR PHONE NUMBER';

COMMENT ON COLUMN ags_sponsor.email IS
    'SPONSOR EMAIL';

ALTER TABLE ags_sponsor ADD CONSTRAINT ags_sponsor_pk PRIMARY KEY ( sponsor_id );

CREATE TABLE ags_topics (
    topic_id   NUMBER(3) NOT NULL,
    topic_name VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN ags_topics.topic_id IS
    'UNIQUE TOPIC ID';

COMMENT ON COLUMN ags_topics.topic_name IS
    'TOPIC NAME';

ALTER TABLE ags_topics ADD CONSTRAINT ags_topics_pk PRIMARY KEY ( topic_id );

ALTER TABLE ags_bks_aut
    ADD CONSTRAINT ags_bks_aut_ags_author_fk FOREIGN KEY ( author_id )
        REFERENCES ags_author ( author_id );

ALTER TABLE ags_bks_aut
    ADD CONSTRAINT ags_bks_aut_ags_books_fk FOREIGN KEY ( book_id )
        REFERENCES ags_books ( book_id );

ALTER TABLE ags_bks_tpc
    ADD CONSTRAINT ags_bks_tpc_ags_books_fk FOREIGN KEY ( book_id )
        REFERENCES ags_books ( book_id );

ALTER TABLE ags_bks_tpc
    ADD CONSTRAINT ags_bks_tpc_ags_topics_fk FOREIGN KEY ( topic_id )
        REFERENCES ags_topics ( topic_id );

ALTER TABLE ags_cust_exh
    ADD CONSTRAINT ags_cust_exh_ags_customer_fk FOREIGN KEY ( cust_id )
        REFERENCES ags_customer ( cust_id );

ALTER TABLE ags_cust_exh
    ADD CONSTRAINT ags_cust_exh_ags_exhibition_fk FOREIGN KEY ( event_id )
        REFERENCES ags_exhibition ( event_id );

ALTER TABLE ags_event
    ADD CONSTRAINT ags_event_ags_topics_fk FOREIGN KEY ( topic_id )
        REFERENCES ags_topics ( topic_id );

ALTER TABLE ags_exhibition
    ADD CONSTRAINT ags_exhibition_ags_event_fk FOREIGN KEY ( event_id )
        REFERENCES ags_event ( event_id );

ALTER TABLE ags_inventory
    ADD CONSTRAINT ags_inventory_ags_books_fk FOREIGN KEY ( book_id )
        REFERENCES ags_books ( book_id );

ALTER TABLE ags_invoice
    ADD CONSTRAINT ags_invoice_ags_rental_fk FOREIGN KEY ( rental_id )
        REFERENCES ags_rental ( rental_id );

ALTER TABLE ags_payment
    ADD CONSTRAINT ags_payment_ags_invoice_fk FOREIGN KEY ( invoice_no )
        REFERENCES ags_invoice ( invoice_no );

ALTER TABLE ags_rental
    ADD CONSTRAINT ags_rental_ags_customer_fk FOREIGN KEY ( cust_id )
        REFERENCES ags_customer ( cust_id );

ALTER TABLE ags_rental
    ADD CONSTRAINT ags_rental_ags_inventory_fk FOREIGN KEY ( copy_id )
        REFERENCES ags_inventory ( copy_id );

ALTER TABLE ags_reservation
    ADD CONSTRAINT ags_res_ags_cust_fk FOREIGN KEY ( cust_id )
        REFERENCES ags_customer ( cust_id );

ALTER TABLE ags_reservation
    ADD CONSTRAINT ags_reservation_ags_room_fk FOREIGN KEY ( room_id )
        REFERENCES ags_room ( room_id );

ALTER TABLE ags_sem_spn
    ADD CONSTRAINT ags_sem_spn_ags_seminar_fk FOREIGN KEY ( event_id )
        REFERENCES ags_seminar ( event_id );

ALTER TABLE ags_sem_spn
    ADD CONSTRAINT ags_sem_spn_ags_sponsor_fk FOREIGN KEY ( sponsor_id )
        REFERENCES ags_sponsor ( sponsor_id );

ALTER TABLE ags_seminar
    ADD CONSTRAINT ags_seminar_ags_event_fk FOREIGN KEY ( event_id )
        REFERENCES ags_event ( event_id );

CREATE OR REPLACE TRIGGER arc_fkarc_2_ags_exhibition BEFORE
    INSERT OR UPDATE OF event_id ON ags_exhibition
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.event_type
    INTO d
    FROM
        ags_event a
    WHERE
        a.event_id = :new.event_id;

    IF ( d IS NULL OR d <> 'E' ) THEN
        raise_application_error(-20223, 'FK AGS_EXHIBITION_AGS_EVENT_FK in Table AGS_EXHIBITION violates Arc constraint on Table AGS_EVENT - discriminator column EVENT_TYPE doesn''t have value ''E'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_ags_seminar BEFORE
    INSERT OR UPDATE OF event_id ON ags_seminar
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.event_type
    INTO d
    FROM
        ags_event a
    WHERE
        a.event_id = :new.event_id;

    IF ( d IS NULL OR d <> 'S' ) THEN
        raise_application_error(-20223, 'FK AGS_SEMINAR_AGS_EVENT_FK in Table AGS_SEMINAR violates Arc constraint on Table AGS_EVENT - discriminator column EVENT_TYPE doesn''t have value ''S'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             1
-- ALTER TABLE                             37
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
