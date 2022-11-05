-- SQLINES DEMO *** le SQL Developer Data Modeler 22.2.0.165.1149
-- SQLINES DEMO *** -11-03 15:55:15 GMT-04:00
-- SQLINES DEMO *** le Database 21c
-- SQLINES DEMO *** le Database 21c



-- SQLINES DEMO *** no DDL - MDSYS.SDO_GEOMETRY

-- SQLINES DEMO *** no DDL - XMLTYPE

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_author (
    author_id    BIGINT NOT NULL COMMENT 'UNIQUE AUTHOR ID',
    fname        VARCHAR(30) NOT NULL COMMENT 'AUTHOR FIRST NAME',
    lname        VARCHAR(30) NOT NULL COMMENT 'AUTHOR LAST NAME',
    email        NVARCHAR(30) NOT NULL COMMENT 'AUTHOR EMAIL ID',
    street_addr1 NVARCHAR(30) NOT NULL COMMENT 'AUTHOR STREET ADDRESS1',
    street_addr2 NVARCHAR(30) COMMENT 'AUTHOR STREET ADDRESS2',
    city         VARCHAR(30) NOT NULL COMMENT 'AUTHOR CITY ADDRESS',
    state        VARCHAR(30) NOT NULL COMMENT 'AUTHOR STATE',
    zipcode      NVARCHAR(10) NOT NULL COMMENT 'AUTHOR ZIPCODE ADDRESS'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.author_id IS
    'UNIQUE AUTHOR ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.fname IS
    'AUTHOR FIRST NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.lname IS
    'AUTHOR LAST NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.email IS
    'AUTHOR EMAIL ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.street_addr1 IS
    'AUTHOR STREET ADDRESS1'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.street_addr2 IS
    'AUTHOR STREET ADDRESS2'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.city IS
    'AUTHOR CITY ADDRESS'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.state IS
    'AUTHOR STATE'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_author.zipcode IS
    'AUTHOR ZIPCODE ADDRESS'; */

ALTER TABLE ags_author ADD CONSTRAINT ags_author_pk PRIMARY KEY ( author_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_bks_aut (
    book_id   BIGINT NOT NULL,
    author_id BIGINT NOT NULL
);

ALTER TABLE ags_bks_aut ADD CONSTRAINT ags_bks_aut_pk PRIMARY KEY ( author_id,
                                                                    book_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_bks_tpc (
    book_id  BIGINT NOT NULL,
    topic_id SMALLINT NOT NULL
);

ALTER TABLE ags_bks_tpc ADD CONSTRAINT ags_bks_tpc_pk PRIMARY KEY ( topic_id,
                                                                    book_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_books (
    book_id      BIGINT NOT NULL COMMENT 'UNIQUE BOOK ID',
    book_name    NVARCHAR(30) NOT NULL COMMENT 'BOOK NAME',
    publish_date DATETIME NOT NULL COMMENT 'BOOK PUBLISH DATE'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_books.book_id IS
    'UNIQUE BOOK ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_books.book_name IS
    'BOOK NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_books.publish_date IS
    'BOOK PUBLISH DATE'; */

ALTER TABLE ags_books ADD CONSTRAINT ags_books_pk PRIMARY KEY ( book_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_cust_exh (
    registration_id   BIGINT NOT NULL COMMENT 'UNIQUE REGISTRATION ID FOR EACH CUSTOMER FOR EACH EXHIBITION',
    registration_date DATETIME NOT NULL COMMENT 'REGISTRATION DATE',
    cust_id           BIGINT NOT NULL,
    event_id          BIGINT NOT NULL
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_cust_exh.registration_id IS
    'UNIQUE REGISTRATION ID FOR EACH CUSTOMER FOR EACH EXHIBITION'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_cust_exh.registration_date IS
    'REGISTRATION DATE'; */

ALTER TABLE ags_cust_exh ADD CONSTRAINT ags_cust_exh_pk PRIMARY KEY ( registration_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_customer (
    cust_id BIGINT NOT NULL COMMENT 'UNIQUE CUSTOMER ID',
    fname   VARCHAR(30) NOT NULL COMMENT 'CUSTOMER FIRST NAME',
    midname VARCHAR(30) COMMENT 'CUSTOMER MID NAME',
    lname   VARCHAR(30) NOT NULL COMMENT 'CUSTOMER LAST NAME',
    phoneno BIGINT NOT NULL COMMENT 'CUSTOMER US PHONE NUMBER',
    email   NVARCHAR(30) NOT NULL COMMENT 'CUSTOMER EMAIL ID',
    id_type CHAR(1) NOT NULL COMMENT 'CUSTOMER ID TYPE IN ''P''(PASSPORT), ''S''(SSN) OR ''D''(DRIVING LICENSE)',
    id_num  NVARCHAR(20) NOT NULL COMMENT 'CUSTOMER ID NUMBER'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.cust_id IS
    'UNIQUE CUSTOMER ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.fname IS
    'CUSTOMER FIRST NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.midname IS
    'CUSTOMER MID NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.lname IS
    'CUSTOMER LAST NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.phoneno IS
    'CUSTOMER US PHONE NUMBER'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.email IS
    'CUSTOMER EMAIL ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.id_type IS
    'CUSTOMER ID TYPE IN ''P''(PASSPORT), ''S''(SSN) OR ''D''(DRIVING LICENSE)'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_customer.id_num IS
    'CUSTOMER ID NUMBER'; */

ALTER TABLE ags_customer ADD CONSTRAINT ags_customer_pk PRIMARY KEY ( cust_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_event (
    event_id    BIGINT NOT NULL COMMENT 'UNIQUE EVENT ID',
    e_name      VARCHAR(20) NOT NULL COMMENT 'EVENT NAME',
    description NVARCHAR(150) COMMENT 'EVENT DESCRIPTION',
    start_date  DATETIME NOT NULL COMMENT 'EVENT START DATE',
    end_date    DATETIME NOT NULL COMMENT 'EVENT END DATE',
    event_type  CHAR(1) NOT NULL COMMENT 'EVENT TYPE ''S''(SEMINAR) OR ''E''(EXHIBITION)',
    topic_id    SMALLINT NOT NULL
);

ALTER TABLE ags_event
    ADD CONSTRAINT ch_inh_ags_event CHECK ( event_type IN ( 'E', 'S' ) );

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_event.event_id IS
    'UNIQUE EVENT ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_event.e_name IS
    'EVENT NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_event.description IS
    'EVENT DESCRIPTION'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_event.start_date IS
    'EVENT START DATE'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_event.end_date IS
    'EVENT END DATE'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_event.event_type IS
    'EVENT TYPE ''S''(SEMINAR) OR ''E''(EXHIBITION)'; */

ALTER TABLE ags_event ADD CONSTRAINT ags_event_pk PRIMARY KEY ( event_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_exhibition (
    event_id BIGINT NOT NULL COMMENT 'UNIQUE EVENT ID',
    expenses DECIMAL(10, 2) NOT NULL COMMENT 'EXHIBITION EXPENSES IN USD'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_exhibition.event_id IS
    'UNIQUE EVENT ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_exhibition.expenses IS
    'EXHIBITION EXPENSES IN USD'; */

ALTER TABLE ags_exhibition ADD CONSTRAINT ags_exhibition_pk PRIMARY KEY ( event_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_inventory (
    copy_id BIGINT NOT NULL COMMENT 'UNIQUE COPY ID',
    status  CHAR(1) NOT NULL COMMENT 'COPY STATUS ''A''(AVAILABLE) OR ''U''(UNAVAILABLE)',
    book_id BIGINT NOT NULL
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_inventory.copy_id IS
    'UNIQUE COPY ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_inventory.status IS
    'COPY STATUS ''A''(AVAILABLE) OR ''U''(UNAVAILABLE)'; */

ALTER TABLE ags_inventory ADD CONSTRAINT ags_inventory_pk PRIMARY KEY ( copy_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_invoice (
    invoice_no   BIGINT NOT NULL COMMENT 'UNIQUE INVOICE NUMBER',
    invoice_date DATETIME NOT NULL COMMENT 'INVOICE GENERATION DATE',
    invoice_amount BIGINT NOT NULL COMMENT 'INVOICE AMOUNT',
    rental_id    BIGINT NOT NULL
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_invoice.invoice_no IS
    'UNIQUE INVOICE NUMBER'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_invoice.invoice_date IS
    'INVOICE GENERATION DATE'; */

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE UNIQUE INDEX ags_invoice__idx ON
    ags_invoice (
        rental_id
    ASC );

ALTER TABLE ags_invoice ADD CONSTRAINT ags_invoice_pk PRIMARY KEY ( invoice_no );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_payment (
    payment_id     BIGINT NOT NULL COMMENT 'UNIQUE PAYMENT ID',
    payment_method NVARCHAR(30) NOT NULL COMMENT 'PAYMENT METHOD FOR RENTAL',
    payment_amount DECIMAL(6, 2) NOT NULL COMMENT 'PAYMENT AMOUNT FOR RENTAL IN USD',
    payment_name   NVARCHAR(30) NOT NULL COMMENT 'CARD HOLDER NAME OR NAME OF PERSON WHO MADE PAYMENT',
    invoice_no     BIGINT NOT NULL
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_payment.payment_id IS
    'UNIQUE PAYMENT ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_payment.payment_method IS
    'PAYMENT METHOD FOR RENTAL'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_payment.payment_amount IS
    'PAYMENT AMOUNT FOR RENTAL IN USD'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_payment.payment_name IS
    'CARD HOLDER NAME OR NAME OF PERSON WHO MADE PAYMENT'; */

ALTER TABLE ags_payment ADD CONSTRAINT ags_payment_pk PRIMARY KEY ( payment_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_rental (
    rental_id     BIGINT NOT NULL COMMENT 'UNIQUE RENTAL ID',
    rental_status CHAR(1) NOT NULL COMMENT 'RENTAL STATUS: ''B'' BORROWED, ''R'' RETURNED OR ''L'' LATE',
    borrow_date   DATETIME NOT NULL COMMENT 'RENTAL BORROW DATE',
    actual_ret_dt DATETIME NOT NULL COMMENT 'ACTUAL RENTAL RETURN DATE',
    copy_id       BIGINT NOT NULL,
    cust_id       BIGINT NOT NULL
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_rental.rental_id IS
    'UNIQUE RENTAL ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_rental.rental_status IS
    'RENTAL STATUS: ''B'' BORROWED, ''R'' RETURNED OR ''L'' LATE'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_rental.borrow_date IS
    'RENTAL BORROW DATE'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_rental.actual_ret_dt IS
    'ACTUAL RENTAL RETURN DATE'; */

ALTER TABLE ags_rental ADD CONSTRAINT ags_rental_pk PRIMARY KEY ( rental_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_reservation (
    reservation_id BIGINT NOT NULL COMMENT 'UNIQUE RESERVATION ID',
    time_slot      CHAR(1) NOT NULL COMMENT 'ONE OF THE 4 TIME SLOTS OF RESERVATION',
    cust_id        BIGINT NOT NULL,
    room_id        SMALLINT NOT NULL
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_reservation.reservation_id IS
    'UNIQUE RESERVATION ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_reservation.time_slot IS
    'ONE OF THE 4 TIME SLOTS OF RESERVATION'; */

ALTER TABLE ags_reservation ADD CONSTRAINT ags_reservation_pk PRIMARY KEY ( reservation_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_room (
    room_id   SMALLINT NOT NULL COMMENT 'UNIQUE ROOM ID',
    room_name NVARCHAR(30) NOT NULL COMMENT 'NAME OF THE ROOM',
    capacity  SMALLINT NOT NULL COMMENT 'MAXIMUM NUMBER OF PEOPLE IN THE ROOM AT A TIME'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_room.room_id IS
    'UNIQUE ROOM ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_room.room_name IS
    'NAME OF THE ROOM'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_room.capacity IS
    'MAXIMUM NUMBER OF PEOPLE IN THE ROOM AT A TIME'; */

ALTER TABLE ags_room ADD CONSTRAINT ags_room_pk PRIMARY KEY ( room_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_sem_spn (
    event_id       BIGINT NOT NULL,
    sponsor_id     BIGINT NOT NULL,
    sponsor_amount DECIMAL(12, 2) NOT NULL COMMENT 'SPONSORSHIP AMOUNT IN USD'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_sem_spn.sponsor_amount IS
    'SPONSORSHIP AMOUNT IN USD'; */

ALTER TABLE ags_sem_spn ADD CONSTRAINT ags_sem_spn_pk PRIMARY KEY ( event_id,
                                                                    sponsor_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_seminar (
    event_id        BIGINT NOT NULL COMMENT 'UNIQUE EVENT ID',
    invitation_code NVARCHAR(30) NOT NULL COMMENT 'SEMINAR INVITATION ID/CODE'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_seminar.event_id IS
    'UNIQUE EVENT ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_seminar.invitation_code IS
    'SEMINAR INVITATION ID/CODE'; */

ALTER TABLE ags_seminar ADD CONSTRAINT ags_seminar_pk PRIMARY KEY ( event_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_sponsor (
    sponsor_id BIGINT NOT NULL COMMENT 'UNIQUE SPONSOR ID',
    fname      VARCHAR(30) NOT NULL COMMENT 'SPONSOR FIRST NAME',
    lname      VARCHAR(30) COMMENT 'SPONSOR LAST NAME',
    phoneno    BIGINT NOT NULL COMMENT 'SPONSOR PHONE NUMBER',
    email      NVARCHAR(30) NOT NULL COMMENT 'SPONSOR EMAIL'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_sponsor.sponsor_id IS
    'UNIQUE SPONSOR ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_sponsor.fname IS
    'SPONSOR FIRST NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_sponsor.lname IS
    'SPONSOR LAST NAME'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_sponsor.phoneno IS
    'SPONSOR PHONE NUMBER'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_sponsor.email IS
    'SPONSOR EMAIL'; */

ALTER TABLE ags_sponsor ADD CONSTRAINT ags_sponsor_pk PRIMARY KEY ( sponsor_id );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE ags_topics (
    topic_id   SMALLINT NOT NULL COMMENT 'UNIQUE TOPIC ID',
    topic_name VARCHAR(30) NOT NULL COMMENT 'TOPIC NAME'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_topics.topic_id IS
    'UNIQUE TOPIC ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN ags_topics.topic_name IS
    'TOPIC NAME'; */

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

-- SQLINES LICENSE FOR EVALUATION USE ONLY
DROP TRIGGER IF EXISTS arc_fkarc_2_ags_exhibition_ins;

DELIMITER //

CREATE TRIGGER arc_fkarc_2_ags_exhibition_ins BEFORE INSERT ON ags_exhibition
    FOR EACH ROW
    
BEGIN
	DECLARE d CHAR(1);
    -- SQLINES LICENSE FOR EVALUATION USE ONLY
    SELECT
        a.event_type
    INTO d
    FROM
        ags_event a
    WHERE
        a.event_id = new.event_id;

    IF ( d IS NULL OR d <> 'E' ) THEN
    SIGNAL SQLSTATE '560BF' SET MESSAGE_TEXT = 'FK AGS_EXHIBITION_AGS_EVENT_FK in Table AGS_EXHIBITION violates Arc constraint on Table AGS_EVENT - discriminator column EVENT_TYPE doesn''t have value ''E''';
    END IF;
END;
//
DELIMITER ;

DROP TRIGGER IF EXISTS arc_fkarc_2_ags_exhibition_upd;

DELIMITER //

CREATE TRIGGER arc_fkarc_2_ags_exhibition_upd BEFORE UPDATE ON ags_exhibition
    FOR EACH ROW
    
BEGIN
	DECLARE d CHAR(1);
    -- SQLINES LICENSE FOR EVALUATION USE ONLY
    SELECT
        a.event_type
    INTO d
    FROM
        ags_event a
    WHERE
        a.event_id = new.event_id;

    IF ( d IS NULL OR d <> 'E' ) THEN
    SIGNAL SQLSTATE '560BF' SET MESSAGE_TEXT = 'FK AGS_EXHIBITION_AGS_EVENT_FK in Table AGS_EXHIBITION violates Arc constraint on Table AGS_EVENT - discriminator column EVENT_TYPE doesn''t have value ''E''';
    END IF;
END;
//
DELIMITER ;


-- SQLINES LICENSE FOR EVALUATION USE ONLY
DROP TRIGGER IF EXISTS arc_fkarc_2_ags_seminar_ins;

DELIMITER //

CREATE TRIGGER arc_fkarc_2_ags_seminar_ins BEFORE INSERT ON ags_seminar
    FOR EACH ROW
    
BEGIN
	DECLARE d CHAR(1);
    -- SQLINES LICENSE FOR EVALUATION USE ONLY
    SELECT
        a.event_type
    INTO d
    FROM
        ags_event a
    WHERE
        a.event_id = new.event_id;

    IF ( d IS NULL OR d <> 'S' ) THEN
    SIGNAL SQLSTATE '560BF' SET MESSAGE_TEXT = 'FK AGS_SEMINAR_AGS_EVENT_FK in Table AGS_SEMINAR violates Arc constraint on Table AGS_EVENT - discriminator column EVENT_TYPE doesn''t have value ''S''';
    END IF;
END;
//
DELIMITER ;

DROP TRIGGER IF EXISTS arc_fkarc_2_ags_seminar_upd;

DELIMITER //

CREATE TRIGGER arc_fkarc_2_ags_seminar_upd BEFORE UPDATE ON ags_seminar
    FOR EACH ROW
    
BEGIN
	DECLARE d CHAR(1);
    -- SQLINES LICENSE FOR EVALUATION USE ONLY
    SELECT
        a.event_type
    INTO d
    FROM
        ags_event a
    WHERE
        a.event_id = new.event_id;

    IF ( d IS NULL OR d <> 'S' ) THEN
    SIGNAL SQLSTATE '560BF' SET MESSAGE_TEXT = 'FK AGS_SEMINAR_AGS_EVENT_FK in Table AGS_SEMINAR violates Arc constraint on Table AGS_EVENT - discriminator column EVENT_TYPE doesn''t have value ''S''';
    END IF;
END;
//
DELIMITER ;

-- SQLINES DEMO *** per Data Modeler Summary Report: 
-- 
-- SQLINES DEMO ***                        18
-- SQLINES DEMO ***                         1
-- SQLINES DEMO ***                        37
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** DY                      0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         2
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***  TYPE                   0
-- SQLINES DEMO ***  TYPE                   0
-- SQLINES DEMO ***  TYPE BODY              0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** EGMENT                  0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** ED VIEW                 0
-- SQLINES DEMO *** ED VIEW LOG             0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- 
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- 
-- SQLINES DEMO ***                         0
-- 
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** A                       0
-- SQLINES DEMO *** T                       0
-- 
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
