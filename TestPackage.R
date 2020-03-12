library(devtools)
install_github("rmcelreath/rethinking")



library(rethinking)

rethinking::stancode(object = f)

f <- alist(
  y ~ dnorm( mu , sigma ),
  mu ~ dnorm( 0 , 10 ),
  sigma ~ dcauchy( 0 , 1 )
)

fit <- map( 
  f , 
  data=list(y=c(-1,1)) , 
  start=list(mu=0,sigma=1)
)

fit

globe.qa <- map(
  alist(
    w ~ dbinom(9,p) ,
    p ~ dunif(0,1)
  ) ,
  data=list(w=6) )
# binomial likelihood
# uniform prior
# display summary of quadratic approximation
precis( globe.qa )

library(brms)

globe_qa_brms <-
  brm(data = list(w = 24), 
      family = binomial(link = "identity"),
      w | trials(36) ~ 1,
      prior(beta(1, 1), class = Intercept),
      iter = 4000, warmup = 1000,
      control = list(adapt_delta = .9),
      seed = 4)
