source("read-us-data-income.R")

tab <- read_us_data_on_consumption_and_income()

lims<- range(tab %>% select(C, Y))

plot(C ~ time,
     data=tab,
     col="black",
     type="l",
     lwd=1.75,
     ylim=c(lims[1], lims[2]),
     ylab="Consumption and Income",
     main="US Quarterly Consumption and Income"
)
lines(Y ~ time,
      data=tab,
      col="steelblue4",
      type="l",
      lwd=1.5,
      ylim=c(lims[1], lims[2])
)
legend(
  "topleft",
  col=c("black", "steelblue4"),
  lwd=2,
  legend=c("Consumption","Income"),
  inset=0.02
)

plot(e ~ time,
     data=tab,
     col="black",
     type="o",
     main="Error process: Consumption regressed on Income"
)
abline(h=0, col="steelblue4")

us_income_data =  list(y = tab$e,T=nrow(tab))

## Stochastic Unit Root 

stur.fit <- stan(file = 'stur.stan', data = us_income_data)

# A unit root corresponds to mu-omega being positive,
# therefore for stationarity we wish to know:

mu_omega<- rstan::extract(stur.fit)[["mu_omega"]]
hist(mu_omega, breaks=30, main="mu_omega", xlab="mu_omega", ylab="density")

## Stochastic Volatility

sv.fit <- stan(file = 'stochvol.stan', data = us_income_data)

# A unit root corresponds to mu-omega being positive,
# therefore for stationarity we wish to know:

phi.smpls <- rstan::extract(sv.fit)[["phi"]]
hist(phi.smpls, breaks=30, main="phi", xlab="phi", ylab="density")

mu.smpls <- rstan::extract(sv.fit)[["mu"]]
hist(mu.smpls, breaks=30, main="mu", xlab="mu", ylab="density")

h_std.smpls <- rstan::extract(sv.fit)[["h_std"]]
h_mean = apply(h_std.smpls, 2, mean)

hist(h_mean, breaks=30, freq = F, main="h_std", xlab="h_std", ylab="density")

tab = cbind(tab,h_mean)

plot(h_mean ~ time,
     data=tab,
     col="black",
     type="o",
     main="Posterior mean: Scaled Innovations"
)
abline(h=0, col="steelblue4")

