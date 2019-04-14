rm(list = ls())
set.seed(123)
## Simple AR(1) model
phi = 0.9
nu = 1
T = 100
x = numeric(T)
for(t in 1:(T-1)){
  x[t+1] = phi*x[t]+rnorm(1,0,nu)
}
par(mfrow=c(1,2))
plot(x, type = "l")
plot(acf(x, plot = F))
par(mfrow=c(1,1))

## Simple HMM 

w = 2
y = x + rnorm(T, 0, w)
plot(y, type = "l", main = "HMM")
lines(x, col = "blue", lwd = 2)
legend("topleft",c("y","x"), lty = 1, lwd = c(1,2), col = c(1,4))

## Simple Stochastic Volatility 

mu = 2; 
sigma_t = exp(mu + x)
y = rnorm(T, 0, sigma_t)

par(mfrow=c(1,2))
plot(y, type ="l", main = "y")
plot(x, type ="l", col = 2, lwd = 2, main = "SVM")
lines(log(y^2)/2, col = 4, lwd = 2)
legend("topleft",c("log(|y|)","x"), lty = 1, lwd = c(2,2), col = c(2,4))
par(mfrow=c(1,1))
