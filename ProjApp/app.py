from flask import Flask, render_template, request, redirect, url_for, session
from flaskext.mysql import MySQL
#import MySQLdb.cursors
import re
import hashlib

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

@app.route('/')
@app.route('/login2', methods =['GET', 'POST'])
def login2():
    msg = ''
    print(request.method, request.form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        encoded_str = password.encode()
        password = hashlib.sha256(encoded_str).hexdigest()
        #cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute('SELECT cust_id,username FROM ags_customer WHERE username = % s AND password = % s', (username, password, ))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['id'] = account[0]
            session['username'] = account[1]
            msg = 'Logged in successfully !'
            return render_template('index.html', msg = msg)
        else:
            msg = 'Incorrect username / password !'
            print('msg=' + msg)
    else:
        print('aslsla')
    return render_template('login2.html', msg = msg)
 
@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
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
        print(idType)
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

@app.route('/index2')
def index2():
    if session:
        return  render_template('index2.html')
    else:
        return render_template('login2.html', msg = 'Not logged in. Please login again')