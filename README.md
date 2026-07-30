# Teste de Topologia para Checar o Monofiletismo a Nível de Gênero

Este repositório contém um arquivo em formato Newick (pasta `data/raw`) e um 
script em R que introduz o usuário à manipulação inicial de uma topologia 
filogenética, permitindo visualizar gêneros monofiléticos e identificar 
ocorrências de parafiletismo.
## Arquivos

- **`Figtree.tree`**: árvore filogenética em formato Newick, usada como 
  exemplo de um grupo de aves.
- **`01_c_Monophyletic_Genus.R`**: script em R para realizar a análise 
  de topologia.

### Convenção de nomenclatura do script
O prefixo do nome segue o padrão `NN_X_Descrição`:
- `01`: número sequencial do script (primeiro da série)
- `c`: etapa do processo — *collapsing/cleaning topology* (colapsar/limpar a topologia)

## Dependências

Este script utiliza as seguintes bibliotecas do R:

```r
install.packages(c("ape", "phytools", "ggtree"))
```

- **`ape`**: leitura e manipulação de árvores filogenéticas em formato Newick.
- **`phytools`**: funções auxiliares para análise e visualização de topologias.
- **`ggtree`**: visualização gráfica da árvore, incluindo destaque de clados monofiléticos/parafiléticos.

## Como usar

1. Clone este repositório.
2. Abra o script `01_c_Monophyletic_Genus.R` no RStudio (ou outro ambiente R de sua preferência).
3. Certifique-se de que o arquivo `Figtree.tree` está na pasta `data/raw`.
4. Execute o script linha por linha ou de uma vez (`source("01_c_Monophyletic_Genus.R")`).
5. O script irá gerar uma visualização da árvore com os gêneros monofiléticos destacados, além de um relatório indicando quais gêneros apresentam parafiletismo.

# Análise de gêneros monofiléticos com MonoPhy

```{r}
library(here)
library(MonoPhy)
```

## 1. Carregar árvore e escolher grupo externo para ser enraizado

```{r}
tr <- read.tree(file = here("data/raw","FigTree.tre"))
tr <- root(tr, outgroup = c("Struthio_camelus"), resolve.root = TRUE)
```

## 2. Avaliação de monofiletismo (nível de gênero)

```{r}
solution0 <- AssessMonophyly(tr) 
```

## 3. Extração de informações suplementares

### 3.1 Status de monofilia, Nó, espécies parafiléticas (Outliers/de fora ou Intruders/Intruso - de acordo com a taxonomia), entre outras informações padrões

```{r}
GenusLevelTable<-data.frame(GetResultMonophyly(solution0))
colnames(GenusLevelTable) <- c('Monophyly','MRCA','Tips','DeltaTips','Intruders','Intruders','Outliers','Outliers')
```

## 4. Armazenamento dos dados em uma tabela

```{r}
write.csv(x = GenusLevelTable, file = "GenusLevelTable.csv")
```

## 5. Plotagem da árvore filogenetica com o monofiletismo à nível de gênero colapsado (PDF)

### 5.1 Criação de um arquivo em pdf em branco

```{r}
#| warning: false
pdffn = "Strisores_Monophyly_Genus_LVL.pdf"
pdf(pdffn, width=35, height=75)
```

### 5.2 Armazenamento e plotagem da árvore comparada

#### 5.2.1 Monofiletismo evidenciado e táxons intrusos destacados

```{r}
#| warning: false
tr$node.label <- NULL
PlotMonophyly(solution0, tr,main="Monophyly Strisores",plot.type='monophyly',monocoll = TRUE, tax.colour='black',, ladderize=TRUE, cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
```

#### 5.2.2 Coloração por gêneros

```{r}
#| warning: false
PlotMonophyly(solution0, tr,main="Genus Strisores", plot.type='taxonomy', ladderize=TRUE,monocoll = TRUE, cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
```
#### 5.2.3 Comparação entre os demais resultados
```{r}
#| warning: false
PlotMonophyly(solution0, tr, plot.type='monoVStax', cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, monocoll = TRUE,splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
dev.off()
cmdstr = paste("open ", pdffn, sep="")
system(cmdstr)

```
