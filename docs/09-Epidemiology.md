---
title: "developing in epidemiology"
author: "Thijmen"
output: bookdown::html_document2
---

## Creating an epidemiology map

With the infrastructure we have created to make it easier for people to connect, we have also made the infrastructure for diseases to spread. Many of these diseases cause allot of trouble and can weaken whole societies, just take a look at SARS-COV-19. To figure out how these diseases spread is essential to figure out how a pathogen behaves. Figuring this out gives us the possibility to take precautions so it does not happen again, as can be seen by this report from the [CDC.](https://www.cdc.gov/eis/downloads/epidemiology-factsheet.pdf)        
In my future i want to be able to process epidemiological data to figure out where a disease originated, how it spread to different people and make this data easily readable for non data scientists with the help of shiny.       
To learn these skills i have made a small plan for a few steps i want to go through:        
1.    Find a suitable outbreak with available data.       
2.    Process the data to get simple phylogenetic trees.        
3.    Add regions to these trees.       
4.    Put these trees over a geographical map to see location.        
5.    Make these geopgraphicals maps interactive for easy visibility.       
<br>        

### Finding an outbreak

To be able and actually to create phylogenetic trees i need to have some data available to me.        
I dont want a massive amount of data like from the covid pandemic because this would be too much data to process while this is only for my own learning purpose.        
the NCBI has a very detailed database of different virus variation, for this exercise i will be using the data from the MERS-Cov outbreak (2013-2019).       
If you want to download this data for yourself go to [THIS SITE](https://www.ncbi.nlm.nih.gov/genome/viruses/variation/) and follow the following steps:        
1. Go to "MERS coronavirus"
2. Select nucleotide sequence type.       
3. Select Human host.        
4. Select S genome region.       
5. Click "additional filters", type "complete cds" and switch to definition lines.        
6. Click "Add query".        
7. Click "Show results". (this will redirect you to a new screen)       
8. Make sure only the S genome regions are selected!        
9. Click "Customize label", make sure the label only contains "\{accession\}". (this makes it easier to see later on)        
10. Click "Download" with as download option "Nucleotide (FASTA)".        
11. Click "Download" but now with as download option "Result set (CSV)". (This is the metadata)       
<br>        
You now have 2 files:       
1. The nucleotide sequence of all samples taken from human hosts with the accession number.       
2. The metadata that shows all the information for each accession number.       
<br>        
I will only be working with these 2 datafiles.        

### Creating Phylogenetic trees

For learning how to create these phylogenetic trees I have taken inspiration from a small tutorial on how to create Phylogenetic trees. You can find this tutorial [Here](https://fuzzyatelin.github.io/bioanth-stats/module-24/module-24.html).       



```r
# we need to load a few packages first
#BiocManager::install("msa")
library(msa)
```

```
## Loading required package: Biostrings
```

```
## Loading required package: BiocGenerics
```

```
## 
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
## 
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
## 
##     anyDuplicated, append, as.data.frame, basename, cbind, colnames,
##     dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
##     grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
##     order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
##     rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
##     union, unique, unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
```

```
## 
## Attaching package: 'S4Vectors'
```

```
## The following objects are masked from 'package:base':
## 
##     expand.grid, I, unname
```

```
## Loading required package: IRanges
```

```
## 
## Attaching package: 'IRanges'
```

```
## The following object is masked from 'package:grDevices':
## 
##     windows
```

```
## Loading required package: XVector
```

```
## Loading required package: GenomeInfoDb
```

```
## 
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
## 
##     strsplit
```

```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.6     v purrr   0.3.4
## v tibble  3.1.7     v dplyr   1.0.9
## v tidyr   1.2.0     v stringr 1.4.0
## v readr   2.1.2     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::collapse()   masks Biostrings::collapse(), IRanges::collapse()
## x dplyr::combine()    masks BiocGenerics::combine()
## x purrr::compact()    masks XVector::compact()
## x dplyr::desc()       masks IRanges::desc()
## x tidyr::expand()     masks S4Vectors::expand()
## x dplyr::filter()     masks stats::filter()
## x dplyr::first()      masks S4Vectors::first()
## x dplyr::lag()        masks stats::lag()
## x ggplot2::Position() masks BiocGenerics::Position(), base::Position()
## x purrr::reduce()     masks IRanges::reduce()
## x dplyr::rename()     masks S4Vectors::rename()
## x dplyr::slice()      masks XVector::slice(), IRanges::slice()
```

```r
library(tidyr)
library(here)
```

```
## here() starts at C:/Users/tvanb/Documents/Data_analysis/DSFB2/Portfolio
```

```r
library(adegenet)
```

```
## Loading required package: ade4
```

```
## 
## Attaching package: 'ade4'
```

```
## The following object is masked from 'package:Biostrings':
## 
##     score
```

```
## The following object is masked from 'package:BiocGenerics':
## 
##     score
```

```
## 
##    /// adegenet 2.1.7 is loaded ////////////
## 
##    > overview: '?adegenet'
##    > tutorials/doc/questions: 'adegenetWeb()' 
##    > bug reports/feature requests: adegenetIssues()
```

```r
library(ape)
```

```
## 
## Attaching package: 'ape'
```

```
## The following object is masked from 'package:Biostrings':
## 
##     complement
```

```r
#BiocManager::install("ggtree")
library(ggtree)
```

```
## Registered S3 method overwritten by 'ggtree':
##   method      from 
##   identify.gg ggfun
```

```
## ggtree v3.2.1  For help: https://yulab-smu.top/treedata-book/
## 
## If you use ggtree in published research, please cite the most appropriate paper(s):
## 
## 1. Guangchuang Yu. Using ggtree to visualize data on tree-like structures. Current Protocols in Bioinformatics. 2020, 69:e96. doi:10.1002/cpbi.96
## 2. Guangchuang Yu, Tommy Tsan-Yuk Lam, Huachen Zhu, Yi Guan. Two methods for mapping and visualizing associated data on phylogeny using ggtree. Molecular Biology and Evolution. 2018, 35(12):3041-3043. doi:10.1093/molbev/msy194
## 3. Guangchuang Yu, David Smith, Huachen Zhu, Yi Guan, Tommy Tsan-Yuk Lam. ggtree: an R package for visualization and annotation of phylogenetic trees with their covariates and other associated data. Methods in Ecology and Evolution. 2017, 8(1):28-36. doi:10.1111/2041-210X.12628
```

```
## 
## Attaching package: 'ggtree'
```

```
## The following object is masked from 'package:ape':
## 
##     rotate
```

```
## The following object is masked from 'package:tidyr':
## 
##     expand
```

```
## The following object is masked from 'package:Biostrings':
## 
##     collapse
```

```
## The following object is masked from 'package:IRanges':
## 
##     collapse
```

```
## The following object is masked from 'package:S4Vectors':
## 
##     expand
```

```r
#BiocManager::install("treeio")
library(treeio)
```

```
## treeio v1.18.1  For help: https://yulab-smu.top/treedata-book/
## 
## If you use treeio in published research, please cite:
## 
## LG Wang, TTY Lam, S Xu, Z Dai, L Zhou, T Feng, P Guo, CW Dunn, BR Jones, T Bradley, H Zhu, Y Guan, Y Jiang, G Yu. treeio: an R package for phylogenetic tree input and output with richly annotated and associated data. Molecular Biology and Evolution 2020, 37(2):599-603. doi: 10.1093/molbev/msz240
```

```
## 
## Attaching package: 'treeio'
```

```
## The following object is masked from 'package:ape':
## 
##     drop.tip
```

```
## The following object is masked from 'package:Biostrings':
## 
##     mask
```

```r
# now we need to load in the nucleotides
dna <- readDNAStringSet(here("data/MERS_nucleotides.fa"))
dna
```

```
## DNAStringSet object of length 168:
##       width seq                                             names               
##   [1]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KT805988
##   [2]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KT805968
##   [3]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KT357808
##   [4]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KM027279
##   [5]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KT805976
##   ...   ... ...
## [164]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KM027264
## [165]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA MH978886
## [166]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KT806039
## [167]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KM027269
## [168]  4062 ATGATACACTCAGTGTTTCTAC...GCATAAGGTTCATGTTCACTAA KY673146
```

```r
# and the metadata
metadata <- read.csv(here("data/MERS_annotation.csv"))
metadata %>% head(10) %>% knitr::kable()
```



|accession | length|genome_region |host         |country      |isolation      |collection_date |release_date |name                                                                                                            |
|:---------|------:|:-------------|:------------|:------------|:--------------|:---------------|:------------|:---------------------------------------------------------------------------------------------------------------|
|KJ782549  |   4062|S             |Homo sapiens |Greece       |oronasopharynx |2014/04/18      |2014/05/13   |Middle East respiratory syndrome coronavirus strain Greece-Saudi Arabia_2014 S protein (S) gene, complete cds   |
|KF811036  |   4062|S             |Homo sapiens |Tunisia      |blood          |2013/05/08      |2014/05/19   |Middle East respiratory syndrome coronavirus strain Tunisia-Qatar_2013 spike protein gene, complete cds         |
|KM027263  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7058/KSA/2014 spike protein (S) gene, complete cds |
|KM027264  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7209/KSA/2014 spike protein (S) gene, complete cds |
|KM027265  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7311/KSA/2014 spike protein (S) gene, complete cds |
|KM027266  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7312/KSA/2014 spike protein (S) gene, complete cds |
|KM027267  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7319/KSA/2014 spike protein (S) gene, complete cds |
|KM027268  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7554/KSA/2014 spike protein (S) gene, complete cds |
|KM027269  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7720/KSA/2014 spike protein (S) gene, complete cds |
|KM027270  |   4062|S             |Homo sapiens |Saudi Arabia |               |2014            |2014/11/12   |Middle East respiratory syndrome coronavirus isolate Jeddah_C7773/KSA/2014 spike protein (S) gene, complete cds |

```r
# we only want the years from the metadata so lets extract those
metadata <- metadata %>% separate(collection_date, into = "collection_date", sep = 4)
metadata$collection_date <- as.numeric(metadata$collection_date)


# the DNA is loaded in nicely with the exact amount of downloaded sequences.
# there is no multiple sequence alignment necessary for these sequences, this is because they all come from the same part of the DNA.

dna <- as.DNAbin(dna) # sequence has to be the correct class

# to create a phylogenetic tree we need to calculate the distance between all the sequences
# there are many different models to choose from, and it was not easy to choose out of all the options because there are allot of upsides and allot of downsides to all the possible methods. for this time i have chosen to use the Tamaru and Nei methode (TN93). Because they take into account that its different to swap from A-G then C-T and vice versa.

dna_distance <- dist.dna(dna, model = "TN93")

# lets start by making a very simple neighbour joining phylogenetic tree.

nj_tree <- bionj(dna_distance)
plot(nj_tree, cex = .4)
```

<img src="09-Epidemiology_files/figure-html/unnamed-chunk-1-1.png" width="672" />

```r
# this is the most simplistic phylogenetic tree to be made and just shows the relation between the different samples.
# now lets change it up so it isnt as clutured and make it give the information we actually want

# because I am not really interested in the accession number of every sample i want to change it to the country name 

nj_tree_renamed <- rename_taxa(nj_tree, metadata, accession, country)

# performing a bootstrap will not only tell us how good our lines are, it also give us the option to collapse some of them



ggplot(nj_tree_renamed) +
  geom_tree() +
  geom_tiplab(size = 3)
```

```
## Warning: The tree contained negative edge lengths. If you want to ignore the edges,
## you can set 'options(ignore.negative.edge=TRUE)', then re-run ggtree.
```

<img src="09-Epidemiology_files/figure-html/unnamed-chunk-1-2.png" width="672" />







```r
library(adegenet)
library(here)
library(tidyverse)
library(ggplot2)
#BiocManager::install("ggtree")
library(ggtree)


dna <- fasta2DNAbin(file = here("data/MERS_nucleotides.fa"))
dna

annot <- read.csv(here("data/MERS_annotation.csv"))

library(ape)
D <- dist.dna(dna, model = "TN93")
length(D)

temp <- as.data.frame(as.matrix(D))
table.paint(temp, cleg=0, clabel.row=.5, clabel.col=.5)


tre <- nj(D)
class(tre)

h_cluster <- hclust(D, method = "average", members = NULL) # method = average is used for UPGMA, members can be equal to NULL or a vector with a length of size D
plot(h_cluster, cex = 0.6, show.tip = F)

tre <- ladderize(tre)

plot(tre, cex = 0.6)

annot <- annot %>% separate(collection_date, into = c("collection_date"), sep = 4)
annot$collection_date <- as.numeric(annot$collection_date)

plot(tre, show.tip=FALSE, main = "Unrooted NJ tree") # gets rid of the labels on the end, refer to the first tree depicted above
title("Unrooted NJ tree")
myPal <- colorRampPalette(c("red","yellow","green","blue"))
tiplabels(annot$collection_date, bg=num2col(annot$collection_date, col.pal=myPal), cex=.5) #we use the annot dataset to get our years
temp <- pretty(2013:2019, 2)
legend("bottomleft", fill=num2col(temp, col.pal=myPal), leg=temp, ncol=2)

tre2 <- root(tre, out = 1)
tre2 <- ladderize(tre2)

x <- as.vector(D)
y <- as.vector(as.dist(cophenetic(tre2)))
plot(x, y, xlab="original pairwise distances", ylab="pairwise distances on the tree", main="Is NJ appropriate?", pch=20, col=transp("black",.1), cex=3)
abline(lm(y~x), col="red")



tre3 <- as.phylo(hclust(D,method="average"))
y <- as.vector(as.dist(cophenetic(tre3)))
plot(x, y, xlab="original pairwise distances", ylab="pairwise distances on the tree", main="Is UPGMA appropriate?", pch=20, col=transp("black",.1), cex=3)
abline(lm(y~x), col="red")

cor(x, y)^2





myBoots <- boot.phylo(tre2, dna, function(e) root(nj(dist.dna(e, model = "TN93")),1))

myBoots


plot(tre2, show.tip=FALSE, edge.width=2)
title("NJ tree + bootstrap values")
tiplabels(frame="none", pch=20, col=transp(num2col(annot$collection_date, col.pal=myPal),.7), cex=3, fg="transparent")

axisPhylo()
temp <- pretty(2013:2019, 5)
legend("topright", fill=transp(num2col(temp, col.pal=myPal),.7), leg=temp, ncol=2)
nodelabels(myBoots, cex=.6)
```
