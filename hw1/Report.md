# Homework: 2024/9/4

## 1. Data Visualization
plot for y

![plot for y](./plots/y.png)

plot for x_dfy

![plot for x_dfy](./plots/x_dfy.png)

plot for x_infl

![plot for x_infl](./plots/x_infl.png)

plot for x_svar

![plot for x_svar](./plots/x_svar.png)

plot for x_tms

![plot for x_tms](./plots/x_tms.png)

plot for x_tbl

![plot for x_tbl](./plots/x_tbl.png)

plot for x_dfr

![plot for x_dfr](./plots/x_dfr.png)

plot for x_dp

![plot for x_dp](./plots/x_dp.png)

plot for x_ltr

![plot for x_ltr](./plots/x_ltr.png)

plot for x_ep

![plot for x_ep](./plots/x_ep.png)

plot for x_bmr

![plot for x_bmr](./plots/x_bmr.png)

plot for x_ntis

![plot for x_ntis](./plots/x_ntis.png)

## 2. 
2.1. $trace(X(X'X)^{-1}X') = 11$ (calculated by R)

2.2. $trace(I_{n} - X(X'X)^{-1}X') = 493$ (calculated by R)

![result of Q2](./img/Q2.png)

## 3. Eigenvalue Scree Plot
eigenvalues scree plot (sorted)

![eigenvalues scree plot](./plots/scree_plot.png)

## 4. Standardized Matrix Comparison
scree plot of the eigenvalues of X̄'X̄

![eigenvalues scree plot 1](./plots/scree_plot_std1.png)

scree plot of the eigenvalues of X̄X̄'

![eigenvalues scree plot 2](./plots/scree_plot_std2.png)

**The results imply that the eigenvalues of the two matrix are the same.**

![result of Q4](./img/Q4.png)

## 5. Spectral Decomposition and Matrix Inversion
Apply the equation

$H = \widetilde{X'}\widetilde{X}$

$A = HΛ^{-1}H'$

The result turns out AA⁻¹ = Iₖ (verified by R)


## 6. Linear Equation Solution
Since X isn't a symmetric matrix, we must apply another method to calculate b. By using the below equation, we can figure out b.

$b = \left( \widetilde{X}'\widetilde{X} \right)^{-1}\widetilde{X'}Y$

The result of b

![result of Q6](./img/Q6.png)