import requests
from bs4 import BeautifulSoup
import re
import pandas as pd
import math

from sqlalchemy import create_engine

url = 'https://www.belezanaweb.com.br/cabelos/kits-de-tratamento/crespos/'

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                  '(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'
}

# Função para fazer a solicitação com retries e timeout
def get_site_content(url, headers, retries=3, timeout=5):
    for _ in range(retries):
        try:
            response = requests.get(url, headers=headers, timeout=timeout)
            response.raise_for_status()  # Raise HTTPError for bad responses
            return response.content
        except (requests.exceptions.HTTPError, requests.exceptions.ConnectionError, requests.exceptions.Timeout) as e:
            print(f"Erro na solicitação: {e}. Tentando novamente...")

    return None

site_content = get_site_content(url, headers)
engine = create_engine('mysql+mysqlconnector://root:admin@localhost/appmobile', echo=False)

if site_content:
    soup = BeautifulSoup(site_content, 'html.parser')

    # Extraindo a quantidade total de itens
    pagination_total = soup.find('p', class_='pagination-total')
    if pagination_total:
        qtd_itens = int(re.search(r'\d+', pagination_total.get_text().strip()).group())
        ultima_pagina = math.ceil(qtd_itens / 36)
    else:
        print("Não foi possível encontrar a quantidade total de itens.")
        qtd_itens = 0
        ultima_pagina = 0

    dic_produtos = {'marca': [], 'nome': [], 'preco': [], 'descricao': []}

    for i in range(1, ultima_pagina + 1):
        url_pag = f'https://www.belezanaweb.com.br/cabelos/kits-de-tratamento/crespos/?page_number={i}'
        site = get_site_content(url_pag, headers)
        if site:
            soup = BeautifulSoup(site, 'html.parser')
            produtos = soup.find_all('div', class_=re.compile('js-event-product-click'))

            for produto in produtos:
                marca = produto.find('span', class_=re.compile('showcase-item-brand')).get_text().strip()
                nome = produto.find('a', class_=re.compile('showcase-item-title')).get_text().strip()
                preco = produto.find('span', class_=re.compile('price-value')).get_text().strip()
                descricao = produto.find('p', class_=re.compile('showcase-item-description')).get_text().strip()

                print(marca, nome, descricao, preco)

                dic_produtos['marca'].append(marca)
                dic_produtos['nome'].append(nome)
                dic_produtos['preco'].append(preco)
                dic_produtos['descricao'].append(descricao)

            print(url_pag)
        else:
            print(f"Não foi possível obter o conteúdo da página {i}.")

    # Criar DataFrame pandas
    df = pd.DataFrame(dic_produtos)

    # Inserir dados na tabela 'CACHEADO_SECO'
    try:
        df.to_sql(name='CACHEADO_SECO', con=engine, if_exists='append', index=False)
        print("Dados inseridos na tabela 'CACHEADO_SECO' do banco de dados MySQL.")
    except Exception as e:
        print(f"Erro ao inserir dados no banco de dados: {e}")
else:
    print("Não foi possível obter o conteúdo do site após várias tentativas.")