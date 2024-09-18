# Homework: 2024/09/18

## 1. 
Let $X$ be a $n \times k$ matrix of random variables with a positive definite $X'X$. Denote

$$
P := X (X' X)^{-1} X'
$$
and 
$$
M := I_n - P.
$$

Please show:
- (a) $\text{trace}(P) = ? \text{trace}(M) = ?$
- (b) $P$ and $M$ are positive semi-definite.

---

## 2.
Let $\{ Y_i \}$ be an IID sequence with a finite variance $\sigma_Y^2$. Denote

$$
\hat{\sigma}_Y^2 := \frac{1}{n} \sum_{i=1}^{n} (Y_i - \bar{Y})^2,
$$
where $\bar{Y} := \frac{1}{n} \sum_{i=1}^{n} Y_i$. Please show the bias:

$$
E[\hat{\sigma}_Y^2] - \sigma_Y^2.
$$

---

## 3.
Suppose that we are interested in estimating the following linear regression:

$$
Y_i = X_i' \beta + e_i,
$$
using the LS method, in which $Y_i$ is the equity premium of the $i$-th month, and $X_i$ is a $7 \times 1$ vector of regressors of the $i$-th month:

$$
X_i := (1, x\_dfy, x\_infl, x\_svar, x\_tms, x\_tbl, x\_dfr)'.
$$

for $i = 1, 2, \dots, 504$, based on the data `Equity.Premium.csv`.

- (a) Please compute the LS estimate of $\beta$ using the formula

$$
\hat{\beta} = (X'X)^{-1} (X'Y).
$$

- (b) Please compute the LS estimate of $\beta$ using the FWL theorem.

---

## 4.
Following #3, we define:

- $X_{1, i} := 1$,
- $X_{2, i} := (1, x\_dfy)'$,
- $X_{3, i} := (1, x\_dfy, x\_infl)'$,
- $X_{4, i} := (1, x\_dfy, x\_infl, x\_svar)'$,
- $X_{5, i} := (1, x\_dfy, x\_infl, x\_svar, x\_tms)'$,
- $X_{6, i} := (1, x\_dfy, x\_infl, x\_svar, x\_tms, x\_tbl)'$,
- $X_{7, i} := (1, x\_dfy, x\_infl, x\_svar, x\_tms, x\_tbl, x\_dfr)'$,

and consider a set of linear regressions:

$$
Y_i = X_{j, i}' \beta_j + e_{j, i},
$$

for $j = 1, 2, \dots, 7$. Please report the centered $R^2$ of these regressions.
