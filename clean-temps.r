# DCD: July 30, 2017
# input a time series and impute missing values
# we first have to define what is missing/bad
# and replace with NA

# load libraries
if(!require(Hmisc)){
    install.packages("Hmisc")
    library(somepackage)
}
# install missForest to use "prodNA"
# install.packages("missForest")
# library("missForest")

# read in a CSV with headers
df <- read.csv("at-temps.csv", header = TRUE)

######
# this is the important section where you decide
# what conditions to replace recorded data with NA
#
# example conditions:
#   less than or equal to 0
#   greater than or equal to 100
df[df <= 0.0] <- NA
df[df >= 100.0] <- NA

# how many unusable values were found?
# sum(is.na(df$temp))

# impute the missing series in a new column imputed_temp
df$imputed_temp <- with(df, impute(temp, mean))
write.csv(df$imputed_temp, file = "imputed-temps.csv")

# open document for plot
pdf("temps-raw-imputed-compare.pdf")

# WAS plot the initial data with missing 
plot.ts(df$temp[c(1:100)], col="red")

# IS compare with the new imputed data
plot.ts(df$imputed_temp[c(1:100)], col="blue")

dev.off()
