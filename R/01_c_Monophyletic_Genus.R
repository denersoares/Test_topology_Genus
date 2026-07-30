# ==============================================================================
# Script: 01_c_Monophyletic_Genus.R
# Objetivo: Avaliar o monofiletismo a nível de gênero em uma topologia
#           filogenética e gerar visualizações e tabela de resultados.
# ==============================================================================

# ---- 1. Pacotes ----
library(MonoPhy)
library(here)

# ---- 2. Parâmetros de entrada (fáceis de ajustar no topo do script) ----
# Escolha preferencialmente um táxon fora do clado de interesse para ser enraizado,
# pois um outgroup mal escolhido (dentro do próprio clado analisado) pode distorcer
# a topologia e invalidar a checagem de monofiletismo dos gêneros.
input_tree_path  <- here("data", "raw", "FigTree.tre") #Árvore filogenética contendo todos os Strisores (Neognatas) e um Paleognata - Struthio camelus
outgroup_taxa    <- c("Struthio_camelus")
output_table_path <- here("output", "GenusLevelTable.csv")
output_pdf_path   <- here("output", "Strisores_Monophyly_Genus_LVL.pdf")

# ---- 3. Criação da pasta de output, caso não exista ----
if (!dir.exists(here("output"))) {
  dir.create(here("output"), recursive = TRUE)
}

# ---- 4. Leitura e checagem da árvore ----
if (!file.exists(input_tree_path)) {
  stop("Arquivo de árvore não encontrado em: ", input_tree_path)
}

tr <- read.tree(file = input_tree_path)

if (is.null(tr)) {
  stop("Falha ao ler a árvore. Verifique o formato do arquivo Newick.")
}

# ---- 5. Enraizamento da árvore ----
if (!outgroup_taxa %in% tr$tip.label) {
  stop("Outgroup '", outgroup_taxa, "' não encontrado nas pontas da árvore.")
}

tr <- root(tr, outgroup = outgroup_taxa, resolve.root = TRUE)

# ---- 6. Avaliação de monofiletismo ----
solution0 <- AssessMonophyly(tr)

# ---- 7. Geração da tabela de resultados a nível de gênero ----
GenusLevelTable <- data.frame(GetResultMonophyly(solution0))

# Nomes de coluna únicos e descritivos (evita colunas duplicadas)
colnames(GenusLevelTable) <- c(
  "Monophyly",
  "MRCA",
  "Tips",
  "DeltaTips",
  "Intruders_Count",
  "Intruders_Names",
  "Outliers_Count",
  "Outliers_Names"
)

write.csv(x = GenusLevelTable, file = output_table_path, row.names = TRUE)
message("Tabela salva em: ", output_table_path)

# ---- 8. Visualizações em PDF ----
pdf(output_pdf_path, width = 35, height = 75)

tr$node.label <- NULL

PlotMonophyly(
  solution0, tr,
  main = "Monophyly Strisores",
  plot.type = "monophyly",
  monocoll = TRUE,
  tax.colour = "black",
  ladderize = TRUE,
  cex = 0.8,
  label.offset = 0.8,
  tipcex = 1.2,
  statecex = 0.3,
  splitcex = 0.3,
  titlecex = 2.0,
  plotsplits = TRUE,
  include_null_range = TRUE
)

PlotMonophyly(
  solution0, tr,
  main = "Genus Strisores",
  plot.type = "taxonomy",
  ladderize = TRUE,
  monocoll = TRUE,
  cex = 0.8,
  label.offset = 0.8,
  tipcex = 1.2,
  statecex = 0.3,
  splitcex = 0.3,
  titlecex = 2.0,
  plotsplits = TRUE,
  include_null_range = TRUE
)

PlotMonophyly(
  solution0, tr,
  plot.type = "monoVStax",
  monocoll = TRUE,
  cex = 0.8,
  label.offset = 0.8,
  tipcex = 1.2,
  statecex = 0.3,
  splitcex = 0.3,
  titlecex = 2.0,
  plotsplits = TRUE,
  include_null_range = TRUE
)

dev.off()
message("PDF salvo em: ", output_pdf_path)

# ---- 9. Abertura automática do PDF (opcional, apenas macOS) ----
if (Sys.info()["sysname"] == "Darwin" && interactive()) {
  system(paste("open", shQuote(output_pdf_path)))
} else {
  message("Abertura automática pulada (não é macOS ou sessão não interativa).")
}
