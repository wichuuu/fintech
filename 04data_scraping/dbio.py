from sqlalchemy import create_engine
import pymysql
pymysql.install_as_MySQLdb()
import pandas as pd
from datetime import datetime

def year_month():
    today = datetime.today()
    return today.year, today.month

def dbconnect():
    engine = create_engine("mysql+pymysql://root:1234@localhost:3306/stock_info")
    conn = engine.connect()
    return conn

def stock_codes():
    conn = dbconnect()
    data = pd.read_sql('stock_company_info_2025_04_05', con=conn)
    conn.close()
    stock_code = data['종목코드'].apply(lambda x: x+"0")
    return stock_code

def to_stock_db(idx, stock_code, stock_name, df):
    year, month = year_month()
    conn = dbconnect()
    df.to_sql(f'stock_price_{year}_{month:02d}', con=conn, if_exists="append", index=False)
    conn.close()
    print(f'{idx+1}/{len(stock_code)} {stock_name}DB 저장 완료', end="\r")