# Set random seed for reproducibility
set.seed(12345)

B <- 1000

# Create img directory if it doesn't exist
if (!dir.exists("img")) {
  dir.create("img")
}

simulate_and_save <- function(n, dist_type) {
  y_bar <- numeric(B)
  y_bar_scaled <- numeric(B)
  
  # Generate B samples and calculate both statistics
  for(b in 1:B) {
    if(dist_type == "normal") {
      y <- rnorm(n, mean = 0, sd = 1)
    } else {
      y <- rt(n, df = 2)
    }
    
    y_bar[b] <- mean(y)
    y_bar_scaled[b] <- sqrt(n) * mean(y)
  }
  
  # Create filename
  dist_name <- ifelse(dist_type == "normal", "normal", "t2")
  filename <- file.path("img", sprintf("n%d_%s_combined.png", n, dist_name))
  
  png(filename, width = 1200, height = 500)
  
  # Set up 1x2 plotting area
  par(mfrow = c(1, 2), mar = c(5, 4, 4, 2) + 0.1)
  
  # Create standard normal density for comparison
  x_range <- seq(-6, 6, length.out = 300)
  standard_normal <- dnorm(x_range)
  
  # Plot for Y_bar
  dens1 <- density(y_bar)
  y_max1 <- max(max(dens1$y), max(standard_normal)) * 1.2
  
  dist_label <- ifelse(dist_type == "normal", "N(0,1)", "t(2)")
  plot_title1 <- sprintf("Distribution of Y_bar (n = %d, %s)", n, dist_label)
  
  plot(dens1, main = plot_title1,
       xlab = "Y_bar", 
       ylab = "Density",
       xlim = c(-6, 6),
       ylim = c(0, y_max1),
       xaxt = "n")
  
  axis(1, at = seq(-6, 6, by = 1))
  grid(nx = NULL, ny = NULL, lty = 2, col = "gray90")
  lines(dens1, lwd = 2)
  lines(x_range, standard_normal, col = "red", lty = 2, lwd = 2)
  legend("topright", c("Simulated", "N(0,1)"), 
         col = c("black", "red"), lty = c(1, 2), lwd = 2)
  
  # Plot for sqrt(n)*Y_bar
  dens2 <- density(y_bar_scaled)
  y_max2 <- max(max(dens2$y), max(standard_normal)) * 1.2
  
  plot_title2 <- sprintf("Distribution of sqrt(n)*Y_bar (n = %d, %s)", n, dist_label)
  
  plot(dens2, main = plot_title2,
       xlab = "sqrt(n)*Y_bar", 
       ylab = "Density",
       xlim = c(-6, 6),
       ylim = c(0, y_max2),
       xaxt = "n")
  
  axis(1, at = seq(-6, 6, by = 1))
  grid(nx = NULL, ny = NULL, lty = 2, col = "gray90")
  lines(dens2, lwd = 2)
  lines(x_range, standard_normal, col = "red", lty = 2, lwd = 2)
  legend("topright", c("Simulated", "N(0,1)"), 
         col = c("black", "red"), lty = c(1, 2), lwd = 2)
  
  dev.off()
  
  cat("Saved plot to:", filename, "\n")
}

# 1e5 is additional sample size
# n_values <- c(10, 50, 100, 1e5)
n_values <- c(10, 50, 100)
distributions <- c("normal", "t")

for(n in n_values) {
  for(dist in distributions) {
    dist_name <- ifelse(dist == "normal", "N(0,1)", "t(2)")
    cat("\nSimulating for n =", n, ", distribution:", dist_name, "\n")
    simulate_and_save(n, dist)
  }
}

dt <- read.csv("./Equity_Premium.csv")
y <- dt$y
ones <- rep(1, 504)
dfy <- dt$x_dfy
infl <- dt$x_infl
svar <- dt$x_svar
tms <- dt$x_tms
tbl <- dt$x_tbl
dfr <- dt$x_dfr
dp <- dt$x_dp
ltr <- dt$x_ltr
ep <- dt$x_ep
bmr <- dt$x_bmr
ntis <- dt$x_ntis

x <- cbind(ones, dfy, infl, svar, tms,
           tbl, dfr, dp, ltr, ep, bmr, ntis)


# Part 1
model <- lm(y ~ (x - 1))

# Part a: Individual Wald tests for each coefficient
coef_summary <- summary(model)$coefficients

wald_tests <- data.frame(
  Coefficient = rownames(coef_summary),
  Estimate = coef_summary[, "Estimate"],
  Std_Error = coef_summary[, "Std. Error"],
  t_value = coef_summary[, "t value"],
  p_value = coef_summary[, "Pr(>|t|)"]
)

# Print results for part a
cat("\nPart a: Individual Wald Tests (H0: βj = 0)\n")
print(wald_tests)
cat("\nSignificant coefficients at 5% level:\n")
print(wald_tests[wald_tests$p_value < 0.05, ])

# Part b: Joint Wald test for β1 = 0 and β2 + β3 = 0
library(car)

# Create constraint matrix R and vector r
R <- matrix(0, nrow = 2, ncol = length(coef(model)))
R[1, 1] = 1              # β1 = 0
R[2, 2:3] = c(1, 1)      # β2 + β3 = 0
r <- c(0, 0)

# Perform joint Wald test with custom hypothesis names
joint_test <- linearHypothesis(model, R, r)

# Print results for part b
cat("\nPart b: Joint Wald Test\n")
cat("H0: β1 = 0 and β2 + β3 = 0\n")
print(joint_test)


