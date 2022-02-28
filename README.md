# Youtube Video Data

Imprime dados de um determinado vídeo do youtube e do canal em que foi postado pela URL do vídeo

- Salve o arquivo youtube.sh
- Torne o arquivo executável
```sh
chmod +x youtube.sh
```
- Execute o script fornecendo a URL do vídeo 

```sh
./youtube.sh "https:youtube.com/watch?v=M62UCZD2uRU"

# Caso encontre problemas na execução acima, tente desta forma
bash ./youtube.sh "https:youtube.com/watch?v=M62UCZD2uRU"
```
- A saída será similar a esta:
```
Canal: Thiago Leite
Inscritos: 4 inscritos

Vídeo: Gol na Final do Interclasses 2018 na Etec Jorge Street
Visualizações: 87
Likes: 5 
Data de publicação: 25 de mai. de 2020
```
