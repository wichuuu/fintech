from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
# import time
# import pandas as pd
# from sqlalchemy import create_engine, text
# import pymysql
# from datetime import datetime
# pymysql.install_as_MySQLdb()


options = Options()
options.add_experimental_option("detach", True)
# options.add_argument("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36")
options.add_argument("start-maximized")
options.add_argument("Chrome/134.0.0.0")
options.add_argument("lang=ko_KR")

driver = webdriver.Chrome(
    service=Service(ChromeDriverManager().install()),
    options=options
    )

def kor2eng(keyword):
# keyword = input("검색할 내용을 입력하세요 : ")
# eng_keyword = kor2eng(keyword)

    options = Options()
    options.add_experimental_option("detach", True)
    # options.add_argument("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36")
    options.add_argument("start-maximized")
    options.add_argument("Chrome/134.0.0.0")
    options.add_argument("lang=ko_KR")
    options.add_argument("--headless")
    options.add_agrument("--no-sandbox")

    driver = webdriver.Chrome(
        service=Service(ChromeDriverManager().install()),
        options=options
        )


    url = ("https://translate.google.co.kr/?hl=ko&tab=TT&sl=en&tl=ko&op=translate")
    driver.get(url)


    wait = WebDriverWait(driver, 10)
    kor_text_box = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div < textarea")
    kor_text_box.send_keys(keyword)
    kor_text_box.send_keys(keys.ENTER)
    translated_box = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "div.IRu31 span.ryNqvb")))
    # print(translated_box.text)
    return translated_box.text