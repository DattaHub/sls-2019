# Pre-conference workshop for Spring Lecture Series 2019 
## University of Arkansas 

Lecture slides, R, and Stan codes for the pre-conference workshop for SLS 2019. 
Stan codes obtained from the Stan manual and the Stan tutorial at https://github.com/tharte/mbt. 

## Instructions: 

As part of the Spring Lecture Series 2019, we are offering a pre-conference workshop on Wednesday April 17, 2019 from 1-5 pm at the Science Engineering building. The first part of the workshop will be a gentle introduction to dynamic linear model, conducted by Dr. Giovanni Petris (at SCEN 322, 1-3 pm) and the second part will be a hands-on R and Stan modeling workshop for Bayesian time series analysis (at SCEN 320, 3-5 pm) offered by me (Jyotishka Datta). These workshops will be aimed at junior participants with a target of providing some background on the main conference theme of Bayesian Dynamic Systems. 

If you are interested in attending the R-Stan modeling workshop, I will request you to bring a laptop if you have one and install R and Stan if you don’t have these on your laptop already. Detailed instructions can be found here or here. The steps for installing R-Stan from source are also provided on these pages, e.g. the steps for Windows are here. You can check if R-Stan/Stan has been installed correctly by running the “eight schools example” on R (link). Having R-Stan running on your machine will enable you to run the codes we use for demonstrating the model fitting. For ease of access, all the codes will be shared via a github repo: https://github.com/DattaHub/sls-2019 (still work-in-progress). 

## Stan Demo: Examples 

1.  (Toy example) Mean-only Normal Shocks. 
2.  Simple AR model (stochastic unit roots)
3.  Stochastic volatility models. 

Data-sets, R and Stan Codes are available here: [https://github.com/DattaHub/sls-2019](https://github.com/DattaHub/sls-2019)

This presentation is available here (source codes are in sls-2019 repo):
[http://dattahub.github.io/sls-2019/time-series-demo.html#1](http://dattahub.github.io/sls-2019/time-series-demo.html#1)

Stan examples are taken from this Stan tutorial for time series: 
[http://tharte.github.io/mbt/mbt.html](http://tharte.github.io/mbt/mbt.html)



## Example 1

-  We'll fit a mean-only Normal "shocks" model.  

-  The data-set we'll use is the "B.2-PHAR" tab on the excel file "Time Series and Forecasting Appendix B Tables". (You don't need to open this file for fitting the model.)

-  The R code "fitting-normal-mean-only-stan.R" will read the data-set and fit the Stan model in "normal-mean-only.stan". 

- The stan code "mean-only_normal_predict_new_generated_quantities.stan" is an example of using the "generated quantities" block.

- Let us look at this stan code carefully to understand the basic functional features. 


## Example 2 and 3

-  We will use the data on US consumption and income. 
-  The R code for reading the data is "read-us-data-income.R". The same R code also calculates the residuals for regression of In
-  The Stan codes for the two models are :
   1.  "stur.stan".
   2.  "stochvol.stan"
-  The R code for fitting the two models on the same data-set is 
"analyse-us-income-stur-stochvol.R"


