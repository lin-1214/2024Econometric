# Set random seed for reproducibility
set.seed(12345)

# Function to generate data and perform chi-square test
run_simulation <- function(n, k, beta, R, theta0) {
  # Generate X matrix
  X <- matrix(rnorm(n * k), nrow = n, ncol = k)
  
  # Generate errors
  e <- rnorm(n)
  
  # Generate Y
  Y <- X %*% beta + e
  
  # Calculate unconstrained beta hat (OLS)
  XtX <- crossprod(X)
  XtY <- crossprod(X, Y)
  beta_hat <- solve(XtX, XtY)
  
  # Calculate constrained beta hat (CLS)
  M <- solve(XtX)
  RMRt <- R %*% M %*% t(R)
  beta_cls <- beta_hat - M %*% t(R) %*% solve(RMRt) %*% (R %*% beta_hat - theta0)
  
  # Calculate sigma squared
  e_hat <- Y - X %*% beta_hat
  sigma2 <- sum(e_hat^2) / (n - k)
  
  # Calculate test statistic
  diff <- R %*% beta_hat - theta0
  V <- sigma2 * (R %*% M %*% t(R))
  test_stat <- t(diff) %*% solve(V) %*% diff
  
  # Compare with chi-square critical value (df = q = 2)
  return(test_stat > qchisq(0.95, df = 2))
}

# Parameters
k <- 5
sample_sizes <- c(50, 100, 200, 500)
n_reps <- 1000

# Part a: Empirical size
beta_a <- rep(1, k)
size_results <- numeric(length(sample_sizes))

for (i in seq_along(sample_sizes)) {
  n <- sample_sizes[i]
  R <- matrix(c(1,0,0,0,0, 1,1,0,0,0), nrow=2, byrow=TRUE)
  theta0 <- c(1, 2)
  
  rejections <- replicate(n_reps, run_simulation(n, k, beta_a, R, theta0))
  size_results[i] <- mean(rejections)
}

# Part b: Empirical power
beta_b <- 1:k
power_results <- numeric(length(sample_sizes))

for (i in seq_along(sample_sizes)) {
  n <- sample_sizes[i]
  R <- matrix(c(1,0,0,0,0, 1,1,0,0,0), nrow=2, byrow=TRUE)
  theta0 <- c(1, 2)
  
  rejections <- replicate(n_reps, run_simulation(n, k, beta_b, R, theta0))
  power_results[i] <- mean(rejections)
}

# Part c: Local power
h_values <- 1:10
local_power_results <- matrix(0, nrow=length(sample_sizes), ncol=length(h_values))

for (i in seq_along(sample_sizes)) {
  n <- sample_sizes[i]
  R <- matrix(c(1,0,0,0,0, 1,1,0,0,0), nrow=2, byrow=TRUE)
  theta0 <- c(1, 2)
  
  for (j in seq_along(h_values)) {
    h <- h_values[j]
    beta_c <- rep(1 + h/sqrt(n), k)
    
    rejections <- replicate(n_reps, run_simulation(n, k, beta_c, R, theta0))
    local_power_results[i, j] <- mean(rejections)
  }
}

# Print results
cat("Empirical Size Results:\n")
for (i in seq_along(sample_sizes)) {
  cat(sprintf("n = %d: %.3f\n", sample_sizes[i], size_results[i]))
}

cat("\nEmpirical Power Results:\n")
for (i in seq_along(sample_sizes)) {
  cat(sprintf("n = %d: %.3f\n", sample_sizes[i], power_results[i]))
}

cat("\nLocal Power Results:\n")
for (i in seq_along(sample_sizes)) {
  cat(sprintf("n = %d:", sample_sizes[i]))
  cat(sprintf(" %.3f", local_power_results[i, ]))
  cat("\n")
}
