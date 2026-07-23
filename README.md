

# Análise de gêneros monofiléticos com MonoPhy

``` r
library(here)
```

    here() starts at /Users/denersoares/Downloads/0.Test_topology_Genus

``` r
library(MonoPhy)
```

    Loading required package: ape

    Loading required package: phytools

    Loading required package: maps

## 1. Carregar árvore e escolher grupo externo para ser enraizado

``` r
tr <- read.tree(file = here("data/raw","FigTree.tree")) #
tr <- root(tr, outgroup = c("Struthio_camelus"), resolve.root = TRUE)
```

## 2. Avaliação de monofiletismo (nível de gênero)

``` r
solution0 <- AssessMonophyly(tr)
```

## 3. Extração de informações suplementares

### 3.1 Status de monofilia, Nó, espécies parafiléticas (Outliers/de fora ou Intruders/Intruso - de acordo com a taxonomia), entre outras informações padrões

``` r
GenusLevelTable <- data.frame(GetResultMonophyly(solution0))
 
colnames(GenusLevelTable) <- c('Monophyly', 'MRCA', 'Tips', 'DeltaTips', 'Intruders', 'Intruders', 'Outliers', 'Outliers') # Rename it
```

## 4. Armazenamento dos dados em uma tabela

``` r
write.csv(x = GenusLevelTable, file = here("GenusLevelTableMixed123.csv")) 
```

## 5. Plotagem da árvore filogenetica com o monofiletismo à nível de gênero colapsado (PDF)

### 5.1 Criação de um arquivo em pdf em branco

``` r
pdffn <- here("Strisores_Monophyly_Genus_LVL.pdf") 
pdf(pdffn, width = 35, height = 75)
```

### 5.2 Armazenamento e plotagem da árvore comparada

#### 5.2.1 Monofiletismo evidenciado e táxons intrusos destacados

``` r
# Monofiletismo Evidenciado
PlotMonophyly(solution0, tr, main = "Monophyly Strisores", plot.type = 'monophyly',
              tax.colour = 'black', ladderize = TRUE, cex = 0.8, label.offset = 0.8,
              tipcex = 1.2, statecex = 0.3, splitcex = 0.3, titlecex = 2.0,
              plotsplits = TRUE, include_null_range = TRUE)
```

    Warning in plot.window(...): "tipcex" is not a graphical parameter

    Warning in plot.window(...): "statecex" is not a graphical parameter

    Warning in plot.window(...): "splitcex" is not a graphical parameter

    Warning in plot.window(...): "titlecex" is not a graphical parameter

    Warning in plot.window(...): "plotsplits" is not a graphical parameter

    Warning in plot.window(...): "include_null_range" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "tipcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "statecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "splitcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "titlecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "plotsplits" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "include_null_range" is not a graphical
    parameter

    Warning in title(...): "tipcex" is not a graphical parameter

    Warning in title(...): "statecex" is not a graphical parameter

    Warning in title(...): "splitcex" is not a graphical parameter

    Warning in title(...): "titlecex" is not a graphical parameter

    Warning in title(...): "plotsplits" is not a graphical parameter

    Warning in title(...): "include_null_range" is not a graphical parameter

![](README_files/figure-commonmark/unnamed-chunk-7-1.png)

#### 5.2.2 Coloração por gêneros

``` r
PlotMonophyly(solution0, tr, main = "Genus Strisores", plot.type = 'taxonomy',
              ladderize = TRUE, cex = 0.8, label.offset = 0.8, tipcex = 1.2,
              statecex = 0.3, splitcex = 0.3, titlecex = 2.0,
              plotsplits = TRUE, include_null_range = TRUE)
```

    Warning in fastAnc(tax.tree, tipdataT, vars = FALSE, CI = FALSE): x should be a vector with names corresponding to the taxon labels of the tree.
      Assuming x is in the order of tree$tip.label (this is seldom true).

    Warning in plot.window(...): "tipcex" is not a graphical parameter

    Warning in plot.window(...): "statecex" is not a graphical parameter

    Warning in plot.window(...): "splitcex" is not a graphical parameter

    Warning in plot.window(...): "titlecex" is not a graphical parameter

    Warning in plot.window(...): "plotsplits" is not a graphical parameter

    Warning in plot.window(...): "include_null_range" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "tipcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "statecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "splitcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "titlecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "plotsplits" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "include_null_range" is not a graphical
    parameter

    Warning in title(...): "tipcex" is not a graphical parameter

    Warning in title(...): "statecex" is not a graphical parameter

    Warning in title(...): "splitcex" is not a graphical parameter

    Warning in title(...): "titlecex" is not a graphical parameter

    Warning in title(...): "plotsplits" is not a graphical parameter

    Warning in title(...): "include_null_range" is not a graphical parameter

![](README_files/figure-commonmark/unnamed-chunk-8-1.png)

#### 5.2.3 Comparação entre os demais resultados

``` r
PlotMonophyly(solution0, tr, plot.type = 'monoVStax', cex = 0.8, label.offset = 0.8,
              tipcex = 1.2, statecex = 0.3, splitcex = 0.3, titlecex = 2.0,
              plotsplits = TRUE, include_null_range = TRUE)
```

    Warning in fastAnc(tax.tree, tipdataT, vars = FALSE, CI = FALSE): x should be a vector with names corresponding to the taxon labels of the tree.
      Assuming x is in the order of tree$tip.label (this is seldom true).

    Warning in plot.window(...): "tipcex" is not a graphical parameter

    Warning in plot.window(...): "statecex" is not a graphical parameter

    Warning in plot.window(...): "splitcex" is not a graphical parameter

    Warning in plot.window(...): "titlecex" is not a graphical parameter

    Warning in plot.window(...): "plotsplits" is not a graphical parameter

    Warning in plot.window(...): "include_null_range" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "tipcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "statecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "splitcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "titlecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "plotsplits" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "include_null_range" is not a graphical
    parameter

    Warning in title(...): "tipcex" is not a graphical parameter

    Warning in title(...): "statecex" is not a graphical parameter

    Warning in title(...): "splitcex" is not a graphical parameter

    Warning in title(...): "titlecex" is not a graphical parameter

    Warning in title(...): "plotsplits" is not a graphical parameter

    Warning in title(...): "include_null_range" is not a graphical parameter

    Warning in plot.window(...): "tipcex" is not a graphical parameter

    Warning in plot.window(...): "statecex" is not a graphical parameter

    Warning in plot.window(...): "splitcex" is not a graphical parameter

    Warning in plot.window(...): "titlecex" is not a graphical parameter

    Warning in plot.window(...): "plotsplits" is not a graphical parameter

    Warning in plot.window(...): "include_null_range" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "tipcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "statecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "splitcex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "titlecex" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "plotsplits" is not a graphical parameter

    Warning in plot.xy(xy, type, ...): "include_null_range" is not a graphical
    parameter

    Warning in title(...): "tipcex" is not a graphical parameter

    Warning in title(...): "statecex" is not a graphical parameter

    Warning in title(...): "splitcex" is not a graphical parameter

    Warning in title(...): "titlecex" is not a graphical parameter

    Warning in title(...): "plotsplits" is not a graphical parameter

    Warning in title(...): "include_null_range" is not a graphical parameter

![](README_files/figure-commonmark/unnamed-chunk-9-1.png)

``` r
dev.off()
```

    pdf 
      3 
