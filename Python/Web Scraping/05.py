# Modules
import requests
from bs4 import BeautifulSoup
import pandas as pd

# lista
prod_list =[]
# getting the URL
url_base = 'https://lista.mercadolivre.com.br/'
product = 'iphone 11'

response = requests.get(url_base + product)
# print(response.text)

# Using BS
site = BeautifulSoup(response.text, 'html.parser')

product_all = site.findAll('div', attrs={'class': 'andes-card andes-card--flat andes-card--default ui-search-result ui-search-result--core andes-card--padding-default'})
# print(product_info.prettify())

# product title
prod_title_class = product_all.find('div', attrs={'class': 'ui-search-item__group ui-search-item__group--title'})
# product href
prod_href = prod_title_class.find('a', attrs={'class': 'ui-search-item__group__element ui-search-link'})['href']

# preço: base 'product_all
prod_price_class = product_all.find('div', attrs={'class': 'ui-search-result__content-columns'})
prod_price = prod_price_class.find('span', attrs={'class': 'price-tag-fraction'})

for item in product_all:
    prod_title_class = item.find('div', attrs={'class': 'ui-search-item__group ui-search-item__group--title'})
    prod_href = prod_title_class.find('a', attrs={'class': 'ui-search-item__group__element ui-search-link'})['href']
    prod_price_class = item.find('div', attrs={'class': 'ui-search-result__content-columns'})
    prod_price = prod_price_class.find('span', attrs={'class': 'price-tag-fraction'})

    prod_list.append([prod_title_class.text, prod_price.text, prod_href])

df = pd.DataFrame(prod_list, columns=['Produto', 'Preço', 'Link'])
df.head()

# for prod in product_all:
#     print(prod)
#     print()