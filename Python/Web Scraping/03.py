import requests
from bs4 import BeautifulSoup

url = requests.get('https://g1.globo.com/')
content = url.content

url_main = BeautifulSoup(content, 'html.parser')
# print(type(url_main))
print(url_main.prettify())

news = url_main.find("div", attrs={'class':'feed-post-body'})
# print(news.prettify())
title = news.find("a", attrs={'class':'feed-post-link'})
title_text = title.text
print(title_text)