dt <- read.csv("./Equity_Premium.csv")
dfy <- dt$x_dfy
infl <- dt$x_infl
svar <- dt$x_svar
tms <- dt$x_tms
tbl <- dt$x_tbl
dfr <- dt$x_dfr
dp <- dt$x_dp
ltr <- dt$x_ltr
ep <- dt$ep
bmr <- dt$x_bmr
ntis <- dt$x_ntis

# Initialize all periods as bear markets (y = 1)
y <- rep(1, nrow(dt))

# Define bull market periods (y = 0)
# Converting dates to indices (assuming monthly data from 1981)
bull_periods <- list(
  c(20:80),     # August 1982 to August 1987
  c(84:231),    # December 1987 to March 2000
  c(249:252),   # September 2001 to January 2002
  c(262:322),   # October 2002 to October 2007
  c(339:470),   # March 2009 to February 2020
  c(471:492),   # March 2020 to January 2022
  c(502:504)    # October 2022 to December 2022
)

# Mark bull market periods as 0
for(period in bull_periods) {
  y[period] <- 0
}

x <- cbind(1, dfy, infl, svar, tms, tbl, dfr, dp, ltr, ep, bmr, ntis)

# First get initial values using linear probability model
lpm <- lm(y ~ x - 1)
init_values <- coef(lpm)

# Negative log-likelihood functions
probit_nll <- function(beta) {
    xb <- x %*% beta
    p <- pnorm(xb)
    # Avoid log(0)
    p[p < 1e-10] <- 1e-10
    p[p > 1-1e-10] <- 1-1e-10
    -sum(y * log(p) + (1-y) * log(1-p))
}

logit_nll <- function(beta) {
    xb <- x %*% beta
    p <- 1/(1 + exp(-xb))
    # Avoid log(0)
    p[p < 1e-10] <- 1e-10
    p[p > 1-1e-10] <- 1-1e-10
    -sum(y * log(p) + (1-y) * log(1-p))
}

# Fit models using optim
probit_fit <- optim(init_values, probit_nll, method = "BFGS",
                    control = list(maxit = 1000))
logit_fit <- optim(init_values, logit_nll, method = "BFGS",
                   control = list(maxit = 1000))

# Check convergence
cat("\nProbit convergence:", probit_fit$convergence == 0)
cat("\nLogit convergence:", logit_fit$convergence == 0)

cat("\n")

# Get predicted probabilities
probit_pred <- pnorm(x %*% probit_fit$par)
logit_pred <- 1 / (1 + exp(-x %*% logit_fit$par))
lpm_pred <- x %*% init_values

# Plot results
png("./img/plot.png", width = 800, height = 600)
plot(probit_pred, type = "l", col = adjustcolor("red", alpha=0.5), ylim = c(0, 1),
     main = "Predicted Probabilities of Bear Market",
     xlab = "Time", ylab = "Probability", lwd = 2)
lines(logit_pred, col = adjustcolor("darkgreen", alpha=0.5), lwd = 2)
lines(lpm_pred, col = adjustcolor("blue", alpha=0.5), lwd = 2)
lines(y, col = adjustcolor("black", alpha=0.5), lwd = 2, type = "s")
legend("topright", 
       legend = c("Probit", "Logit", "Linear Prob", "Actual"),
       col = c("red", "darkgreen", "blue", "black"),
       lwd = 2,
       lty = 1)
dev.off()

# Calculate score values
probit_score <- function(beta) {
    xb <- x %*% beta
    p <- pnorm(xb)
    lambda <- dnorm(xb)/(p * (1-p))
    score <- (y - p) * lambda
    colSums(sweep(x, 1, score, "*"))
}

logit_score <- function(beta) {
    xb <- x %*% beta
    p <- 1/(1 + exp(-xb))
    score <- y - p
    colSums(sweep(x, 1, score, "*"))
}

cat("\nProbit Model Score Values:\n")
print(probit_score(probit_fit$par))
cat("\nLogit Model Score Values:\n")
print(logit_score(logit_fit$par))
