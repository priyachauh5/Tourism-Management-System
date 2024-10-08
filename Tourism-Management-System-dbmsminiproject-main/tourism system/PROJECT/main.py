from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
# from flask_mail import Mail
import json



# MY db connection
local_server= True
app = Flask(__name__)
app.secret_key='tmsprojects'


# this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'

# SMTP MAIL SERVER SETTINGS

# app.config.update(
#     MAIL_SERVER='smtp.gmail.com',
#     MAIL_PORT='465',
#     MAIL_USE_SSL=True,
#     MAIL_USERNAME="add your gmail-id",
#     MAIL_PASSWORD="add your gmail-password"
# )
# mail = Mail(app)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))




# app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/tmssdbms'
db=SQLAlchemy(app)



# here we will create db models that is tables
class booking(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    email=db.Column(db.String(100))

class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    usertype=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Tourist(db.Model):
    t_id=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    gender=db.Column(db.String(50))
    slot=db.Column(db.String(50))
    location=db.Column(db.String(50))
    time=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=False)
    occupation=db.Column(db.String(50))
    number=db.Column(db.String(50))

class Visitors(db.Model):
    vis_id=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    vis_name=db.Column(db.String(50))
    # occupation=db.Column(db.String(50))

class Trigr(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    t_id=db.Column(db.Integer)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.String(50))





# here we will pass endpoints and run the fuction
@app.route('/')
def index():
    return render_template('index.html')
    


@app.route('/visitors',methods=['POST','GET'])
def visitors():

    if request.method=="POST":

        email=request.form.get('email')
        vis_name=request.form.get('vis_name')
        occupation=request.form.get('occupation')

        # query=db.engine.execute(f"INSERT INTO `visitors` (`email`,`vis_name`,`occupation`) VALUES ('{email}','{vis_name}','{occupation}')")
        query=Visitors(email=email,vis_name=vis_name,occupation=occupation)
        db.session.add(query)
        db.session.commit()
        flash("Information is Stored","primary")

    return render_template('visitor.html')



@app.route('/tourist',methods=['POST','GET'])
@login_required
def tourist():
    # doct=db.engine.execute("SELECT * FROM `doctors`")
    doct=Visitors.query.all()

    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        location=request.form.get('location')
        time=request.form.get('time')
        date=request.form.get('date')
        occupation=request.form.get('occupation')
        number=request.form.get('number')
        # subject="Tourism MANAGEMENT SYSTEM"
        if len(number)<10 or len(number)>10:
            flash("Please give 10 digit number")
            return render_template('tourist.html',doct=doct)
  

        # query=db.engine.execute(f"INSERT INTO `patients` (`email`,`name`,	`gender`,`slot`,`location`,`time`,`date`,`occupation`,`number`) VALUES ('{email}','{name}','{gender}','{slot}','{location}','{time}','{date}','{occupation}','{number}')")
        query=Visitors(email=email,name=name,gender=gender,slot=slot,location=location,time=time,date=date,occupation=occupation,number=number)
        db.session.add(query)
        db.session.commit()
        
        # mail starts from here

        # mail.send_message(subject, sender=params['gmail-user'], recipients=[email],body=f"YOUR bOOKING IS CONFIRMED THANKS FOR CHOOSING US \nYour Entered Details are :\nName: {name}\nSlot: {slot}")



        flash("Booking Confirmed","info")


    return render_template('tourist.html',doct=doct)


@app.route('/bookings')
@login_required
def bookings(): 
    em=current_user.email
    if current_user.usertype=="Doctor":
        # query=db.engine.execute(f"SELECT * FROM `patients`")
        query=Tourist.query.all()
        return render_template('booking.html',query=query)
    else:
        # query=db.engine.execute(f"SELECT * FROM `patients` WHERE email='{em}'")
        query=Tourist.query.filter_by(email=em)
        print(query)
        return render_template('booking.html',query=query)
    


@app.route("/edit/<string:t_id>",methods=['POST','GET'])
@login_required
def edit(t_id):    
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        location=request.form.get('location')
        time=request.form.get('time')
        date=request.form.get('date')
        occupation=request.form.get('occupation')
        number=request.form.get('number')
        # db.engine.execute(f"UPDATE `tourist` SET `email` = '{email}', `name` = '{name}', `gender` = '{gender}', `slot` = '{slot}', `location` = '{location}', `time` = '{time}', `date` = '{date}', `occupation` = '{occupation}', `number` = '{number}' WHERE `tourist`.`t_id` = {t_id}")
        post=Tourist.query.filter_by(t_id=t_id).first()
        post.email=email
        post.name=name
        post.gender=gender
        post.slot=slot
        post.location=location
        post.time=time
        post.date=date
        post.occupation=occupation
        post.number=number
        db.session.commit()

        flash("Slot is Updates","success")
        return redirect('/bookings')
        
    posts=Tourist.query.filter_by(t_id=t_id).first()
    return render_template('edit.html',posts=posts)


@app.route("/delete/<string:t_id>",methods=['POST','GET'])
@login_required
def delete(t_id):
    # db.engine.execute(f"DELETE FROM `tourist` WHERE `tourist`.`t_id`={t_id}")
    query=Tourist.query.filter_by(t_id=t_id).first()
    db.session.delete(query)
    db.session.commit()
    flash("Slot Deleted Successful","danger")
    return redirect('/bookings')






@app.route('/signup',methods=['POST','GET'])
def signup():
    if request.method == "POST":
        username=request.form.get('username')
        usertype=request.form.get('usertype')
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()
        # encpassword=generate_password_hash(password)
        if user:
            flash("Email Already Exist","warning")
            return render_template('/signup.html')

        # new_user=db.engine.execute(f"INSERT INTO `user` (`username`,`usertype`,`email`,`password`) VALUES ('{username}','{usertype}','{email}','{encpassword}')")
        myquery=User(username=username,usertype=usertype,email=email,password=password)
        db.session.add(myquery)
        db.session.commit()
        flash("Signup Succes Please Login","success")
        return render_template('login.html')

          

    return render_template('signup.html')

@app.route('/login',methods=['POST','GET'])
def login():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()

        if user and user.password == password:
            login_user(user)
            flash("Login Success","primary")
            return redirect(url_for('index'))
        else:
            flash("invalid credentials","danger")
            return render_template('login.html')    





    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logout SuccessFul","warning")
    return redirect(url_for('login'))



@app.route('/booking')
def test():
    try:
        booking.query.all()
        return 'My database is Connected'
    except:
        return 'My db is not Connected'
    

@app.route('/details')
@login_required
def details():
    posts=Trigr.query.all()
    # posts=db.engine.execute("SELECT * FROM `trigr`")
    return render_template('trigers.html',posts=posts)


@app.route('/search',methods=['POST','GET'])
@login_required
def search():
    if request.method=="POST":
        query=request.form.get('search')
        occupation=Visitors.query.filter_by(occupation=query).first()
        name=Visitors.query.filter_by(vis_name=query).first()
        if name:

            flash("Place is Available","info")
        else:

            flash("Place is Not Available","danger")
    return render_template('index.html')






app.run(debug=True)    

