import instaloader
import numpy as np
from selenium import webdriver
from selenium.webdriver.common.by import By
from time import sleep
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


L = instaloader.Instaloader()


username = ''
password = ''

L.login(username, password)  # (login)

profile = instaloader.Profile.from_username(L.context, username)

followers = []
following = []


for user in profile.get_followers():
    followers.append(user.username)

for follow in profile.get_followees():
    following.append(follow.username)

unfollow_list = np.setdiff1d(following, followers)

# Initializing Selenium

driver = webdriver.Chrome()
driver.get('https://www.instagram.com/')

sleep(5)
driver.find_element(By.XPATH, "//button[@tabindex='0']").click()
sleep(1)
driver.find_element(By.XPATH, "//input[@name='username']").send_keys(username)
driver.find_element(By.XPATH, "//input[@name='password']").send_keys(password)
sleep(1)
driver.find_element(By.XPATH, "//button[@type='submit']").click()
# driver.find_element(By.XPATH, "//button[@type='submit']").click()


# [@name='username']
