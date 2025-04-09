from sqlalchemy import create_engine
import pymysql
pymysql.install_as_MySQLdb()
import pandas as pd
from datetime import datetime
import time 

def dbconnect():
    engine = create_engine("mysql+pymysql://root:1234@localhost:3306/naver_book")
    conn = engine.connect()
    return conn


def to_book_db(keyword, df):



    conn = dbconnect()
    time.sleep(1)
    df.to_sql(f'{keyword}_book_info', con=conn, if_exists="append", index=False)
    conn.close()
    