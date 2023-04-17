import uuid
import pymysql
import json
from markupsafe import escape
from flask import Flask
app = Flask(__name__)

'''
Banking application class list:
1. user
2. account
3. transaction

'''

class Bank:
    def __init__(self):
        self.__customers = []
        self.__accounts = []
        self.__populate_customers()

    def __populate_customers(self):
        try:
            config = Config()
            con = config.db_conn
            with con.cursor() as cur:
                qry = "SELECT * FROM user;"
                cur.execute(qry)
                rows = cur.fetchall()
                for row in rows:
                    user = User(row["user_id"], row["first_name"], row["last_name"])
                    self.__customers.append(user)
        finally:
            con.close()

    def get_customers(self):
        return self.__customers

class Config:
    def __init__(self):
        con_params = self.__read_config()
        self.db_conn = pymysql.connect(host=con_params["host"],
                             user=con_params["user"],
                             password=con_params["password"],
                             db=con_params["db"],
                             charset=con_params["charset"],
                             cursorclass=pymysql.cursors.DictCursor)
    def __read_config(self):
        try:
            f = open("config.txt")
            data = f.read()
            return dict(json.loads(data))
        finally:
            f.close()

class User:
    def __init__(self, user_id="", first_name = "", last_name = ""):
        self.__f_name = first_name
        self.__l_name = last_name
        if user_id == "":
            self.__user_id = str(uuid.uuid4())
            try: 
                config = Config()
                con = config.db_conn
                with con.cursor() as cur:
                    qry = 'INSERT INTO user (user_id, first_name, last_name)'
                    qry = qry + 'VALUES(%s, %s, %s)'
                    print(qry)
                    cur.execute(qry, (self.__user_id, self.__f_name, self.__l_name)) 
                    con.commit()
            finally:
                con.close()
        else:
            self.__user_id = user_id
            try:
                config = Config()
                con = config.db_conn
                with con.cursor() as cur:
                    qry = "SELECT * FROM user WHERE user_id = '" + user_id + "'"
                    print(qry)
                    cur.execute(qry)
                    rows = cur.fetchall()
                    for row in rows:
                        self.__user_id = row["user_id"]
                        self.__f_name = row["first_name"]
                        self.__l_name = row["last_name"]
            finally:
                con.close()
        self.__accounts = []

    def get_first_name(self):
        return self.__f_name
    
    def get_last_name(self):
        return self.__l_name
    
    def get_user_id(self):
        return self.__user_id

    def set_first_name(self, first_name):
        self.__f_name = first_name
        try: 
            config = Config()
            con = config.db_conn
            with con.cursor() as cur:
                qry = 'UPDATE user SET first_name = %s WHERE user_id = %s;'
                print(qry)
                cur.execute(qry, (self.__f_name, self.__user_id)) 
                con.commit()
        finally:
            con.close()
    
    def set_last_name(self, last_name):
        self.__l_name = last_name
        try: 
            config = Config()
            con = config.db_conn
            with con.cursor() as cur:
                qry = 'UPDATE user SET last_name = %s WHERE user_id = %s;'
                print(qry)
                cur.execute(qry, (self.__l_name, self.__user_id)) 
                con.commit()
        finally:
            con.close()

    def add_account(self, account_id):
        self.__accounts.append(account_id)


class Account:
    def __init__(self, account_id=""):
        self.__balance = 0
        self.__owners = []
        self.__transactions = []

        if account_id != "":
            self.__account_id = account_id
            
            try:
                config = Config()
                con = config.db_conn
                with con.cursor() as cur:
                    qry = "SELECT * FROM account WHERE account_id = '" + account_id + "'"
                    print(qry)
                    cur.execute(qry)
                    rows = cur.fetchall()
                    for row in rows:
                        self.__account_id = row["account_id"]
                        self.__balance = row["balance"]
            finally:
                con.close()
        else:
            self.__account_id = str(uuid.uuid4())
            try: 
                config = Config()
                con = config.db_conn
                with con.cursor() as cur:
                    qry = 'INSERT INTO account (account_id, balance)'
                    qry = qry + 'VALUES(%s, 0)'
                    print(qry)
                    cur.execute(qry, (self.__account_id)) 
                    con.commit()
            finally:
                con.close()
    
    def get_account_id(self):
        return self.__account_id

    def get_balance(self):
        return self.__balance
    
    def add_owner(self, user_id):
        self.__owners.append(user_id)

    def deposit(self, amount):
        self.__balance += amount
        tr = Transaction(amount, "deposit", self.__account_id)
        self.__transactions.append(tr)
        self.__update_balance()

    def withdraw(self, amount):
        self.__balance -= amount
        tr = Transaction(amount, "withdrawal", self.__account_id)
        self.__transactions.append(tr)
        self.__update_balance()


    def __update_balance(self):
        try: 
            config = Config()
            con = config.db_conn
            with con.cursor() as cur:
                qry = 'UPDATE account SET balance = %s'
                print(qry)
                cur.execute(qry, (self.__balance)) 
                con.commit()
        finally:
            con.close()

    def to_json(self):
        fields_data = {
            "id" : self.__account_id,
            "balance" : self.__balance,
            "transactions" : []
        }
        for t in self.__transactions:
            fields_data["transactions"].append(t.__dict__)

        return json.dumps(fields_data)

class Transaction:
    def __init__(self, amount = 0, tr_type = "", orig_acct = "", dest_account="", transaction_id=""):
        self.__amount = amount
        self.__tr_type = tr_type
        self.__orig_acct = orig_acct
        self.__dest_account = dest_account
        self.__transaction_id = str(uuid.uuid4())

        if transaction_id != "":
            self.__transaction_id = transaction_id
            
            try:
                config = Config()
                con = config.db_conn
                with con.cursor() as cur:
                    qry = "SELECT * FROM transaction WHERE transaction_id = '" + transaction_id + "'"
                    print(qry)
                    cur.execute(qry)
                    rows = cur.fetchall()
                    for row in rows:
                        self.__transaction_id = row["transaction_id"]
                        self.__amount = row["amount"]
                        self.__tr_type = row["transaction_type"]
                        self.__orig_acct = row["fk_orig_account"]
                        self.__dest_account = row["fk_dest_account"]
            finally:
                con.close()
        else:
            self.__account_id = str(uuid.uuid4())
            try: 
                config = Config()
                con = config.db_conn
                with con.cursor() as cur:
                    if self.__dest_account != "":
                        qry = 'INSERT INTO transaction (transaction_id, transaction_type, amount, fk_orig_account, fk_dest_account)'
                        qry = qry + 'VALUES(%s, %s, %s, %s, %s)'
                        print(qry)
                        cur.execute(qry, (self.__transaction_id, self.__tr_type, self.__amount, self.__orig_acct, self.__dest_account)) 
                    else:
                        qry = 'INSERT INTO transaction (transaction_id, transaction_type, amount, fk_orig_account)'
                        qry = qry + 'VALUES(%s, %s, %s, %s)'
                        print(qry)
                        cur.execute(qry, (self.__transaction_id, self.__tr_type, self.__amount, self.__orig_acct)) 
                    con.commit()
            finally:
                con.close()

    def get_amount(self):
        return self.__amount

    def to_json(self):
        return json.dumps(self.__dict__)


##t = Transaction(transaction_id = "fd5085f9-cfb0-490a-b7b5-ab4a89adeda7")
##print(t.to_json())

@app.route('/')
def index():
    
    a = Account("ce4d2071-9934-44fe-a22a-d73feca1e95c")
    a.withdraw(1000)
    a.deposit(100000)
    a.deposit(10)
    a.deposit(1000)
    a.deposit(1500)
    a.withdraw(3000)

    return a.to_json()

