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
PlotMonophyly(solution0, tr,main="Monophyly Strisores",plot.type='monophyly', tax.colour='black',, ladderize=TRUE, cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
```

#### 5.2.2 Coloração por gêneros

```{r}
#| warning: false
PlotMonophyly(solution0, tr,main="Genus Strisores", plot.type='taxonomy', ladderize=TRUE, cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
```
#### 5.2.3 Comparação entre os demais resultados
```{r}
#| warning: false
PlotMonophyly(solution0, tr, plot.type='monoVStax', cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
dev.off()
cmdstr = paste("open ", pdffn, sep="")
system(cmdstr)

```
