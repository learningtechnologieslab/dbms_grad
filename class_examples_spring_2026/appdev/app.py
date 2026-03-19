from flask import Flask
import uuid
import json
import pymysql

app = Flask(__name__)


@app.route("/")
def index():
    return "Hello World"

@app.route("/get_films/<film_id>")
def get_films(film_id):
    con = pymysql.connect(host='167.71.90.83',
                             user='testUser',
                             password='testUser123!',
                             db='sakila',
                             cursorclass=pymysql.cursors.DictCursor)
    data = []
    with con.cursor() as cur:
        if film_id == "all":
             qry = "SELECT * FROM film;"
        else:             
            qry = "SELECT * FROM film WHERE film_id = %s;"   
        #print(qry)
        cur.execute(qry, (film_id,))

        rows = cur.fetchall()

        for row in rows:
            film = {}
            film['film_id'] = row['film_id']
            film['title'] = row['title']
            film['description'] = row['description']
            #print(row['film_id'], row['title'], row['description'])
            data.append(film)

        
    return json.dumps(data)


@app.route("/search_films/<keyword>")
def search_films(keyword):
    con = pymysql.connect(host='167.71.90.83',
                             user='testUser',
                             password='testUser123!',
                             db='sakila',
                             cursorclass=pymysql.cursors.DictCursor)
    data = []
    with con.cursor() as cur:
        if keyword == "all":
             qry = "SELECT * FROM film;"
        else:             
            qry = "SELECT * FROM film WHERE title = %s;"   
        #print(qry)
        cur.execute(qry, (keyword,))

        rows = cur.fetchall()

        for row in rows:
            film = {}
            film['film_id'] = row['film_id']
            film['title'] = row['title']
            film['description'] = row['description']
            #print(row['film_id'], row['title'], row['description'])
            data.append(film)

        
    return json.dumps(data)

app.run(debug=True)

    