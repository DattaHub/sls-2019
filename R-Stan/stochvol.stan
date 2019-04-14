
data {
  int<lower=0> T;
  vector[T] y;
}
parameters {
  real mu;
  real<lower=-1, upper=1> phi; // Stationary volatility
  real<lower=0> sigma;
  vector[T] h_std;
}
transformed parameters {
  vector[T] h;
  h = h_std * sigma;
  h[1] = h[1] / sqrt(1 - phi * phi);
  h = h + mu;
  for(t in 2:T){
    h[t] = h[t] + phi * (h[t-1] - mu);
  }
}
model {
  // Priors
  phi ~ uniform(-1, 1);
  sigma ~ cauchy(0, 5);
  mu ~ cauchy(0, 10);
  // Scaled Innovations in h process are IID N(0,1)
  h_std ~ normal(0, 1);
  // Observation likelihood.
  // Note exp(h/2) since Stan uses normal(mean, SD)
  y ~ normal(0, exp(h/2));
}

