#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(here)
library(arrow)

#### Read data ####
input_file_path <- here("data", "analysis_data","cleaned_data.parquet")
cleaned_data <- read_parquet(input_file_path)

### Model data ####
# reg_amount_program <-
#   stan_glm(
#     formula = Amount ~ Program,
#     data = cleaned_data,
#     family = gaussian,
#     prior = normal(location = 8, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(0, 2.5, autoscale = TRUE),
#     prior_aux = exponential(rate = 1, autoscale = TRUE),
#     seed = 853
#   )
# reg_amount_program_expenseOrRevenue <-
#   stan_glm(
#     Amount ~ Program + ExpenseOrRevenue,
#     data = cleaned_data,
#     family = gaussian,
#     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     seed = 853
#   )
# reg_amount_program_expenseOrRevenuw_categoryName <-
#   stan_glm(
#     formula = Amount ~ Program + ExpenseOrRevenue + CategoryName,
#     data = cleaned_data,
#     family = gaussian,
#     prior = normal(location = 8, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(0, 2.5, autoscale = TRUE),
#     prior_aux = exponential(rate = 1, autoscale = TRUE),
#     seed = 853
#   )
# reg_amount_program_expenseOrRevenuw_categoryName_service <-
#   stan_glm(
#     formula = Amount ~ Program + ExpenseOrRevenue + CategoryName + Service,
#     data = cleaned_data,
#     family = gaussian,
#     prior = normal(location = 8, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(0, 2.5, autoscale = TRUE),
#     prior_aux = exponential(rate = 1, autoscale = TRUE),
#     seed = 853
#   )


reg_amount_program <-
  glm(
    formula = Amount ~ Program,
    data = cleaned_data
  )
reg_amount_program_expenseOrRevenue <-
  glm(
    Amount ~ Program + ExpenseOrRevenue,
    data = cleaned_data
  )
reg_amount_program_expenseOrRevenuw_categoryName <-
  glm(
    formula = Amount ~ Program + ExpenseOrRevenue + CategoryName,
    data = cleaned_data
  )
reg_amount_program_expenseOrRevenuw_categoryName_service <-
  glm(
    formula = Amount ~ Program + ExpenseOrRevenue + CategoryName + Service,
    data = cleaned_data
)

#### Save model ####
saveRDS(
  reg_amount_program,
  file = "models/reg_amount_program.rds"
)
saveRDS(
  reg_amount_program_expenseOrRevenue,
  file = "models/reg_amount_program_expenseOrRevenue.rds"
)
saveRDS(
  reg_amount_program_expenseOrRevenuw_categoryName,
  file = "models/reg_amount_program_expenseOrRevenuw_categoryName.rds"
)
saveRDS(
  reg_amount_program_expenseOrRevenuw_categoryName_service,
  file = "models/reg_amount_program_expenseOrRevenuw_categoryName_service.rds"
)

