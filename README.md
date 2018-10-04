# api_index_url Yan Tadeu

## Sobre
Este projeto extrai informações de páginas web e as indexa para pesquisas.
As pesquisas retornam resultados no formato JSON, ordenados pela relevância com o termo pesquisado.  

A API foi desenhada utilizando um padrão de versionamento, permitindo que ela evolua sem quebras de interface.
Ex: para indexar uma página, atualmente é utilizado o endpoint `POST /api/v1/scrap`

Além disto, este projeto foi criado com um foco em performance.  
Ele não utiliza, por exemplo, middlewares para processamentos de view ou sessão, visto que APIs são stateless, ganhando um tempo de resposta melhor.  

Tecnologias utilizadas:
* Ruby + Rails
* Mongodb
* rspec para testes
* Gem utilizada para scrap das páginas: https://github.com/jaimeiniesta/metainspector
* Gem utilizada para Full text search no Mongodb com rails: https://github.com/mongoid/mongoid_fulltext


## Ambiente
* Ruby + Rails: https://gorails.com/setup/ (versão utilizado: 2.5.1)
* Mongodb: https://docs.mongodb.com/manual/administration/install-community/
    * Após a instalação, dar o start no mongo 
* curl (para testes, ou qualquer outro http client para executar requisições POST)

## Setup do projeto
Com o ambiente configurado acesse a pasta do projeto e instale as dependências:
````
cd /path/api_index_url

bundle install
````

Após a instalação terminar, inicie o servidor com:
````
rails server
````

## Endpoints
* Indexar páginas:

    ```
    POST /api/v1/scrap
    
    ```
    Parâmetros obrigatórios: `url | String`   
    Exemplos: (utilizar terminal para o POST)
    ```
    curl -d "url=https://github.com" -X POST http://localhost:3000/api/v1/scrap
    curl -d "url=https://www.globo.com" -X POST http://localhost:3000/api/v1/scrap
    curl -d "url=https://www.boredpanda.com" -X POST http://localhost:3000/api/v1/scrap
    curl -d "url=http://www.pdvend.com.br" -X POST http://localhost:3000/api/v1/scrap
    curl -d "url=https://www.ruby-lang.org" -X POST http://localhost:3000/api/v1/scrap
    ```
    

* Buscar nas páginas indexadas:
    ```
    GET  /api/v1/search
    
    ```
    Parâmetros obrigatórios: `q | String`  
    Exemplo:
    ```
    curl 'http://localhost:3000/api/v1/search?q=pdvend' 
    ```
    Para cada registro encontrado na busca são retornadas as seguintes informações, seguidas pelo valor 
    atribuído à relevância:  
    ```
    [
        {
            {
                _id: {
                $oid: "5bb592c8acd78d098b8c0d05"
                },
                canonicals: [],
                content: "texto extraido da página",
                created_at: "2018-10-04T04:10:55.494Z",
                description: "metatag description",
                head_links: [],
                host: "www.foo.bar",
                keywords: null,
                links: [],
                meta_tags: {},
                root_url: "https://www.foo.bar/",
                scheme: "https",
                stylesheets: [],
                title: "api_index_url",
                updated_at: "2018-10-04T04:16:49.276Z",
                url: "https://www.foo.bar/",
                url_scrap: "https://www.foo.bar/"
            },
            1.9361140387631275
        }
    ]
    ```
    
    
   
## Testes
Para executar os testes:
```
bundle exec rspec

........

Finished in 0.47899 seconds (files took 1.71 seconds to load)
8 examples, 0 failures
```