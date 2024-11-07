<!-- <script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script> <script type="text/x-mathjax-config"> MathJax.Hub.Config({ tex2jax: {inlineMath: [['$', '$']]}, messageStyle: "none" }); </script> -->
# Homework: 2024/11/6

## Question 1
1. Let $\{(Y_i, X_i)\}_{i=1}^n$ be an IID sequence of random variables with $\dim(Y_i) = 1$ and $\dim(X_i) = k$. Consider the following regression:

   $$
   Y_i = X_i'\beta + e_i,
   $$

   for $i = 1, 2, \dots, n$. Denote the $n \times 1$ vector $Y := (Y_1, \dots, Y_n)'$, the $n \times k$ matrix $X := (X_1, \dots, X_n)'$, and the $n \times 1$ vector $e := (e_1, \dots, e_n)'$. Assume that $\mathbb{E}[e|X] = 0$ and $\mathbb{E}[ee'|X] = \sigma^2 I_n$.

   Let $\hat{\beta}$ be the LS estimator for $\beta$, and $\hat{\beta}_{CLS}$ be the constrained LS estimator for $\beta$ under the parameter constraint:

   $$
   H_0 : R\beta = \theta_0,
   $$

   where $R$ is a $q \times k$ matrix of constants, and $\theta_0$ is a $q \times 1$ vector of constants for some $1 < q < k$.

   **a.** Please show the formula of $\hat{\beta}_{CLS}$ under $H_0$.

   **b.** Please show the asymptotic distribution of $n^{1/2}(\hat{\beta} - \hat{\beta}_{CLS})$ under $H_0$.

   **c.** Please establish an asymptotic $\chi^2$ test for $H_0$ based on the asymptotic distribution of $n^{1/2}(\hat{\beta} - \hat{\beta}_{CLS})$ under $H_0$. (Present the test statistic and show its asymptotic null distribution.)

   **d.** Please show the asymptotic distribution of this asymptotic $\chi^2$ test under the local alternative hypothesis:

   $$
   H_1 : R\beta = \theta_0 + n^{-1/2}h, \text{ for some constant } h > 0.
   $$

---

# Question 2
Following Question 1, consider the following simulation setting:

- `set.seed(12345)`
- $\{(X_i', e_i)\}_{i=1}^n$ is an IID sequence of $N(0, I_{k+1})$-distributed random vectors;
- $n = 50, 100, 200, 500$ and $k = 5$;
- 
  $$
  R = \begin{bmatrix} 1 & 0 & 0 & \dots & 0 \\ 1 & 1 & 0 & \dots & 0 \end{bmatrix}
  $$
- $\theta_0 = (1, 2)'$;
- Nominal size: $5\%$;
- Number of replications: 1000.

**a.** Please simulate the empirical size of the asymptotic $\chi^2$ test under the parameter setting: $\beta = (1, 1, 1, \dots, 1)'$ for each $n$.

**b.** Please simulate the empirical power of the asymptotic $\chi^2$ test under the parameter setting: $\beta = (1, 2, 3, \dots, k)'$ for each $n$.

**c.** Please simulate the empirical power of the asymptotic $\chi^2$ test under the parameter setting:

   $$
   \beta = (1 + n^{-1/2}h, 1 + n^{-1/2}h, \dots, 1 + n^{-1/2}h)',
   $$

   with the localizing parameter $h = 1, 2, \dots, 10$, for each $n$. 

---

