# Homework: 2024/9/4

## 1. Data Visualization
Plot the time-series and the histograms (with the estimated normal density functions) of y and the x's.

## 2. Matrix Trace Properties
Given the same size n and the X defined in this running example, show:
2.1. trace(X(X'X)⁻¹X') = ? 

2.2. trace(Iₙ - X(X'X)⁻¹X') = ?

## 3. Eigenvalue Scree Plot
Following #2, let λⱼ be an eigenvalue of X'X, for j = 1, 2, ..., k. Show the "scree plot" of the eigenvalues. (The horizontal axis is j, and the vertical axis is λⱼ).

## 4. Standardized Matrix Comparison
Following #3, let X̄ be an n × k matrix. The j-th column of X̄ is defined by "standardizing" the j-th column of X, with the sample mean 0 and the sample variance 1, for each j. Compare the scree plot of the eigenvalues of X̄'X̄ with that of X'X.

## 5. Spectral Decomposition and Matrix Inversion
Following #4, compute A = (X̄'X̄)⁻¹ using the spectral decomposition and verify that AA⁻¹ = Iₖ.

## 6. Linear Equation Solution
Following #5, let y be an n × 1 vector. The i-th element of y corresponds to the i-th observation of y, for i = 1, 2, ..., n. Consider the linear equation:

y = X̄b̂

where b̂ is a k × 1 vector. Show b̂ = ?
