# Remove followers that don't follow you back
# @guga.vital
# 28-12/2021

# Modules
import instaloader
import numpy as np
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from time import sleep

# Options for Selenium
options = Options()
options.add_argument('--headless')

# User and password
username = input('User: ')  # User
password = input('Password: ')  # Passwd

# instaloader
L = instaloader.Instaloader()  # Initializing Instaloader
L.login(username, password)   # Login
profile = instaloader.Profile.from_username(L.context, username)  # Get info

followers = []  # Create an empty list for followers
following = []  # Create an empty list for following
exceptions = ['laurajanegrace']

for user in profile.get_followers():
    followers.append(user.username)  # Fill the followers list

for follow in profile.get_followees():
    following.append(follow.username)  # Fill the following list

unfollow_list = np.setdiff1d(following, followers)  # Who doesn't follow you back...

# Initializing Selenium
url_main = 'https://www.instagram.com/'  # Main URL (instagram)

driver = webdriver.Chrome(options=options)  # Validate options
driver.get(url_main)

sleep(5)  # All the 'sleep' commands just for load the page
driver.find_element(By.XPATH, "//button[@tabindex='0']").click()
sleep(1)
driver.find_element(By.XPATH, "//input[@name='username']").send_keys(username)  # Enter user
driver.find_element(By.XPATH, "//input[@name='password']").send_keys(password)  # Enter passwd
sleep(1)
driver.find_element(By.XPATH, "//button[@type='submit']").click()  # Login

for mf in unfollow_list:
    if mf in exceptions:  # Cause you are not Laura
        continue
    else:
        sleep(2)
        driver.get(f"{url_main}{mf}")
        sleep(1)
        driver.find_element(By.XPATH, "//span[@aria-label='Seguindo']").click()
        sleep(1)
        driver.find_element(By.XPATH, "//button[@tabindex='0']").click()  # UNFOLLOW

driver.quit()
