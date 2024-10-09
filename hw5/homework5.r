dt <- read.csv("./Equity_Premium.csv")
y <- dt$y
ones <- rep(1, 504)
x_dfy <- dt$x_dfy
x_infl <- dt$x_infl
x_svar <- dt$x_svar
x_tms <- dt$x_tms
x_tbl <- dt$x_tbl
x_dfr <- dt$x_dfr
x_dp <- dt$x_dp
x_ltr <- dt$x_ltr

x <- cbind(ones, x_dfy, x_infl, x_svar, x_tms, x_tbl, x_dfr, x_dp, x_ltr)


# Part 1
model <- lm(y ~ (x - 1))
beta_hats <- model$coefficients;

beta_df <- data.frame(
  Estimate = beta_hats
)
rownames(beta_df) <- sub("^x", "", rownames(beta_df))
print("beta_hats:")
print(beta_df)

n <- length(y)
k <- ncol(x)

inv_xt_x <- solve(t(x) %*% x)
s_square <- sum(residuals(model)^2) / (n - k)

s_beta_hat <- sqrt(diag(s_square * inv_xt_x));
s_beta_hat_df <- data.frame(
  Estimate = s_beta_hat
)
print("s_beta_hat:")
print(s_beta_hat_df)

residuals_squared <- residuals(model)^2
v_hat <- diag(residuals_squared)
s_w_beta_hat <- sqrt(diag(inv_xt_x %*% t(x) %*% v_hat %*% x %*% inv_xt_x));
s_w_beta_hat_df <- data.frame(
  Estimate = s_w_beta_hat
)
print("s_w_beta_hat:")
print(s_w_beta_hat_df)

# Part 2
# Calculate t-statistics
t_stats <- abs(beta_hats / s_beta_hat)

# Degrees of freedom
df <- n - k

# Critical values for different significance levels
alpha_levels <- c(0.01, 0.05, 0.10)
critical_values <- qt(1 - alpha_levels / 2, df)

for (alpha in alpha_levels) {
  results <- data.frame(
    t_statistic = t_stats
  )
  critical_value <- qt(1 - alpha/2, df)
  column_name <- paste0("Reject H0 when alpha = ", alpha * 100, "%")
  results[[column_name]] <- t_stats > critical_value

  rownames(results) <- sub("^x", "", rownames(results))

  print("T test results of each significance level:")
  print(results)
}

# Part 3-(a)
std_hat <- sqrt(sum(residuals(model)^2) / n)

sk <- sum((residuals(model) / std_hat)^3) / n
kr <- sum((residuals(model) / std_hat)^4) / n

print("Skewness:")
print(sk)
print("Kurtosis:")
print(kr)

jb <- n * (sk^2 / 6 + (kr - 3)^2 / 24)
print("JB statistic:")
print(jb)

results <- data.frame(
  alpha_levels = alpha_levels
)

for (alpha in alpha_levels) {
  critical_value <- qchisq(1 - alpha, df = 2)
  results["Reject H0"] <- jb > critical_value
}

print("JB test results of each significance level:")
print(results)


# Part 3-(b)
jpeg("./img/error_distribution_comparison.jpg", width = 800, height = 600)
standardized_residuals <- residuals(model) / std_hat
kde <- density(standardized_residuals)
x_seq <- seq(min(kde$x), max(kde$x), length.out = 1000)
normal_dist <- dnorm(x_seq)


plot(kde, main = "Comparison of Error Distribution", 
     xlab = "Standardized Residuals", ylab = "Density")
lines(x_seq, normal_dist, col = "red", lty = 2)

legend("topright", legend = c("KDE", "N(0,1)"), 
       col = c("black", "red"), lty = c(1, 2))

rug(standardized_residuals)
dev.off()

