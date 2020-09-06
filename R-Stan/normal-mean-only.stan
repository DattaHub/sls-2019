// ---------------------------------------------------------------------
// model name: mean-only, normal [vectorized: no for loop over index t]

data {
    int<lower=1> T;
    real y[T];
}

parameters {
    real theta;
    real<lower=0> sigma;
}

model {
    theta ~ normal(0, 1);
    sigma ~ cauchy(0,5);
    y ~ normal(theta, sigma);
}
