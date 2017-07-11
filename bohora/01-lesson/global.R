ds_health <- readRDS("healthexp.Rds")
ds_health$Region <- as.factor(ds_health$Region)
ds_health[, "Life Expectancy"] <- as.numeric(ds_health$Life.Expectancy)
ds_health[, "Health Expenditure"] <- as.numeric(ds_health$Health.Expenditure)
ds_health$Life.Expectancy <- NULL
ds_health$Health.Expenditure <- NULL

numeric_columns <- names(ds_health)[sapply(ds_health, function(x) is.numeric(x))]
