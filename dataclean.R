mydf <- as.data.frame(t(mydf))
mydf <- rename(mydf, city = V1, pop = V2, pu5 = V3, pu18 = V4, p65p = V5, alf = V6, hi = V7, mhv = V8, mgr = V9, pov = V10, att = V11, ca = V12, ji1 = V13, ji2 = V14, ji3 = V15, ji4 = V16, col1 = V17, col2 = V18, col3 = V19, swb1 = V20, swb2 = V21, swb3 = V22)
mydf <- mydf[-c(1), ]
write.csv(mydf, file = "mydf.csv",row.names=FALSE)

# AFTER IMPORT FROM MYDF
mydf$job <- 0.27*(mydf$ji1+mydf$ji2-mydf$ji3+mydf$ji4)
mydf$col <- 0.33*(mydf$col1-mydf$col2-mydf$col3)
mydf$swb <- 0.4*(-mydf$swb1-mydf$swb2+mydf$swb3)
mydf$idxtotal <- mydf$job + mydf$col + mydf$swb
# mydf$hi <- as.numeric(mydf$hi)
# mydf$mhv <- as.numeric(mydf$mhv)
mydf$hi <- as.numeric(gsub('\\$|,', '', mydf$hi))
mydf$mhv <- as.numeric(gsub('\\$|,', '', mydf$mhv))
mydf$mgr <- as.numeric(gsub('\\$|,', '', mydf$mgr))
