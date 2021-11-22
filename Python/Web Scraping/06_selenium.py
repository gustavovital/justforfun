# Modules
from selenium import webdriver
from selenium.webdriver.common.by import By
from time import sleep

# selenium
driver = webdriver.Chrome()

driver.get('https://www.walissonsilva.com/blog')

element = driver.find_element(By.TAG_NAME, 'input')
element.send_keys('data')