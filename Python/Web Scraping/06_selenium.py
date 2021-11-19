# Modules
from selenium import webdriver
from selenium.webdriver.common.by import By
from time import sleep

# selenium
driver = webdriver.Chrome()

driver.get('https://www.walissonsilva.com/blog')
# sleep(3)

element = driver.find_element(By.TAG_NAME, 'input')
# print(element)
element.send_keys('data')