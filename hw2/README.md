# Homework: 2024/9/11

## 1.
Let $Y = (Y_1, Y_2, \dots, Y_m)'$ be a vector of random variables with the mean vector $\mu$ and the covariance matrix $\Sigma$.  
Please provide two examples to illustrate that $Y$ is not a vector of independent random variables even if $\Sigma$ is a diagonal matrix.

## 2.
Following #1, please prove that $Y$ is a vector of independent random variables if $\Sigma$ is a diagonal matrix and $Y \sim N(\mu, \Sigma)$.

## 3.
Following #2, assume that $\mu = 0$ and $\Sigma = \sigma^2 I_m$.  
Please show $\hat{E}[Y'Y] = ?$ and $\hat{E}[(Y'Y)^2] = ?$.

---

## 4.
Given the empirical example of equity premium, set $Y = y$,  
$X_1 = x.df$, $X_2 = x.tms$, and $X_3 = x.dp$.  
Let $\hat{E}[Y]$ be the sample average of $Y$, and $\hat{E}[Y | A]$ be the sample average of $Y$ given an event $A$.  
The law of iterated expectations implies:

$$
\hat{E}[Y] = \alpha_1 \hat{E}[Y | X_1 \leq 0.015] + \alpha_2 \hat{E}[Y | X_1 > 0.015]
$$

and

$$
\hat{E}[Y] = \beta_{11} \hat{E}[Y | X_1 > 0.015, X_2 > 0.02] + \beta_{12} \hat{E}[Y | X_1 > 0.015, X_2 \leq 0.02]
+ \beta_{21} \hat{E}[Y | X_1 \leq 0.015, X_2 > 0.02] + \beta_{22} \hat{E}[Y | X_1 \leq 0.015, X_2 \leq 0.02]
$$

The general form of the law of iterated expectations also implies:

$$
\hat{E}[Y | X_3 > -4] = \gamma_1 \hat{E}[Y | X_1 > 0.015, X_3 > -4] 
+ \gamma_2 \hat{E}[Y | X_1 \leq 0.015, X_3 > -4]
$$

Please report all the sample moments and coefficients shown in these three formulas. (Rounding to 3 decimal places.)

---

## 5.
Let $Y$ be a univariate random variable, and $X$ be a $k \times 1$ vector of random variables with a positive definite $\hat{E}[XX']$. Also, let $m(X) = \hat{E}[Y | X]$ be the conditional mean function of $Y | X$; that is, $m(X) = \hat{E}[Y | X]$.

Define

$$
\beta = \text{argmin}_{b} \hat{E}[(m(X) - X'b)^2]
$$

Please show that

$$
\beta = \hat{E}[XX']^{-1} \hat{E}[XY]
$$

---

## 6.
Assume that

$$
Y = \frac{1}{(1 + X^4)}
$$

where $X$ is a $t(3)$-distributed random variable. Consider a simple linear regression:

$$
Y = \beta X + e
$$

where $\beta$ is the linear projection coefficient, and $e$ is the regression error. Why do we need the degrees-of-freedom setting to define this $\beta$?  
Please show the value of $\beta$.
