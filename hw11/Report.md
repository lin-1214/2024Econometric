<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script> <script type="text/x-mathjax-config"> MathJax.Hub.Config({ tex2jax: {inlineMath: [['$', '$']]}, messageStyle: "none" }); </script>

# Homework: 2024/12/04

## 1. Prove the asymptotic distribution of $T\hat{\rho}^2(k)$

<img src="img/p1.jpg" alt="p1" width="500">

## 2. Prove the asymptotic distribution of Box-Pierce statistic

<img src="img/p2.jpg" alt="p2" width="500">

## 3. Plot the sample autocorrelation function and test the null of IIDness for each of the 12 time series

`Plot of sample autocorrelation function`

<img src="img/plot.png" alt="p3-1" width="500">

<div style="page-break-after: always;"></div>

`Test the null of IIDness for each of the 12 time series`

<img src="img/p3.png" alt="p3" width="500">

We can see that the Box-Pierce statistic implies that the null of IIDness is rejected for most of the time series. For dfr & ltr, the null of IIDness is not rejected at 5% level, which implies that these two time series are IID. And for y, the null of IIDness is rejected when m=12, but not when m=24.

## 4. Source Code

[Source Code](https://github.com/lin-1214/2024Econometric/blob/main/hw11/homework11.r)
