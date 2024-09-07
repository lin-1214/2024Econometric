<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({ tex2jax: {inlineMath: [['$', '$']]}, messageStyle: "none" });
</script>

# Homework: 2024/9/4
## 1. Data Visualization
<img src="./plots/y.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_dfy.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_infl.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_svar.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_tms.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_tbl.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_dfr.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_dp.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_ltr.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_ep.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_bmr.png" width="450" height="600">
<div style="page-break-after: always;"></div>
<img src="./plots/x_ntis.png" width="450" height="600">
<div style="page-break-after: always;"></div>

## 2. 
2.1. $trace(X(X'X)^{-1}X') = 11$ (calculated by R)

2.2. $trace(I_{n} - X(X'X)^{-1}X') = 493$ (calculated by R)

![result of Q2](./img/Q2.png)

## 3. Eigenvalue Scree Plot
eigenvalues scree plot (sorted)

![eigenvalues scree plot](./plots/scree_plot.png)
<div style="page-break-after: always;"></div>

## 4. Standardized Matrix Comparison
scree plot of the eigenvalues of X̄'X̄

![eigenvalues scree plot 1](./plots/scree_plot_std1.png)
<div style="page-break-after: always;"></div>
scree plot of the eigenvalues of X̄X̄'

![eigenvalues scree plot 2](./plots/scree_plot_std2.png)

**The results imply that the eigenvalues of the two matrix are the same.**

![result of Q4](./img/Q4.png)
<div style="page-break-after: always;"></div>

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

## 7. Source Code
[Source Code](https://github.com/lin-1214/2024Econometric/blob/main/hw1/homework1.r)