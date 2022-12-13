from flask import Flask, render_template, request, redirect, url_for, session
from flaskext.mysql import MySQL
#import MySQLdb.cursors
import re
import hashlib
from datetime import datetime,date,timedelta

app = Flask(__name__)
app.secret_key = 'mykey12345asgproj1'

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'REAL'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)



# conn = mysql.connect()
# cursor =conn.cursor()

# cursor.execute("call ags_sponsor_s")
# data = cursor.fetchall()
# print(data)




#routes
@app.route('/')
@app.route('/login2', methods =['GET', 'POST'])
def login2():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        encoded_str = password.encode()
        password = hashlib.sha256(encoded_str).hexdigest()
        #cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('SELECT cust_id,username,fname FROM ags_customer WHERE username = % s AND password = % s', (username, password, ))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['id'] = account[0]
            session['username'] = account[1]
            session['fname'] = account[2]
            msg = 'Logged in successfully !'
            return home()
        else:
            msg = 'Incorrect username / password !'
    return render_template('login2.html', msg = msg)

@app.route('/admin-login', methods =['GET', 'POST'])
def adminLogin():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']

        if (username == 'admin' and password == 'admin'):
            session['admin'] = True
            session['loggedin'] = True
            session['id'] = 'admin'
            session['username'] = 'admin'
            session['fname'] = 'admin'
            msg = 'Admin Logged in successfully !'
            return admin()
        else:
            msg = 'Incorrect username / password !'
    return render_template('admin-login.html', msg = msg)

@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    session.pop('fname', None)
    return redirect(url_for('login2'))

@app.route('/logout-admin')
def logoutAdmin():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    session.pop('fname', None)
    return redirect(url_for('adminLogin'))

@app.route('/register', methods =['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form and 'fName' in request.form and 'lName' in request.form and 'idType' in request.form and 'idNumber' in request.form and 'phoneNo' in request.form:
        username = request.form['username']
        password = request.form['password']
        encoded_str = password.encode()
        password = hashlib.sha256(encoded_str).hexdigest()
        email = request.form['email']
        fName = request.form['fName']
        mName = request.form['mName']
        lName = request.form['lName']
        idType = request.form['idType']
        idNumber = request.form['idNumber']
        phoneNo = request.form['phoneNo']
        #cursor = mysql.connect().cursor()
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('SELECT * FROM ags_customer WHERE username = % s', (username, ))
        account = cursor.fetchone()

        cursor.execute('select max(cust_id) from ags_customer;')
        cust_id = cursor.fetchone()
        cId = cust_id[0] + 1
        if account:
            msg = 'Account already exists !'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address !'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers !'
        elif not re.match(r'[0-9]+',phoneNo):
            msg = 'Invalid Phone Number'
        elif not username or not password or not email or not fName or not lName or not idNumber:
            msg = 'Please fill out all the necessary columns in form !'
        elif idType not in 'PSD':
            msg = 'Please choose a valid ID type'
        else:
            cursor.execute('INSERT INTO ags_customer VALUES (%s, % s, % s, % s, %s, % s, % s, % s, % s, % s)', (cId, fName, mName, lName, phoneNo, email, idType, idNumber, password ,username ))
            conn.commit()
            msg = 'You have successfully registered !'
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('register.html', msg = msg)

@app.route('/register-book', methods =['GET', 'POST'])
def registerBook():
    msg = ''
    if request.method == 'POST' and 'bookName' in request.form and 'bookDate' in request.form and session and session['id'] == 'admin':
        bookName = request.form['bookName']
        bookDate = request.form['bookDate']
        conn = mysql.connect()
        cursor =conn.cursor()

        cursor.execute('select max(book_id) from ags_books;')
        book_id = cursor.fetchone()
        bId = book_id[0] + 1

        cursor.execute('select max(copy_id) from ags_inventory;')
        copy_id = cursor.fetchone()
        cId = copy_id[0] + 1

        cursor.execute('select book_id from ags_books where book_name = %s;', (bookName))
        existingBook = cursor.fetchone()

        if (existingBook != None) :
            existingId = existingBook[0]
            cursor.execute('INSERT INTO ags_inventory VALUES (%s, % s, % s)', (cId, 'A', existingId))
        else:
            cursor.execute('INSERT INTO ags_books VALUES (%s, % s, % s)', (bId, bookName, bookDate))
            cursor.execute('INSERT INTO ags_inventory VALUES (%s, % s, % s)', (cId, 'A', bId))

        conn.commit()
        msg = 'You have successfully registered !'
    return redirect(url_for('admin'))


@app.route('/home')
def home(msg = ''):
    if session:

        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute(
            '''select event_id,e_name,description,start_date,end_date,
            case when event_type = 'S' then 'Seminar' else 'Exhibition' end as eventType, t.topic_name
            from ags_event e
            inner join ags_topics t on e.topic_id = t.topic_id
            where start_date > now() order by start_date''')
        ets = cursor.fetchall()

        cursor.execute(
            '''select cpy.book_id,cpy.book_name, cpy.copies, GROUP_CONCAT(' ',a.fname,' ',a.lname) AS authors from
            (select b.book_id, b.book_name,count(*) as copies from ags_books b
            inner join ags_inventory i on b.book_id = i.book_id
            where i.status = 'A'
            group by b.book_id) cpy
            left join ags_bks_aut ba on cpy.book_id = ba.book_id
            left join ags_author a on a.author_id = ba.author_id
            group by cpy.book_id;'''
            )
        books = cursor.fetchall()

        return  render_template('home.html',events = ets,books = books, date = datetime.now().strftime("%d-%b-%Y %H.%M %p"), msg = msg)
    else:
        return render_template('login2.html', msg = 'Not logged in. Please login again')

@app.route('/admin')
def admin(msg = ''):
    if (session and session['id'] == 'admin'):
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute(
            '''select event_id,e_name,description,start_date,end_date,
            case when event_type = 'S' then 'Seminar' else 'Exhibition' end as eventType, t.topic_name
            from ags_event e
            inner join ags_topics t on e.topic_id = t.topic_id
            where start_date > now() order by start_date''')
        ets = cursor.fetchall()

        cursor.execute(
            '''select cpy.book_id,cpy.book_name, cpy.copies, GROUP_CONCAT(' ',a.fname,' ',a.lname) AS authors from
            (select b.book_id, b.book_name,count(*) as copies from ags_books b
            inner join ags_inventory i on b.book_id = i.book_id
            where i.status = 'A'
            group by b.book_id) cpy
            left join ags_bks_aut ba on cpy.book_id = ba.book_id
            left join ags_author a on a.author_id = ba.author_id
            group by cpy.book_id;'''
            )
        books = cursor.fetchall()
        return  render_template('admin-home.html', msg = msg, events = ets, books = books)
    else:
        return render_template('admin-login.html', msg = 'Not logged in. Please login again')


@app.route('/addNewBook', methods =['GET', 'POST'])
def addNewBook():
    return  render_template('addNewBook.html')

@app.route('/admin-books', methods =['GET', 'POST'])
def adminBooks():
    if (session and session['id'] == 'admin'):
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('''select r.cust_id,b.book_name,r.borrow_date,r.actual_ret_dt, inv.invoice_amount,
                          IFNULL(SUM(P.payment_amount),0) AS amount_paid,
                          inv.invoice_amount - IFNULL(SUM(P.payment_amount),0) AS balance
                          from ags_rental r
                          left join ags_inventory i on r.copy_id = i.copy_id
                          left join ags_books b on i.book_id = b.book_id
                          inner join ags_invoice inv on inv.rental_id = r.rental_id
                          left join ags_payment p on inv.invoice_no = p.invoice_no
                          where r.rental_status <> 'B'
                          group by r.rental_id
                          order by actual_ret_dt desc,borrow_date desc;''')
        bookHist = cursor.fetchall()

        cursor.execute('''select r.rental_id, b.book_name, r.borrow_date, DATE_ADD(r.borrow_date, INTERVAL 1 MONTH), r.cust_id as expRetDt
                from ags_rental r
                left join ags_inventory i on r.copy_id = i.copy_id
                left join ags_books b on i.book_id = b.book_id
                where r.rental_status = 'B'
        ''')
        bookBor = cursor.fetchall()
        return  render_template('admin-books.html', bookHist = bookHist, bookBor = bookBor, msg='')
    else:
        return render_template('admin-login.html', msg = 'Not logged in. Please login again')

@app.route('/borrow', methods =['GET', 'POST'])
def borrow():
    msg = ''
    if request.method == 'POST' and 'bookId' in request.form:
        bookId = request.form['bookId']
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('select copy_id from ags_inventory where book_id = %s and status = \'A\' limit 1', (bookId,))
        book = cursor.fetchone()
        if not book:
            msg = 'Sorry the book is no longer available. Please try later.'
        else:
            cursor.execute('update ags_inventory set status = \'U\' where copy_id = %s', str(book[0]))
            cursor.execute('select max(rental_id) from ags_rental')
            rentalId = cursor.fetchone()
            cursor.execute('''INSERT INTO ags_rental (rental_id, rental_status, borrow_date, actual_ret_dt, copy_id, cust_id) VALUES
                                 (% s, 'B', now(), NULL, % s, % s)''',(str(int(rentalId[0]) + 1), str(book[0]), session['id']))
            conn.commit()
            msg = 'Successfully Rented'# + str(int(rentalId[0]) + 1) + str(book[0])
    return home(msg)

@app.route('/books')
def books(msg = ''):
    if session:
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('call AGS_BOOK_HIST_BY_ID( % s)', (session['id'],))
        bookHist = cursor.fetchall()

        cursor.execute('''select r.rental_id, b.book_name, r.borrow_date, DATE_ADD(r.borrow_date, INTERVAL 1 MONTH) as expRetDt
                from ags_rental r
                left join ags_inventory i on r.copy_id = i.copy_id
                left join ags_books b on i.book_id = b.book_id
                where r.rental_status = 'B'
                AND r.cust_id = % s''',(session['id'],))
        bookBor = cursor.fetchall()
        return  render_template('books.html', bookHist = bookHist, bookBor = bookBor, msg=msg)
    else:
        return render_template('login2.html', msg = 'Not logged in. Please login again')

@app.route('/returnBook', methods =['GET', 'POST'])
def returnBook():
    msg = ''
    if request.method == 'POST' and 'rentalId' in request.form:
        rentalId = request.form['rentalId']
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('select copy_id from ags_rental where rental_id = % s and rental_status = \'B\'', (rentalId,))
        copy = cursor.fetchone()
        if not copy:
            msg = 'You don\'t have the book you are trying to return. Please check again.'
        else:
            cursor.execute('update ags_inventory set status = \'A\' where copy_id = %s', str(copy[0]))

            cursor.execute('update ags_rental set actual_ret_dt = now() where rental_id = %s ' , (rentalId,))
            conn.commit()
            msg = 'Successfully Returned'# + str(int(rentalId[0]) + 1) + str(book[0])
    else:
        msg = 'Some error occurred. Please complain to Admin.'
    return books(msg)

@app.route('/profile', methods =['GET', 'POST'])
def profile():
    msg = ''
    if not session:
        return render_template('login2.html', msg = 'Not logged in. Please login again')

    conn = mysql.connect()
    cursor =conn.cursor()
    cId = session['id']
    cursor.execute('select * from ags_customer where cust_id= % s', (cId,))
    customer = cursor.fetchone()

    if customer and request.method == 'POST' and 'email' in request.form and 'fName' in request.form and 'lName' in request.form and 'idType' in request.form and 'idNumber' in request.form and 'phoneNo' in request.form:
        email = request.form['email']
        fName = request.form['fName']
        mName = request.form['mName']
        lName = request.form['lName']
        idType = request.form['idType']
        idNumber = request.form['idNumber']
        phoneNo = request.form['phoneNo']
        #cursor = mysql.connect().cursor()


        if not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address !'
        elif len(phoneNo)!=10 or not re.match(r'[0-9]+',phoneNo):
            msg = 'Invalid Phone Number'
        elif not email or not fName or not lName or not idNumber:
            msg = 'Please fill out all the necessary columns in form !'
        elif idType not in 'PSD':
            msg = 'Please choose a valid ID type'
        else:
            oldfName = customer[1]
            oldmName = customer[2]
            oldlName = customer[3]
            oldphoneNo = customer[4]
            oldemail = customer[5]
            oldidType = customer[6]
            oldidNum = customer[7]
            change = False
            query = 'update ags_customer set'
            if oldfName != fName:
                query = ''.join([query,' fname = \'',fName,'\','])
                change = True
            if oldmName != mName:
                query = ''.join([query,' midname = \'',mName,'\','])
                change = True
            if oldlName != lName:
                query = ''.join([query,' lname = \'',lName,'\','])
                change = True
            if int(oldphoneNo) != int(phoneNo):
                query = ''.join([query,' phoneno = \'',phoneNo,'\','])
                change = True
            if oldemail != email:
                query = ''.join([query,' email = \'',email,'\','])
                change = True
            if oldidType != idType:
                query = ''.join([query,' id_type = \'',idType,'\','])
                change = True
            if oldidNum != idNumber:
                query = ''.join([query,' id_num = \'',idNumber,'\','])
                change = True

            if change:
                query = query[:-1]
                query = ''.join([query,' where cust_id = ', str(cId)])
                cursor.execute(query)
                conn.commit()
                msg = 'You have successfully updated info !'
                cursor.execute('select * from ags_customer where cust_id= % s', (cId,))
                customer = cursor.fetchone()
    elif request.method == 'POST' and not customer:
        msg = 'Unable to Update at this time. Some error occurred. Please log out and log in again.'
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('profile.html', msg = msg, customer = customer)

@app.route('/admin-rooms')
def adminRooms(msg = ''):
    if (session and session['id'] == 'admin'):
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('select * from ags_room')
        rooms = cursor.fetchall()
        today = date.today()
        minDate = today + timedelta(days = 1)
        maxDate = today + timedelta(days = 30)
        cursor.execute('''select res.reservation_id,r.room_id,r.room_name, date(res.reservation_date) as resDt, getTimeSlot(time_slot), res.cust_id AS timeSlot
                from ags_reservation res
                left join ags_room r on r.room_id = res.room_id
                order by reservation_date desc, res.time_slot desc''')
        reservations = cursor.fetchall()
        return  render_template('admin-rooms.html', rooms = rooms, reservations = reservations, msg=msg, minDate = minDate, maxDate = maxDate)
    else:
        return render_template('admin-login.html', msg = 'Not logged in. Please login again')

@app.route('/rooms')
def rooms(msg = ''):
    if session:
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('select * from ags_room')
        rooms = cursor.fetchall()
        today = date.today()
        minDate = today + timedelta(days = 1)
        maxDate = today + timedelta(days = 30)
        cursor.execute('''select res.reservation_id,r.room_id,r.room_name, date(res.reservation_date) as resDt, getTimeSlot(time_slot) AS timeSlot
                from ags_reservation res
                left join ags_room r on r.room_id = res.room_id
                where res.cust_id = '%s'
                order by reservation_date desc, res.time_slot desc''',(session['id'],))
        reservations = cursor.fetchall()
        return  render_template('rooms.html', rooms = rooms, reservations = reservations, msg=msg, minDate = minDate, maxDate = maxDate)
    else:
        return render_template('login2.html', msg = 'Not logged in. Please login again')

@app.route('/bookRoom', methods =['GET', 'POST'])
def bookRoom():
    msg = ''
    if request.method == 'POST' and 'roomId' in request.form and 'bookDate' in request.form and 'bookTime' in request.form:
        roomId = request.form['roomId']
        bookDate = request.form['bookDate']
        bookTime = request.form['bookTime']
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('select * from ags_reservation where room_id = %s and reservation_date = %s and time_slot = %s', (roomId, bookDate, bookTime))
        reservation = cursor.fetchone()
        if reservation:
            msg = 'Sorry this slot is not available. Please select other slot and try again.'
        else:
            cursor.execute('select max(reservation_id) from ags_reservation')
            resId = cursor.fetchone()
            resId = str(int(resId[0]) + 1)
            cursor.execute('insert into ags_reservation values (%s, %s, %s, %s, %s )' , (resId, bookTime, session['id'],roomId,bookDate))
            conn.commit()
            msg = 'Successfully Booked Room. See My Bookings'
    else:
        msg = 'Some error occurred. Please select all the fields and try again.'
    return rooms(msg)

@app.route('/events')
def events(msg = ''):
    if session:
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('''select ce.registration_id, e.e_name, e.description,e.start_date,e.end_date from ags_cust_exh ce
                left join ags_exhibition ex on ex.event_id = ce.event_id
                inner join ags_event e on e.event_id = ex.event_id
                where e.start_date < now()
                and ce.cust_id = % s
                order by e.end_date desc, e.start_date desc''', (session['id'],))
        eventHist = cursor.fetchall()

        cursor.execute('''select ce.registration_id, e.e_name, e.description,e.start_date,e.end_date from ags_cust_exh ce
                left join ags_exhibition ex on ex.event_id = ce.event_id
                inner join ags_event e on e.event_id = ex.event_id
                where e.start_date > now()
                and ce.cust_id = % s
                order by e.start_date, end_date''',(session['id'],))
        upcomingEvents = cursor.fetchall()
        return  render_template('events.html', eventHist = eventHist, upcomingEvents = upcomingEvents, msg=msg)
    else:
        return render_template('login2.html', msg = 'Not logged in. Please login again')

@app.route('/registerEvent', methods =['GET', 'POST'])
def registerEvent():
    msg = ''
    if request.method == 'POST' and 'eventId' in request.form:
        eventId = request.form['eventId']
        conn = mysql.connect()
        cursor =conn.cursor()

        cursor.execute('select * from ags_cust_exh where event_id = %s and cust_id = %s',(eventId,session['id']))
        et = cursor.fetchall()

        if et:
            return home('You have already registered for this event. Check My Events')
        else:
            cursor.execute('select  ifnull(max(registration_id),0) from ags_cust_exh')
            reg_ID = cursor.fetchone()
            reg_ID = str(int(reg_ID[0]) + 1)

            cursor.execute('insert into ags_cust_exh VALUES (%s, now(), %s, %s)', (reg_ID, session['id'], eventId))

            conn.commit()
            msg = 'Successfully Registered'
    else:
        msg = 'Some error occurred. Please complain to Admin.'
    return events(msg)

@app.route('/forgotPass', methods =['GET', 'POST'])
def forgotPass():
    msg = ''
    ques = ''
    if request.method == 'POST' and 'uName' in request.form:
        uName = request.form['uName']
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('SELECT cust_id FROM ags_customer WHERE username = % s', (uName, ))
        custId = cursor.fetchone()
        if not custId:
            msg = 'User Doesn\'t exist'
        else:
            cursor.execute('''select ques_id,questions,answer,cust_id from ags_ques_cust qc
                            left join ags_questions q on q.quesid = qc.ques_id where cust_id = % s order by ques_id''', custId[0])
            ques = cursor.fetchall()

    if request.method == 'POST' and 'ans1' in request.form and 'ans2' in request.form and 'ans3' in request.form and 'cust_id' in request.form:
        ans1 = request.form['ans1']
        ans2 = request.form['ans2']
        ans3 = request.form['ans3']
        custid = request.form['cust_id']
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('''select ques_id,questions,answer,cust_id from ags_ques_cust qc
                            left join ags_questions q on q.quesid = qc.ques_id where cust_id = % s order by ques_id''', (custid,))
        ques = cursor.fetchall()
        exp1 = str(ques[0][2])
        exp2 = str(ques[1][2])
        exp3 = str(ques[2][2])
        if ans1.lower() != exp1.lower() or ans2.lower() != exp2.lower() or ans3.lower() != exp3.lower():
            msg = 'Answers Do not match'
        else:
            return render_template('passReset.html', custid = custid)

    return render_template('forgotPass.html',msg = msg, ques = ques)

@app.route('/passReset', methods =['GET', 'POST'])
def passReset():
    msg = 'aa'
    custid = ''
    if request.method == 'POST' and 'p1' in request.form and 'p2' in request.form and 'custid' in request.form:
        p1 = request.form['p1']
        p2 = request.form['p2']
        custid = request.form['custid']
        msg = 'ab'
        conn = mysql.connect()
        cursor =conn.cursor()
        if p1 != p2:
            msg = 'Passwords Do not match'
        elif custid == '':
            return render_template('login2.html', msg = 'Some error occurred. Please try later.')
        else:
            encoded_str = p1.encode()
            p1 = hashlib.sha256(encoded_str).hexdigest()
            cursor.execute('update ags_customer set password = % s where cust_id = % s', (p1,custid,))
            conn.commit()
            msg = 'Successfully Changed Password'
            return render_template('login2.html', msg = msg)

    return render_template('passReset.html',msg = msg, custid = custid)
