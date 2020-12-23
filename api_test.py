# followed tutorial at https://blog.cloudoki.com/getting-started-with-restful-apis-using-the-flask-microframework-for-python/

from flask import Flask,jsonify, request, Response
import configparser, pymysql, json
from flask_sqlalchemy import SQLAlchemy

# from mysql.connector import MySQLConnection

# workaround because mysqldb is only good for python 2
pymysql.install_as_MySQLdb()

application = Flask(__name__)

# Read config file
config = configparser.ConfigParser()
config.read('dbconnection.conf')

# MySQL configurations
application.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://' + config.get('DB', 'user') + \
                                     ':' + config.get('DB', 'password') + '@' + \
                                     config.get('DB', 'host') + '/' + config.get('DB', 'db')

application.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

mysql = SQLAlchemy()
mysql.init_app(application)

# Create model for park entity
class Park(mysql.Model):
    __tablename__ = 'park'
    park_id = mysql.Column(mysql.Integer, primary_key = True)
    park_name = mysql.Column(mysql.String(50), nullable=False)
    phone = mysql.Column(mysql.String(13), nullable=False)
    description = mysql.Column(mysql.String(250), nullable=True)

    def __init__(self, name, phone):
        self.park_name = name
        self.phone = phone

    def __repr__(self):
        return '<Park (%s, %s) >' (self.park_name, self.description)

# Create model for trail entity
class Trail(mysql.Model):
    __tablename__ = 'trail'
    trail_id = mysql.Column(mysql.Integer, primary_key = True)
    park_id = mysql.Column(mysql.Integer, mysql.ForeignKey('park.park_id'), nullable=False)
    station_id = mysql.Column(mysql.Integer, mysql.ForeignKey('station.station_id'), nullable=False)
    trail = mysql.Column(mysql.String(50), nullable=True)
    distance_miles = mysql.Column(mysql.Float, nullable=True)
    difficulty  = mysql.Column(mysql.String(10), nullable=False)
    route_type   = mysql.Column(mysql.String(25), nullable=False)
    elevation_gain = mysql.Column(mysql.Integer, nullable = False)
    is_trailhead   = mysql.Column(mysql.String(5), nullable=False)
    date_open = mysql.Column(mysql.Date, nullable=False)
    date_close = mysql.Column(mysql.Date, nullable=False)
    bathrooms   = mysql.Column(mysql.String(5), nullable=False)
    dogs_allow   = mysql.Column(mysql.String(5), nullable=False)
    start_lat   = mysql.Column(mysql.Float, nullable=False)
    start_lon = mysql.Column(mysql.Float, nullable=False)
    end_lat = mysql.Column(mysql.Float, nullable=False)
    end_lon = mysql.Column(mysql.Float, nullable=False)
    permit_required = mysql.Column(mysql.String(5), nullable=True)
    description = mysql.Column(mysql.String(1000), nullable=True)

    #def __init__(self):

    def __repr__(self):
        return '<Trail (%s, %s) >' (self.trail, self.description)

#Class model for spotting entity
class Spotting(mysql.Model):
    __tablename__ = 'spotting'
    spotting_id = mysql.Column(mysql.Integer, primary_key = True)
    animal_id = mysql.Column(mysql.Integer, mysql.ForeignKey('animal.animal_id'), nullable=False)
    user_id = mysql.Column(mysql.Integer, mysql.ForeignKey('user.user_id'), nullable=False)
    trail_id = mysql.Column(mysql.Integer, mysql.ForeignKey('trail.trail_id'), nullable=False)
    quantity = mysql.Column(mysql.Integer, nullable = False)
    lat = mysql.Column(mysql.Float, nullable=True)
    lon = mysql.Column(mysql.Float, nullable=True)
    description = mysql.Column(mysql.String(250), nullable=False)

    def __repr__(self):
      return '<Spotting (%s, %s) >' % (self.spitting_id, self.description)


@application.route("/")
def hello():
    return "Hello National Parks!"

#Return all parks - test simple API on one table
@application.route('/parks', methods=['GET'])
def getPark():
    data = Park.query.all() #fetch all products on the table
    data_all = []
    for park in data:
        data_all.append([park.park_name, park.description]) # prepare visual data
    return jsonify(parks=data_all),{'Content-Type':'application/json'}

#Return all trails - test simple API on one table
@application.route('/trails', methods=['GET'])
def getTrail():
    data = Trail.query.all() #fetch all products on the table
    data_all = []
    for trail in data:
        data_all.append([trail.trail, trail.description]) # prepare visual data
    return jsonify(trails=data_all),{'Content-Type':'application/json'}


#Return trail permit warning for a single trail - simple stored procedure call via API
# http://127.0.0.1:5000/permits?trail=...
@application.route('/permits', methods=['GET'])
def getPermitNeeded():
    trail = request.args.get('trail')
    proc_call = "call trailmessage_permit('" + trail + "')"
    result = mysql.engine.execute(proc_call)
    dict_Temp = {}
    for items in result:
        dict_Temp["message"] = items[0]
    value = json.dumps(dict_Temp)
    return Response(value,mimetype='application/json')

#Find a Hike
@application.route('/hike', methods=['GET'])
def findHike():
    park = request.args.get('park')
    level = request.args.get('level') #('Easy', 'Moderate', 'Hard')
    min = request.args.get('min')
    max = request.args.get('max')
    bath= request.args.get('bath')
    dog= request.args.get('dog')
    feat= request.args.get('feat')
    proc_call = "call find_hike('" + park + "','" + level + "','" + min + "','" + max + "','" \
                + bath + "','" + dog + "','" + feat+ "')"
    print(proc_call)
    result = mysql.engine.execute(proc_call)
    data_all = []
    for item in result:
        data_all.append([item['trail name'], str(item['distance in miles']), item['description'],
                         str(item['average user rating']), item['messages']])
    return jsonify(trails=data_all),{'Content-Type':'application/json'}

#Post method
@application.route('/spotting', methods=['POST'])
def postSpotting():
    animal = request.args.get('animal')
    user = request.args.get('user')
    trail = request.args.get('trail')
    quantity = request.args.get('quantity')
    lat = request.args.get('lat')
    lon = request.args.get('lon')
    desc = request.args.get('desc')
    proc_call = "call add_spotting('" + animal + "','"+ user + "','" + trail + \
                "','" + quantity + "','" + lat + "','" + lon + "','" + desc + "')"
    mysql.session.execute(proc_call)
    mysql.session.commit()

    return ('The '+ animal + ' spotting was successfully reported!\
    Please remember to excercise caution when dealing with wildlife - NPS is not liable for your actions.')

#Find a Better Hike
@application.route('/betterhike', methods=['GET'])
def findBetterHike():
    park = request.args.get('park')
    level = request.args.get('level') #('Easy', 'Moderate', 'Hard')
    min = request.args.get('min')
    max = request.args.get('max')
    bath= request.args.get('bath')
    dog= request.args.get('dog')
    feat1= request.args.get('feat1')
    feat2= request.args.get('feat2')
    feat3= request.args.get('feat3')
    feat4= request.args.get('feat4')
    feat5= request.args.get('feat5')
    proc_call = "call find_better_hike('" + park + "','" + level + "','" + min + "','" + max + "','" + bath + "','" \
                + dog + "','" + feat1 + "','" + feat2 + "','" + feat3 + "','" + feat4 + "','" + feat5 + "')"
    print(proc_call)
    result = mysql.engine.execute(proc_call)
    data_all = []
    for item in result:
        data_all.append([item['trail name'], str(item['distance in miles']), item['description'],
                         str(item['average user rating']), item['features'], item['messages']])
    return jsonify(trails=data_all),{'Content-Type':'application/json'}

#Find a Better Hike with None Options
@application.route('/besthike', methods=['GET'])
def findBestHike():
    park = request.args.get('park')
    level = request.args.get('level') #('Easy', 'Moderate', 'Hard')
    min = request.args.get('min')
    max = request.args.get('max')
    bath= request.args.get('bath')
    dog= request.args.get('dog')
    feat1= request.args.get('feat1')
    feat2= request.args.get('feat2')
    feat3= request.args.get('feat3')
    feat4= request.args.get('feat4')
    feat5= request.args.get('feat5')
    proc_call = "call find_best_hike('" + park + "','" + level + "','" + min + "','" + max + "','" + bath + "','" \
                + dog + "','" + feat1 + "','" + feat2 + "','" + feat3 + "','" + feat4 + "','" + feat5 + "')"
    print(proc_call)
    result = mysql.engine.execute(proc_call)
    data_all = []
    for item in result:
        data_all.append([item['trail name'], str(item['distance in miles']), item['description'],
                         str(item['average user rating']), item['features'], item['messages']])
    return jsonify(trails=data_all),{'Content-Type':'application/json'}


if __name__ == "__main__":
    application.run()