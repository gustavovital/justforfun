import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from time import sleep

# script
options = Options()
options.add_argument('window-size=400,800')
# options.add_argument('--headless')

driver = webdriver.Chrome(options=options)
driver.get('https://www.airbnb.com')
# sleep(2)

# print(driver.page_source)
main_bs4 = BeautifulSoup(driver.page_source, 'html.parser')

print(main_bs4.prettify())