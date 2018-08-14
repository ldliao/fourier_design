setwd("C:/Users/Lauren/Desktop/CoSIBS/TheoryCH/Module1")
dta = read.csv("C:/Users/Lauren/Documents/R/Data/GSS2002.csv")
dim(dta)
table(dta$Gender)
head(dta)
table(duplicated(dta$ID))
# **********data set characteristics
library(tableone)
version
vbls <- names(dta)
vbls <- vbls[-1]
tbl1 <- CreateTableOne(vbls,data=dta)
tbl1
table(dta$Gender)
CreateTableOne(data=dta)
tbl1$CatTable$Overall$Postlife[1,]
names(tbl1)

tbl1$CatTable$Overall$Gender

#********** analysis of happy:
happy <- dta$Happy != "Not too happy"
table(happy)
xtab <- table(happy, dta$Income)
xtab
chisq.test(xtab)