library(MonoPhy)
library(here)
tr <- read.tree(file = here("data/raw","FigTree.tre"))
tr <- root(tr, outgroup = c("Struthio_camelus"), resolve.root = TRUE)
solution0 <- AssessMonophyly(tr) 
GenusLevelTable<-data.frame(GetResultMonophyly(solution0))
colnames(GenusLevelTable) <- c('Monophyly','MRCA','Tips','DeltaTips','Intruders','Intruders','Outliers','Outliers')#Rename it
write.csv(x = GenusLevelTable, file = "GenusLevelTable.csv")
----------------------------------------------------------------------------------------------------------
pdffn = "Strisores_Monophyly_Genus_LVL.pdf"
pdf(pdffn, width=35, height=75)
tr$node.label <- NULL
PlotMonophyly(solution0, tr,main="Monophyly Strisores",plot.type='monophyly',monocoll = TRUE, tax.colour='black',, ladderize=TRUE, cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
PlotMonophyly(solution0, tr,main="Genus Strisores", plot.type='taxonomy', ladderize=TRUE,monocoll = TRUE, cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
PlotMonophyly(solution0, tr, plot.type='monoVStax', cex=0.8,label.offset=0.8, tipcex=1.2, statecex=0.3, monocoll = TRUE,splitcex=0.3, titlecex=2.0, plotsplits=T, include_null_range=TRUE)
dev.off()
cmdstr = paste("open ", pdffn, sep="")
system(cmdstr)
