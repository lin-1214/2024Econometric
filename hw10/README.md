# Econometric Methods, 2024 Assignment 10

**Due: 12/4, 0:00am**

---

1. Let ${(Y_i, X_i')}_{i=1}^n$ be a random sample, in which $Y_i$ is a Bernoulli random variable with two possible outcomes: 0 and 1. Assume that:

   $$P(Y = 1 | X) = G(X'\beta),$$

   where $G(·)$ is the distribution function of a continuous random variable such that $G(u) = 1 − G(−u)$ for $u \in ℝ$. Also, assume that $G(·)$ is known.

   a. Please derive the information matrix of this binary choice model.

   b. Please examine whether the information matrix equality holds for this model.

---

2. Suppose that we are interested in estimating the probability of the event that S&P500 is in the "bull market" during 1981–2022 using the ML method based on a binary choice model:

   $$P(Y_i = 1 | X_i) = G(\beta_0 + X_i'\beta),$$

   where $Y_i$ is a monthly market-cycle index:

   $$
   Y_i =
   \begin{cases}
       1, & \text{the $i$th month is "bear"}, \\
       0, & \text{the $i$th month is "bull"}.
   \end{cases}
   $$

   as defined in [https://www.forbes.com/advisor/investing/bull-market-history/](https://www.forbes.com/advisor/investing/bull-market-history/), and

   $$X_i := (x\_dfy, x\_infl, x\_svar, x\_tms, x\_tbl, x\_dfr, x\_dp, x\_ltr, x\_ep, x\_bmr, x\_ntis)',$$

   for $i = 1, 2, ..., 504$, based on the data `Equity_Premium.csv`.

---

Since the MLE does not have a closed-form solution for a binary choice model, we need to solve the MLE using a numerical optimization method.

- Before doing the numerical optimization, please read Sections 12.1–12.5 of Hansen, B. E. (2022), *Probability and Statistics for Economists*, for a basic introduction on numerical optimization.
- Implement the numerical optimization using the default setting of `optim` in R: [https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/optim](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/optim).
- Set the "initial values" as the LS estimates of the "linear probability model."
- Check whether the numerical optimization is successfully converged. If not, try a larger "maximum number of iterations."

---

a. Plot the market-cycle-index sequence ${Y_i}$ and the following three "bull-market probability sequences" in the same figure:

   1. Linear probability model: $\beta_{0,LS} + X_i'\beta_{LS}$, where $(\beta_{0,LS}, \beta_{LS})$ is the LS estimator.
   2. Probit model: $G(\beta_{0,ML} + X_i'\beta_{ML})$, where $(\beta_{0,ML}, \beta_{ML})$ is the MLE of the probit model.
   3. Logit model: $G(\beta_{0,ML} + X_i'\beta_{ML})$, where $(\beta_{0,ML}, \beta_{ML})$ is the MLE of the logit model.

b. Evaluate the score functions of the probit model and the logit model at their MLEs, and assess whether the values are "sufficiently close to" zero.
