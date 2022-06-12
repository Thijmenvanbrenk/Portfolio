########################################################################
Title: Portfolio
Author: Thijmen van Brenk
Business email: "tvanbrenk@outlook.com"
General information: This project is made to show my abilities in data science. 
########################################################################

This repository is a collection of skills I have gathered over a few months of data science.
If you want to reproduce the book that is created in here make sure to install the following packages
```
install.packages("tidyverse")
install.packages("here")
install.packages("readxl")
install.packages("RColorBrewer")
install.packages("plotly")
install.packages("RPostgres")
install.packages("DBI")
install.packages("dslabs")
install.packages("car")
install.packages("tidyr")
install.packages("adegenet")
install.packages("ape")
install.packages("devtools")
devtools::install_github("paleolimbot/rbbt")
# update all packages mentioned
install.packages("BiocManager")
BiocManager::install("msa")
# update all packages mentioned
BiocManager::install("ggtree")
# update all packages mentioned
BiocManager::install("treeio")
# update all packages mentioned
```
And make sure to change the parameter in "07-SQL.Rmd" has your password to your DBeaver account.
And make a database in DBeaver called "dengue_flu_data".

More information can be found in "index.Rmd"
