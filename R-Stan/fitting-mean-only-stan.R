

## Install the following packages 
## There are lots of duplicates and some of them won't be necessary 

# install.packages("tidyverse")
library(tidyverse)
library(zoo)
library(openxlsx)

library(ggplot2)
library(dplyr)
library(rstan)

## Don't load the following packages unless you need them for any specific task
if(F){
  library(grid)
  library(gridExtra)
  library(scales)
  library(ggthemes)
  library(stringr)
  library(lubridate)
  library(readr)
  library(knitr)
  library(reshape2)
  library(magrittr)
  library(lazyeval)
}



#### Data Reading #####

tab<- read.xlsx(
  "Time Series and Forecasting Appendix B Tables.xlsx",
  sheet = "B.2-PHAR",
  colNames = TRUE,
  startRow = 3,
  check.names = FALSE,
  detectDates = TRUE
)

head(tab) ## 8 columns 

`stack`<-  function(tab, indices){
  do.call("rbind", lapply(indices, function(index) tab[, index]))
}

tab<- stack(tab, list(1:2, 3:4, 5:6, 7:8)) ## stack the columns
colnames(tab)<- c("Week", "Sales")

head(tab)


tab <- tab %>% filter(!is.na(Week))

ggplot(tab, aes(Week, `Sales`)) + geom_line() + theme_minimal()


mean_data =  list(
  y = tab$Sales,
  T=length(tab$Sales))

fit <- stan(file = 'normal-mean-only.stan', data = mean_data)

## also try 'mean-only_normal_predict_new_generated_quantities.stan'

print(fit)
plot(fit)

traceplot(fit, inc_warmup=FALSE)

pairs(fit, pars = c("theta", "sigma", "lp__"))


la <- extract(fit, permuted = TRUE) # return a list of arrays 
theta <- la$theta
sigma <- la$sigma

theta_hat<- mean(theta)
sigma_hat<- mean(sigma)

par(mfrow=c(1,2))
hist(theta, breaks=30, main="theta", xlab="theta")
abline(v=theta_hat,  col = "red", lwd = 2)
hist(sigma, breaks=30, main="sigma", xlab="sigma")
abline(v=sigma_hat, col = "red", lwd = 2)
