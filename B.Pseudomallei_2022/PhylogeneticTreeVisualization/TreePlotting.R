library("ggtree")
library("treeio")
library(ape)
library(ggplot2)

##The following script is written by Dr. Marcus Shum Ho Hin
##All copyright belongs to Dr. Marcus Shum Ho Hin
##Date 19/01/2023

##Read In The Phylogenetic Tree
tre <- read.newick("./Trial/BPseudomonas.tree.MR")
p <- ggtree(tre)

##Generation of the tree with Taxa name and you can adjust the size by changing the geom_treesclae parameters
p <- p + geom_treescale(width=0.1, x=0, y=-30)+ geom_tiplab(size=3, align=TRUE, offset=0.01)

##Read In Country And Region Metadata
metadata=read.table(file = './Trial/metadata_CountryRegion.tsv', sep = '\t', stringsAsFactor=F)
colnames(metadata) <- sub("\\.$", "", colnames(metadata))

##Generation of the metadata annotated tree file and print out an PDF for it. You may adjust the size by changing the treescale parameters
pdf(file="CountryRegionAnnotatedTree.pdf", width=20, height = 40)
gheatmap(p, metadata, offset=0.05, width=0.03, font.size=2, 
         colnames_angle=-45, hjust=0)
dev.off()

##Read In Host Metadata
metadata=read.table(file = './Trial/metadata_Host.tsv', sep = '\t', stringsAsFactor=F)
colnames(metadata) <- sub("\\.$", "", colnames(metadata))

##Generation of the metadata annotated tree file and print out an PDF for it. You may adjust the size by changing the treescale parameters
pdf(file="HostAnnotatedTree.pdf", width=20, height = 40)
gheatmap(p, metadata, offset=0.05, width=0.03, font.size=2, 
         colnames_angle=-45, hjust=0)
dev.off()

