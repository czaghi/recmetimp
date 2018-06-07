# recmetimp
Trabalho de Conclusão de Curso - Recomendação de técnicas para imputação de valores usando
aprendizado de máquina

## Como usar

### Modo de análise:

Insira um conjunto de dados sem valores ausentes no formato `.arff` no diretório `datasets/original` e depois execute o comando `./run.sh analysis`. Os gráficos gerados para a análise estão no diretório `plot`.


### Modo de recomendação:

Insira um conjunto de dados contendo valores ausentes no formato `.arff` no diretório `datasets/original` e depois execute o comando `./run.sh recommendation`.
As bases imputadas estão no diretório `datasets/imputed/user`, e o gráfico dos resultados em `plot`.