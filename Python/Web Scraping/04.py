import requests
from bs4 import BeautifulSoup
import pandas as pd

list_news = []

url = requests.get('https://g1.globo.com/')
content = url.content

url_main = BeautifulSoup(content, 'html.parser')
# print(type(url_main))
# print(url_main.prettify())

news_alls = url_main.findAll("div", attrs={'class': 'feed-post-body'})
print(news_alls)

for new in news_alls:
    title = new.find("a", attrs={'class': 'feed-post-link'})
    title_text = title.text
    # print(title_text)
    # print(title['href'])

    subtitle = new.find("a", attrs={'class': 'feed-post-body-title'})
    if subtitle:
        # print(subtitle.text)
        list_news.append([title.text, subtitle.text, title['href']])
    else:
        list_news.append([title.text, "", title['href']])

print(list_news)

news = pd.DataFrame(list_news, columns=['title', 'subtitle', 'link'])
news.to_excel('E:\\backup_8112020\\Just for Fun\\Python\\Web Scraping\\news_g1.xlsx', index=False)
