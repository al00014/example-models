data {
    int(0,) I;
    int(0,) n[I];
    int(0,) N[I];
    double x1[I];
    double x2[I];
}
parameters {
    double alpha0;
    double alpha1;
    double alpha2;
    double alpha12;
    double(0,) tau;
    double b[I];
}
derived parameters {
    double sigma;
}
model {
   alpha0 ~ normal(0.0,1.0E3);
   alpha1 ~ normal(0.0,1.0E3);
   alpha2 ~ normal(0.0,1.0E3);
   alpha12 ~ normal(0.0,1.0E3);
   tau ~ gamma(1.0E-3,1.0E-3);
   sigma  <- 1.0 / sqrt(tau);
   for (i in 1:I) {
      b[i] ~ normal(0.0, sigma);
      n[i] ~ binomial(N[i], inv_logit(alpha0 
                                      + alpha1 * x1[i] 
                                      + alpha2 * x2[i]
                                      + alpha12 * x1[i] * x2[i] 
                                      + b[i]) );
   }
}