# Homework: 2024/10/30

## 1. 

Let ${Y_i}_{i=1}^n$ be an IID sequence of random variables. Denote the sample mean $\bar{Y} := \frac{1}{n} \sum_{i=1}^n Y_i$. Please **simulate** the finite sample distributions of the following two statistics:

   a. $\bar{Y}$,
   
   b. $n^{1/2} \bar{Y}$,

for each of the six combinations of $n$ and distribution:

   - $n = 10$, 50 or 100,
   
   - $Y_i \sim N(0,1)$ or $t(2)$,

by setting the number of replications to be 1000, and compare the density functions of the **simulated distributions**, generated from the Gaussian KDEs of the simulated statistics, with the density function of $N(0,1)$.

---

## 2. 

Consider the following linear regression:

$$
Y_i = X_i' \beta + e_i,
$$

where $Y_i$ is the equity premium of the $i$th month, and 

$$
X_i := (1, x\_dfy, x\_infl, x\_svar, x\_tms, x\_tbl, x\_dfr, x\_dp, x\_ltr, x\_ep, x\_bmr, x\_ntis)',
$$

for $i = 1, 2, \dots, 504$, based on the data **EquityPremium.csv**. Let $\beta_j$ be the $j$th element of $\beta$.

   a. Please check the null hypothesis:

$$
H_0 : \beta_j = 0
$$

using the Wald test at the size $\alpha = 5\%$, for each $j$, based on the asymptotic normality of the LS estimator.

   b. Please check the null hypothesis:

$$
H_0 : \beta_1 = 0 \text{ and } \beta_2 + \beta_3 = 0
$$

using the Wald test at the size $\alpha = 5\%$, based on the asymptotic normality of the LS estimator.

---

## Remark: Simulation

- Let $S_n$ be a statistic generated from a sequence of random vectors ${Y_i}_{i=1}^n$ with the sample size $n$. Assume that $S_n \xrightarrow{d} F$, as $n \rightarrow \infty$. In econometrics, it is common to evaluate the **finite-sample performance** of $S_n$ by a (**Monte Carlo**) simulation.

- **Simulation procedure**:
  1. Define a "sensible" data generating process (DGP).
  2. Set a "random seed," e.g., `set.seed(12345)` in R, before the following loop.
  3. Generate a loop that contains $B$ "independent replications" for some large $B$. In the $b$th replication,
     1. generate a sample ${Y_i(b)}_{i=1}^n$ from the DGP,
     2. generate a simulated $S_n$, denoted as $S_n(b)$, from ${Y_i(b)}_{i=1}^n$.
  4. Generate an estimate of the finite sample distribution of $S_n$, denoted as $F_n$, from ${S_n(b)}_{b=1}^B$. Compare $F_n$ with $F$ using suitable performance measures. 
