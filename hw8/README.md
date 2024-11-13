# Homework: 2024/11/13

## Problem 1

Let $\{(Y_i, X_i')\}_{i=1}^n$ be a sequence of IID random vectors that follows the normal regression:
$$
Y = X \beta + e,
$$
where $Y := (Y_1, \ldots, Y_n)'$ is an $n \times 1$ vector, $X := (X_1', \ldots, X_n')'$ is an $n \times k$ matrix, $\beta$ is a $k \times 1$ parameter vector, and the error term $e$ satisfies the conditional normality:
$$
e | X \sim N(0, \sigma^2 I_n).
$$

Also, let $\hat{\beta}$ be the LS estimator for $\beta$, and $\|\cdot\|$ be the Euclidean norm of a vector. Denote $m := X \beta$, $\hat{m} := X \hat{\beta}$, $P := X (X'X)^{-1} X'$,
$$
M := I_n - P, \quad \hat{e} := M Y, \quad s^2 := \frac{1}{n - k} \hat{e}' \hat{e}, \quad \text{and} \quad C_p := \hat{e}' \hat{e} + 2k s^2.
$$
Please show that
$$
E[C_p] = R + n \sigma^2,
$$
where
$$
R := E[\| m - \hat{m} \|^2].
$$

---

## Problem 2

Following #1, consider the partition:
$$
X \beta = X_1 \beta_1 + X_2 \beta_2,
$$
where $X_1$ is an $n \times k_1$ matrix for some $1 < k_1 < k$. Let
$$
\hat{\beta}_1 := (X_1' X_1)^{-1} X_1' Y
$$
be the LS estimator for $\beta_1$ based on the constrained regression: $Y$ on $X_1$. Denote $\hat{m}_1 := X_1 \hat{\beta}_1$,
$$
\hat{e}_1 := Y - \hat{m}_1, \quad \text{and} \quad C_{1, p} := \hat{e}_1' \hat{e}_1 + 2k_1 s^2.
$$
Please show that
$$
E[C_{1, p}] = R + n \sigma^2,
$$
where
$$
R := E[\beta_2' X_2' M_1 X_2 \beta_2] + k_1 \sigma^2.
$$

---

## Problem 3

Following #1, let $Y_i$ be the equity premium of the $i$th month, and set
$$
X_i := (1, x_{dfy}, x_{inf1}, x_{svar}, x_{tms}, x_{tbl}, x_{dfy}^2, x_{inf1}^2, x_{svar}^2, x_{tms}^2, x_{tbl}^2)',
$$
for $i = 1, 2, \ldots, 504$, based on the data: `Equity_Premium.csv`. In this empirical setting, the unconstrained regression includes $2^{11} (= 2048)$ candidate models that are determined by how the elements of $X_i$ are selected.

Suppose that we are interested in selecting the "best model" from the candidate models using the following model selection methods:

1. Centered $R^2$ (Lecture 2),
2. Adjusted $R^2$ (Lecture 2),
3. AIC,
4. BIC,
5. Mallows' $C_p$,
6. LOO-CV.

Please plot the model selection statistics (of all the candidate models), and show the models selected by these methods.
