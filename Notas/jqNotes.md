# JQ (O que a sigla significa?)

Apenas um lembrete de que, apesar de os comandos estarem objetivamente definidos, não se esqueça de que é possível combina-los em pipelines para criar novos arquivos, variáveis, aplicar em scripts e etc...

## Comandos de invocação
```
jq -r                                         # Faz a impressão sem aspas;
jq -r 'keys[]' file.json                      # Imprime todas as chaves do arquivo json
jq -r '.key1' | keys[]' file.json             # Imprime todas as subchaves de uma chave
                                              # É diferente de chamar apenas a chave;


jq '.' file.json                              # Printa todo o arquivo no terminal devidamente identado

```
## Identificação dos objetos

Semelhante ao JavaScript.

```
jq '.key1' file.json
jq '.key2' file.json
jq '.key.subkey.subsubkey
```

## Arrays

Semelhante com python.

```
echo $array | jq '.[3]'                       # Acesso é feito através de índices
echo $array | jq '.[1:3]'                     # Podemos fazer slices
echo $array | jq '.[2:]                       # Do índice 2 em diante
echo $array | jq '.[-2]'                      # Acessar de forma inversa com índices negativos
echo $array | jq '.[:-2]'                     # Tudo até penultimo elemento
jq '.key[].subkey[2]'                         # Acessando Array de outros arrays(?)
```
### Arrays Constructors

```
echo '""' | jq '1,2'                          # Imprime os números 1 e 2 em cada linha
echo '""' | jq '[1,2]'                        # Imprime uma lista com um elemento em cada linha

# Isso parece inútil, mas é interessante para criar listas com elementos dos dicionários (objetos JSON)
# sem que seja preciso criar loops ou declarar uma lista, o que é bem interessante já que a forma que o bash
# trata essa estrutura é complicada. Teoricamente não existe listas em bash(será?), tudo é string.

echo $arrayDicts | jq '.[].employers.name'       # Eu tenho um array contendo diversos dicts, cada um contendo
                                                 # Diversas informações sobre os funcionários

# No caso, estou por cada dict no array e imprimindo o valor correspondente a chave 'name'. Porém isso apenas iria imprimir
# o nome de cada funcionário em cada linha, pelo outro método podemos obter um array com as informações que queremos.

echo $arrayDicts | jq '[.[].employers.name']
```

## Object Constructors
Construir dicionários, arquivos na estrutura JSON

```
echo '["Raphael", "Cardoso", "Almeida"]' | jq -r '.[0], .[2]' # Conseguimos desta forma acessar os dados em arrays
# Agora se quisermos salvar como um objeto, um dict;

echo '["Raphael", "Cardoso", "Almeida"]' | jq -r '{"first_name" : .[0], "last_name" : .[2]}'
# Construindo assim facilmente um dict durante os processos
```

Agora por exemplo, nos encontramos na situação querer construir um objeto e então fazemos:

```
curl "https://apiurl.com/data" | jq '[{title:.[].title, number:.[].number}]'

# Apesar de funcionar, podemos reduzir a sintaxe para

curl "https://apiurl.com/data" | jq '[ .[] | {title, number} ]'

# Generelizando a sintaxe

jq '{"key1": <<jq filter>>, "key2": <<jq filter>>}'
jq '{"key1", "key2"}'
```

## Sorting and Counting

```
jq 'sort'                  # Organiza um array. Numérico ou string
jq 'sort_by(.label)'       # Organiza de acordo com os valores da coluna passada
jq 'reverse'               # Organiza o array de forma reversa
jq 'length'                # Exibe o tamanho da estrutura de dados

# Uma coisa interessante é que podemos fazer piping dentro das strings. E isso é uma funcionalidade implementada no jq
# pois isso não é possivel com o bash.

echo {"key":var} | jq '.name' |  jq  'length'
echo {"key":var} | jq '.title | length'
```

## Maps and Selects

```
curl "https://apiurl.com" | \
jq '[.[] | {title, number, labels_count: .labels | length, title_length: .title | length}]'

# Isso seria equivalente à fazer isso:
curl "https://apiurl.com" | \
jq 'map({title, number, labels_count: .labels | length, title_length: .title | length } ]'

# O select é interessante para filtrar. Muito semelhante a aplicar mascaras em pandas.
curl "https://apiurl.com" | \
jq 'map({title, number, labels_count: .labels | length, title_length: .title | length } ] |
map(select(.title_length > 30))'
```

## Fontes
Link Youtube
Link Documentação jq


