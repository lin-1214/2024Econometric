calculate_beta_hat <- function(y, x) {
  beta_hat <- solve(t(x) %*% x) %*% t(x) %*% y
  return(beta_hat)
}

calculate_r_squared <- function(y, y_hat) {
  TSS <- sum((y - mean(y))^2)
  RSS <- sum((y - y_hat)^2)
  return(1 - RSS / TSS)
}


# Q3 ================================================
dt <- read.csv("./Equity_Premium.csv")
y <- dt$y
ones <- rep(1, 504)
x_dfy <- dt$x_dfy
x_infl <- dt$x_infl
x_svar <- dt$x_svar
x_tms <- dt$x_tms
x_tbl <- dt$x_tbl
x_dfr <- dt$x_dfr

x <- cbind(ones, x_dfy, x_infl, x_svar, x_tms, x_tbl, x_dfr)

beta_hat <- solve(t(x) %*% x) %*% t(x) %*% y
print("beta_hat =")
print(beta_hat)

x1 <- cbind(ones, x_dfy, x_infl, x_svar)
x2 <- cbind(x_tms, x_tbl, x_dfr)

m1 <- diag(nrow(x1)) - x1 %*% solve(t(x1) %*% x1) %*% t(x1)
m2 <- diag(nrow(x2)) - x2 %*% solve(t(x2) %*% x2) %*% t(x2)

beta1 <- solve(t(m2 %*% x1) %*% m2 %*% x1) %*% (t(m2 %*% x1) %*% m2 %*% y)
beta2 <- solve(t(m1 %*% x2) %*% m1 %*% x2) %*% (t(m1 %*% x2) %*% m1 %*% y)

# Combine intercept and beta_hat_fwl
beta_hat <- matrix(c(beta1, beta2), ncol = 1)
rownames(beta_hat) <- c("ones", "x_dfy", "x_infl", "x_svar", "x_tms", "x_tbl", "x_dfr")

print("beta_hat (FWL) =")
print(beta_hat)

# Q4 ================================================
# List of x variables
x_vars <- c("ones", "x_dfy", "x_infl", "x_svar", "x_tms", "x_tbl", "x_dfr")
x <- c()
r_squared_results <- c()

# Iterate through x variables
for (var in x_vars) {
  if (var == "ones") {
    x <- cbind(x, ones)
  } else {
    x <- cbind(x, dt[[var]])
  }
  beta_hat <- calculate_beta_hat(y, x)
  y_hat <- x %*% beta_hat
  r_squared <- calculate_r_squared(y, y_hat)
  r_squared_results <- c(r_squared_results, r_squared)
}

# Print final results
print("R-squared values:")
print(r_squared_results)

# Save the plot as a PNG file
png("./img/r_squared_plot.png", width = 800, height = 600)

# Plot R-squared results
plot(seq_along(r_squared_results), r_squared_results, 
     type = "b", # Both points and lines
     xlab = "Number of Variables", 
     ylab = "R-squared",
     main = "R-squared vs Number of Variables",
     xaxt = "n") # Suppress x-axis labels initially

# Add custom x-axis labels
axis(1, at = seq_along(r_squared_results), labels = 
     seq_along(r_squared_results))

# Add variable names as text
text(seq_along(r_squared_results), r_squared_results, 
     labels = x_vars, 
     pos = 3, # Position text above the points
     cex = 0.8) # Adjust text size

# Close the PNG device
dev.off()


