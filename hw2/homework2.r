# Q4 =====================================================
dt <- read.csv("./Equity_Premium.csv")
time <- dt$Time
y <- dt$y
x_dfy <- dt$x_dfy # x1
x_tms <- dt$x_tms # x2
x_dp <- dt$x_dp # x3

n = length(y)

# (a)
alpha_2 <- sum(x_dfy > 0.015) / n
alpha_1 <- 1 - alpha_2
paste("alpha_1 =", round(alpha_1, 3))
paste("alpha_2 =", round(alpha_2, 3))

# (b)
beta_11 <- sum((x_dfy > 0.015) & (x_tms > 0.02)) / n
beta_12 <- sum((x_dfy > 0.015) & (x_tms <= 0.02)) / n
beta_21 <- sum((x_dfy <= 0.015) & (x_tms > 0.02)) / n
beta_22 <- sum((x_dfy <= 0.015) & (x_tms <= 0.02)) / n
paste("beta_11 =", round(beta_11, 3))
paste("beta_12 =", round(beta_12, 3))
paste("beta_21 =", round(beta_21, 3))
paste("beta_22 =", round(beta_22, 3))

# (c)
gamma_1 <- sum((x_dfy > 0.015) & (x_dp > -4)) / sum(x_dp > -4)
gamma_2 <- 1 - gamma_1
paste("gamma_1 =", round(gamma_1, 3))
paste("gamma_2 =", round(gamma_2, 3))

# Q6-2 =====================================================
x <- rt(1e5, df = 3)
y <- 1 / (1 + x^4)

# (b)
model <- lm(y ~ x)
beta <- model$coefficients[2]

# e_xy <- mean(x * y)
paste("beta =", beta)
# paste("approximate beta =", e_xy / (3 / (3 - 2)))
