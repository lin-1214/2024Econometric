# Homework: 2024/10/9

1. Consider the following linear regression: $$Y_i = X_i'\beta + e_i$$

   where $Y_i$ is the equity premium of the $i$th month, and

   $X_i' = (1, x\_dfy, x\_infl, x\_svar, x\_tms, x\_tbl, x\_dfr, x\_dp, x\_ltr)'$,

   for $i = 1, 2, ..., 504$, based on the data Equity_Premium.csv. Let $\hat{\beta}_j$ be the $j$ th element of the LS estimator $\hat{\beta}$ for $\beta$. Please report $\hat{\beta}_j$
   and the following two standard deviation estimates:

   $s(\hat{\beta}_j) = s\sqrt{[(X'X)^{-1}]_{jj}}$

   and

   $s^W(\hat{\beta}_j) = \sqrt{[\hat{V}^W]_{jj}}$

   for each $j$.

---

2. Following #1, assume that the linear regression satisfies the conditional normality assumption: $$e|X \sim N(0,\sigma^2I_n)$$.

   Please test the null hypothesis: $$H_0 : \beta_j = 0$$

   against the alternative hypothesis: $$H_a : \beta_j \neq 0$$

   using the absolute t statistic: $$|T(0)| = \left|\frac{\hat{\beta}_j}{s(\hat{\beta}_j)}\right|$$

   at the sizes: $\alpha = 1\%, 5\%,$ and $10\%$ for each $j$.

---

3. Following #1 & #2, let $\hat{e}_i := Y_i - X_i'\hat{\beta}$ be the LS residual of the regression, and $\hat{\sigma}^2 := \frac{1}{n} \sum_{i=1}^n \hat{e}_i^2$ be an estimator of $\sigma^2$.

   a. Please compute the Jarque-Bera test statistic:

      $$JB = n \left(\frac{sk^2}{6} + \frac{(kr - 3)^2}{24}\right),$$

      where $sk := \frac{1}{n} \sum_{i=1}^n (\hat{e}_i/\hat{\sigma})^3$ and $kr := \frac{1}{n} \sum_{i=1}^n (\hat{e}_i/\hat{\sigma})^4$, and test the hypothesis of conditional normality by examining whether $JB$ is greater than the $(1 - \alpha)$ quantile of $\chi^2(2)$ for $\alpha = 1\%, 5\%,$ and $10\%$.

   b. Please compare the probability density function of $N(0, 1)$ with the Gaussian kernel density estimate of the error-term distribution, which is computed by applying the $R$ command density(·) to the standardized LS residual sequence $\{\hat{e}_i/\hat{\sigma}\}_{i=1}^n$.

---
## Remarks: 
`Jarque-Bera test`

The Jarque-Bera test is a popular test for checking the hypothesis of conditional normality. It has the "asymptotic distribution:" $JB \xrightarrow{d} \chi^2(2)$, as $n \rightarrow \infty$. This test can be derived using the large-sample method that we will discuss in the next lecture.

`Kernel density estimate`

Let $f(\cdot)$ be the density function of a continuous random variable $X$.
Given a random sample ${X_i}_{i=1}^n$, the Kernel density estimator (KDE)
of $f(\cdot)$ is of the form:

$$\hat{f}(x) = \frac{1}{nh} \sum_{i=1}^n k\left(\frac{X_i - x}{h}\right),$$

where $x$ is a point in the support of $X$, $h > 0$ is the bandwidth or the
smoothing parameter, and $k(\cdot)$ a kernel function such that

1. $k(\cdot) \geq 0$;
2. $\int_{-\infty}^{\infty} k(x)dx = 1$.

It is common to set $k(\cdot)$ as the density function of a symmetric
distribution. The Gaussian KDE sets $k(\cdot)$ to be the density function of
$N(0,1)$.

Density plot in R:

- d=density(data)
- plot(d)
- Default setting:
  "Gaussian kernel + bw.nrd() implements a rule-of-thumb for
  choosing the bandwidth of a Gaussian kernel density estimator. It
  defaults to 0.9 times the minimum of the standard deviation and
  the interquartile range divided by 1.34 times the sample size to the
  negative one-fifth power (= Silverman's 'rule of thumb', Silverman
  (1986, page 48, eqn (3.31))) unless the quartiles coincide when a
  positive result will be guaranteed."