dt <- read.csv("./Equity_Premium.csv")
y <- dt$y
ones <- rep(1, 504)
dfy <- dt$x_dfy
infl <- dt$x_infl
svar <- dt$x_svar
tms <- dt$x_tms
tbl <- dt$x_tbl
dfy_squared <- dfy^2
infl_squared <- infl^2
svar_squared <- svar^2
tms_squared <- tms^2
tbl_squared <- tbl^2

x <- cbind(ones, dfy, infl, svar, tms, tbl,
           dfy_squared, infl_squared, svar_squared, tms_squared, tbl_squared)

calculate_criteria <- function(y, X, full_sigma2 = NULL) {
    n <- length(y)
    k <- ncol(X)
    beta_hat <- solve(t(X) %*% X) %*% t(X) %*% y
    y_hat <- X %*% beta_hat
    e_hat <- y - y_hat
    ESS <- sum(e_hat^2)
    TSS <- sum((y - mean(y))^2)
    R2 <- 1 - ESS/TSS
    adj_R2 <- 1 - (ESS/(n-k))/(TSS/(n-1))
    AIC <- n * log(ESS/n) + 2*k
    BIC <- n * log(ESS/n) + k*log(n)
    Cp <- ESS + 2*k*full_sigma2
    H <- X %*% solve(t(X) %*% X) %*% t(X)
    h_ii <- diag(H)
    LOOCV <- mean((e_hat/(1-h_ii))^2)
    return(c(R2=R2, adj_R2=adj_R2, AIC=AIC, BIC=BIC, Cp=Cp, LOOCV=LOOCV))
}

library(gtools)
predictors <- c("ones", "dfy", "infl", "svar", "tms", "tbl",
                "dfy_squared", "infl_squared", "svar_squared", "tms_squared", "tbl_squared")
n_pred <- length(predictors)
all_combinations <- list()
criteria_results <- matrix(NA, nrow=2^n_pred, ncol=6)
colnames(criteria_results) <- c("R2", "adj_R2", "AIC", "BIC", "Cp", "LOOCV")

X_full <- x
full_model <- lm(y ~ X_full - 1)
full_sigma2 <- sum(full_model$residuals^2)/(length(y)-ncol(X_full))

for(i in 1:2^n_pred) {
    binary <- as.numeric(intToBits(i-1)[1:n_pred])
    selected <- binary == 1
    if(sum(selected) == 0) next
    X_subset <- x[, selected]
    criteria_results[i,] <- calculate_criteria(y, X_subset, full_sigma2)
    all_combinations[[i]] <- colnames(x)[selected]
}

valid_models <- !is.na(criteria_results[,1])
criteria_results <- criteria_results[valid_models,]
all_combinations <- all_combinations[valid_models]

results_df <- data.frame(
    n_predictors = sapply(all_combinations, length),
    model_index = seq_along(all_combinations),
    criteria_results
)

results_df <- results_df[order(results_df$n_predictors), ]

dir.create("img", showWarnings = FALSE)

criteria_names <- colnames(criteria_results)
for(i in 1:6) {
    png(filename = sprintf("img/%s_plot.png", criteria_names[i]),
        width = 1000, height = 600)  
    
    par(mar = c(4.1, 4.1, 4.1, 2.1))
    
    current_values <- results_df[, i+2]
    
    if(criteria_names[i] %in% c("AIC", "BIC")) {
        Q1 <- quantile(current_values, 0.25)
        Q3 <- quantile(current_values, 0.75)
        IQR <- Q3 - Q1
        lower_bound <- Q1 - 1.5 * IQR
        upper_bound <- Q3 + 1.5 * IQR
        
        valid_points <- current_values >= lower_bound & current_values <= upper_bound
        ylim_range <- range(current_values[valid_points])
        
        plot(seq_along(current_values)[valid_points], 
             current_values[valid_points],
             main = paste(criteria_names[i], "vs Number of Predictors"),
             xlab = "", 
             ylab = "Criterion Value",
             xaxt = "n",
             pch = 16,      
             col = "gray",
             ylim = ylim_range)
    } else {
        plot(current_values,
             main = paste(criteria_names[i], "vs Number of Predictors"),
             xlab = "", 
             ylab = "Criterion Value",
             xaxt = "n",
             pch = 16,      
             col = "gray")
    }
    
    abline(v = which(diff(results_df$n_predictors) != 0), 
           col = "lightgray", lty = 2)
    
    if(criteria_names[i] %in% c("R2", "adj_R2")) {
        best_idx <- which.max(results_df[, i+2])
        legend_pos <- "bottomright"
    } else {
        best_idx <- which.min(results_df[, i+2])
        legend_pos <- "topright"
    }
    
    if(criteria_names[i] %in% c("AIC", "BIC")) {
        if(current_values[best_idx] >= lower_bound && 
           current_values[best_idx] <= upper_bound) {
            points(best_idx, current_values[best_idx], 
                   col = "red", pch = 16, cex = 2)
            points(best_idx, current_values[best_idx], 
                   col = "red", pch = 1, cex = 3)
        }
    } else {
        points(best_idx, current_values[best_idx], 
               col = "red", pch = 16, cex = 2)
        points(best_idx, current_values[best_idx], 
               col = "red", pch = 1, cex = 3)
    }
    
    unique_n_pred <- unique(results_df$n_predictors)
    pred_positions <- sapply(unique_n_pred, function(n) {
        mean(which(results_df$n_predictors == n))
    })
    axis(1, at = pred_positions, labels = unique_n_pred)
    
    mtext("Number of Predictors", side = 1, line = 2.5)
    
    legend(legend_pos, 
           legend = c("All models", 
                     sprintf("Best model (%d predictors)", 
                            results_df$n_predictors[best_idx])),
           pch = c(16, 16),
           pt.cex = c(1, 2),
           col = c("gray", "red"),
           bg = "white",
           box.col = "black",
           inset = 0.02)
    
    dev.off()
}

cat("Best models:\n")
for(i in 1:6) {
    if(criteria_names[i] %in% c("R2", "adj_R2")) {
        best_idx <- which.max(criteria_results[,i])
    } else {
        best_idx <- which.min(criteria_results[,i])
    }
    cat("\n", criteria_names[i], ":\n")
    print(all_combinations[[best_idx]])
}