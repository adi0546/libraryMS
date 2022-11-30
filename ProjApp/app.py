from flask import Flask, render_template, request, redirect, url_for, session
from flaskext.mysql import MySQL
#import MySQLdb.cursors
import re
import hashlib
from datetime import datetime

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
 
@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    session.pop('fname', None)
    return redirect(url_for('login2'))
 
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

@app.route('/home')
def home():
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
            '''select cpy.book_name, cpy.copies, GROUP_CONCAT(' ',a.fname,' ',a.lname) AS authors from
            (select b.book_id, b.book_name,count(*) as copies from ags_books b 
            inner join ags_inventory i on b.book_id = i.book_id
            where i.status = 'A'
            group by b.book_id) cpy
            left join ags_bks_aut ba on cpy.book_id = ba.book_id
            left join ags_author a on a.author_id = ba.author_id
            group by cpy.book_id;'''
            )
        books = cursor.fetchall()

        return  render_template('home.html',events = ets,books = books, date = datetime.now().strftime("%d-%b-%Y %H.%M %p"))
    else:
        return render_template('login2.html', msg = 'Not logged in. Please login again')

@app.route('/books')
def books():
    if session:
        return  render_template('books.html')
    else:
        return render_template('login2.html', msg = 'Not logged in. Please login again')
        

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