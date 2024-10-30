<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script> <script type="text/x-mathjax-config"> MathJax.Hub.Config({ tex2jax: {inlineMath: [['$', '$']]}, messageStyle: "none" }); </script>
# Homework: 2024/10/30

## 1. 
#### Result for $n = 10$
<img src="./img/n10_normal_combined.png" width="600" alt="Result for n = 10, N(0, 1) distribution">

<img src="./img/n10_t2_combined.png" width="600" alt="Result for n = 10, t(2) distribution">
<div style="page-break-after: always;"></div>

#### Result for $n = 50$
<img src="./img/n50_normal_combined.png" width="600" alt="Result for n = 50, N(0, 1) distribution">

<img src="./img/n50_t2_combined.png" width="600" alt="Result for n = 50, t(2) distribution">
<div style="page-break-after: always;"></div>

#### Result for $n = 100$
<img src="./img/n100_normal_combined.png" width="600" alt="Result for n = 100, N(0, 1) distribution">

<img src="./img/n100_t2_combined.png" width="600" alt="Result for n = 100, t(2) distribution">

By these simulations, we can see that the distribution of $n^{1/2} \bar{Y}$ is closer to the normal distribution than the distribution of $\bar{Y}$ for both $N(0, 1)$ and $t(2)$ distributions.

As the sample size $n$ increases, we can see there's a peak at the center of the density function of $\bar{Y}$, this is because the variance of $\bar{Y}$ decreases as $n$ increases.

Comparing the density functions of $n^{1/2} \bar{Y}$ when applying $N(0, 1)$ and $t(2)$ distributions, we can see that when applying $N(0, 1)$ distribution, the density function of $n^{1/2} \bar{Y}$ is more similar to the normal distribution. But when $n$ goes to infinity, both of the density function will be like the distribution of $N(0, 1)$ according to the central limit theorem.

---
<div style="page-break-after: always;"></div>

## 2.
#### Result of individual Wald tests

<img src="./img/q2-1.png" width="600" alt="Result of individual Wald tests for n = 10, N(0, 1) distribution">

According to the result of individual Wald tests, we can see that the p-values of intercept, tbl, xdp are less than 0.05, which means we can reject the null hypothesis of these coefficients.

#### Result of joint Wald tests
<img src="./img/q2-2.png" width="600" alt="Result of individual Wald tests for n = 50, N(0, 1) distribution">

According to the result of joint Wald tests, we can see that the p-value is less than 0.05, which means we can reject the null hypothesis. The statistical meaning of this result is we reject that $\beta_{1} = 0$ and (or) $\beta_{2} + \beta_{3} = 0$ at 5% significance level. We can see the result is aligned to the result of individual Wald tests of $\beta_{1}$. 

---
<div style="page-break-after: always;"></div>

## 3. Source Code
[Source Code](https://github.com/lin-1214/2024Econometric/blob/main/hw6/homework6.r)