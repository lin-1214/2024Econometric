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
    
    if(criteria_names[i] %in% c("AIC", "BIC", "Cp")) {
        Q1 <- quantile(current_values, 0.25)
        Q3 <- quantile(current_values, 0.75)
        IQR <- Q3 - Q1
        lower_bound <- Q1 - 1.5 * IQR
        upper_bound <- Q3 + 1.5 * IQR
        
        valid_points <- current_values >= lower_bound & current_values <= upper_bound
        valid_values <- current_values[valid_points]
        valid_indices <- which(valid_points)
        best_idx <- valid_indices[which.min(valid_values)]
        
        ylim_range <- range(current_values[valid_points])
        
        x_coords <- results_df$n_predictors[valid_points]
        
        plot(x_coords, valid_values,
             main = paste(criteria_names[i], "vs Number of Predictors"),
             xlab = "", 
             ylab = "Criterion Value",
             pch = 16,      
             col = "gray",
             ylim = ylim_range)
             
        points(results_df$n_predictors[best_idx], current_values[best_idx], 
               col = "red", pch = 16, cex = 2)
        points(results_df$n_predictors[best_idx], current_values[best_idx], 
               col = "red", pch = 1, cex = 3)
    } else {
        x_coords <- results_df$n_predictors
        
        plot(x_coords, current_values,
             main = paste(criteria_names[i], "vs Number of Predictors"),
             xlab = "", 
             ylab = "Criterion Value",
             pch = 16,      
             col = "gray")
             
        if(criteria_names[i] %in% c("R2", "adj_R2")) {
            best_idx <- which.max(current_values)
            legend_pos <- "bottomright"
        } else if(criteria_names[i] %in% c("AIC", "BIC", "Cp")) {
            current_values <- criteria_results[,i]
            Q1 <- quantile(current_values, 0.25)
            Q3 <- quantile(current_values, 0.75)
            IQR <- Q3 - Q1
            lower_bound <- Q1 - 1.5 * IQR
            upper_bound <- Q3 + 1.5 * IQR
            
            valid_points <- current_values >= lower_bound & current_values <= upper_bound
            valid_values <- current_values[valid_points]
            valid_indices <- which(valid_points)
            best_idx <- valid_indices[which.min(valid_values)]
            legend_pos <- "topright"
        } else {
            best_idx <- which.min(current_values)
            legend_pos <- "topright"
        }
        
        points(results_df$n_predictors[best_idx], current_values[best_idx], 
               col = "red", pch = 16, cex = 2)
        points(results_df$n_predictors[best_idx], current_values[best_idx], 
               col = "red", pch = 1, cex = 3)
    }
    
    axis(1, at = unique(results_df$n_predictors))
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
    } else if(criteria_names[i] %in% c("AIC", "BIC", "Cp")) {
        # Filter outliers first
        current_values <- criteria_results[,i]
        Q1 <- quantile(current_values, 0.25)
        Q3 <- quantile(current_values, 0.75)
        IQR <- Q3 - Q1
        lower_bound <- Q1 - 1.5 * IQR
        upper_bound <- Q3 + 1.5 * IQR
        
        valid_points <- current_values >= lower_bound & current_values <= upper_bound
        valid_values <- current_values[valid_points]
        valid_indices <- which(valid_points)
        best_idx <- valid_indices[which.min(valid_values)]
    } else {
        best_idx <- which.min(criteria_results[,i])
    }
    cat("\n", criteria_names[i], ":\n")
    print(all_combinations[[best_idx]])
}