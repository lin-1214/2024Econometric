library(dplyr)
library(stargazer)
library(AER)
library(lmtest)
library(sandwich)

sargan_test <- function(iv_model) {
  resid <- residuals(iv_model)
  formula_parts <- toString(iv_model$call)
  instruments <- strsplit(formula_parts, "\\|")[[1]][2]
  instruments <- trimws(instruments)
  instruments <- gsub("\\)$", "", instruments)
  instruments <- gsub(",.*$", "", instruments)
  
  model_data <- iv_model$model
  model_data$resid <- resid

  aux_reg <- lm(as.formula(paste("resid ~", instruments)), data = model_data)

  n <- length(resid)
  stat <- n * summary(aux_reg)$r.squared
  df <- 1
  p_value <- 1 - pchisq(stat, df = df)

  return(list(statistic = stat, p.value = p_value, df = df))
}

data <- read.csv("./Card1995/Card1995.csv")
print(paste("Number of observations before filtering:", nrow(data)))

data <- data %>% filter(!is.na(lwage76))
print(paste("Number of observations after filtering:", nrow(data)))

data <- data %>%
  mutate(
    experience = age76 - (ed76 + 6),
    `experience^2/100` = (experience^2) / 100,
    `age^2/100` = (age76^2) / 100
  )

model1 <- lm(lwage76 ~ experience + `experience^2/100` +
              black + reg76r + smsa76r + nearc4, data = data)

model2 <- lm(ed76 ~ experience + `experience^2/100` +
              black + reg76r + smsa76r + nearc4, data = data)

model3 <- lm(ed76 ~ black + reg76r + smsa76r + nearc4 +
              age76 + `age^2/100`, data = data)

model4 <- lm(experience ~ black + reg76r + smsa76r + nearc4 +
              age76 + `age^2/100`, data = data)

model5 <- lm(`experience^2/100` ~ black + reg76r + smsa76r + nearc4 +
              age76 + `age^2/100`, data = data)

model6 <- lm(ed76 ~ experience + `experience^2/100` +
              black + reg76r + smsa76r + nearc4a + nearc4b, data = data)

stargazer(model1, model2, model3, model4, model5, model6,
          type = "text",
          title = "Regression Results",
          keep.stat = NULL,
          report = ("vc*s"),
          digits = 3,
          omit = "(Intercept)")

OLS_model <- lm(lwage76 ~ ed76 + experience + `experience^2/100` +
                black + reg76r + smsa76r, data = data)

IVa_model <- ivreg(lwage76 ~ ed76 + experience + `experience^2/100` + black + reg76r + smsa76r | 
                   nearc4 + experience + `experience^2/100` + black + reg76r + smsa76r,
                   data = data)

IVb_model <- ivreg(lwage76 ~ ed76 + experience + `experience^2/100` + black + reg76r + smsa76r | 
                   nearc4 + age76 + `age^2/100` + black + reg76r + smsa76r,
                   data = data)

TSLSa_model <- ivreg(lwage76 ~ ed76 + experience + `experience^2/100` + black + reg76r + smsa76r | 
                     nearc4a + nearc4b + experience + `experience^2/100` + black + reg76r + smsa76r,
                     data = data)

TSLSb_model <- ivreg(lwage76 ~ ed76 + experience + `experience^2/100` + black + reg76r + smsa76r | 
                     nearc4a + nearc4b + age76 + `age^2/100` + black + reg76r + smsa76r,
                     data = data)

stargazer(OLS_model, IVa_model, IVb_model, TSLSa_model, TSLSb_model,
          type = "text",
          title = "Regression Results",
          keep.stat = NULL,
          report = ("vc*s"),
          digits = 3,
          omit = "(Intercept)",
          column.labels = c("OLS", "IV(a)", "IV(b)", "2SLS(a)", "2SLS(b)"))

sargan_a <- sargan_test(TSLSa_model)
sargan_b <- sargan_test(TSLSb_model)

cat("\nSargan Test Results:\n")
cat("2SLS(a) Model:\n")
cat("Sargan statistic:", round(sargan_a$statistic, 3), "\n")
cat("p-value:", round(sargan_a$p.value, 3), "\n\n")

cat("2SLS(b) Model:\n")
cat("Sargan statistic:", round(sargan_b$statistic, 3), "\n")
cat("p-value:", round(sargan_b$p.value, 3), "\n")