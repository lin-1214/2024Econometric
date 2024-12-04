dt <- read.csv("./Equity_Premium.csv")
y <- dt$y
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

png("./img/plot.png", width = 1200, height = 800, res = 100)

safe_acf <- function(x, name) {
    tryCatch({
        ts_data <- ts(as.numeric(x))
        return(acf(ts_data, lag.max = 24, plot = FALSE))
    }, error = function(e) {
        cat("Error processing", name, ":", conditionMessage(e), "\n")
        return(NULL)
    })
}

acf_list <- list()
acf_list$y <- safe_acf(y, "Equity Premium")
acf_list$dfy <- safe_acf(dfy, "Default Yield Spread")
acf_list$infl <- safe_acf(infl, "Inflation")
acf_list$svar <- safe_acf(svar, "Stock Variance")
acf_list$tms <- safe_acf(tms, "Term Spread")
acf_list$tbl <- safe_acf(tbl, "Treasury-bill Rate")
acf_list$dfr <- safe_acf(dfr, "Default Return Spread")
acf_list$dp <- safe_acf(dp, "Dividend Price Ratio")
acf_list$ltr <- safe_acf(ltr, "Long-term Return")
acf_list$ep <- safe_acf(ep, "Earnings Price Ratio")
acf_list$bmr <- safe_acf(bmr, "Book to Market")
acf_list$ntis <- safe_acf(ntis, "Net Equity Expansion")

colors <- c("#000000", "#D62728", "#1F77B4", "#2CA02C", "#9467BD", "#FF7F0E",
            "#8C564B", "#E377C2", "#7F7F7F", "#17BECF", "#BCBD22", "#FF4500")

plot(NULL, xlim = c(0, 24), ylim = c(-0.3, 1),
     xlab = "Lag", ylab = "ACF",
     main = "Sample Autocorrelation Functions",
     cex.main = 1.2,
     cex.lab = 1.1)

ci <- qnorm(0.975)/sqrt(length(y))
abline(h = c(ci, -ci), lty = 2, col = "gray50", lwd = 1.5)

variables <- list(y, dfy, infl, svar, tms, tbl, dfr, dp, ltr, ep, bmr, ntis)
names <- c("Equity Premium (y)", "Default Yield Spread (dfy)", "Inflation (infl)", 
          "Stock Variance (svar)", "Term Spread (tms)", "Treasury-bill Rate (tbl)",
          "Default Return Spread (dfr)", "Dividend Price Ratio (dp)", 
          "Long-term Return (ltr)", "Earnings Price Ratio (ep)",
          "Book to Market (bmr)", "Net Equity Expansion (ntis)")

valid_acfs <- 0
valid_names <- character(0)
for(i in seq_along(acf_list)) {
    if(!is.null(acf_list[[i]])) {
        lines(acf_list[[i]]$lag, acf_list[[i]]$acf, 
              col = colors[i], 
              lwd = 2)
        valid_acfs <- valid_acfs + 1
        valid_names <- c(valid_names, names[i])
    }
}

if(valid_acfs > 0) {
    legend("topright", 
           legend = valid_names,
           col = colors[1:valid_acfs],
           lty = 1, 
           lwd = 2,
           cex = 0.8,
           bg = "white",
           box.lwd = 1)
}

for(i in seq_along(variables)) {
    bp_12 <- Box.test(variables[[i]], lag = 12, type = "Box-Pierce")
    bp_24 <- Box.test(variables[[i]], lag = 24, type = "Box-Pierce")
    
    cat("\nBox-Pierce test results for", names[i], ":\n")
    cat("m=12: Q =", round(bp_12$statistic, 2), 
        ", p-value =", round(bp_12$p.value, 4), "\n")
    cat("m=24: Q =", round(bp_24$statistic, 2), 
        ", p-value =", round(bp_24$p.value, 4), "\n")
}

dev.off()

