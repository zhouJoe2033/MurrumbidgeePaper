#### Workspace setup ####
library(dplyr)
library(modelsummary)
library(tidyverse)
library(ggplot2)
library(rstanarm)
library(here)
library(arrow)
library(tidybayes)
library(tidyverse)
library(marginaleffects)
#### Simulate data ####
input_file_path <- here("data", "analysis_data","cleaned_data.parquet")
input_file_path_data <- here("data", "analysis_data","data.parquet")

cleaned_data <- read_parquet(input_file_path)
data <- read_parquet(input_file_path_data)



cleaned_data |> 
  ggplot(aes(x=Program, y=Amount, alpha=0.001)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 5, linetype = "dashed") +
  theme_classic() +
  scale_x_log10() + 
  scale_y_log10()

cleaned_data |> 
  ggplot(aes(x=Service, y=Amount, alpha=0.11)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10()

cleaned_data |> 
  ggplot(aes(x=CategoryName, y=Amount, alpha=0.11)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10()











base_plot <- 
  cleaned_data |>
  ggplot(aes(x = Program, y = Amount)) +
  geom_point(alpha = 0.5) +
  labs(
    x = "Service",
    y = "Amount"
  ) +
  theme_classic()

base_plot +
  geom_smooth(
    method = "lm",
    se = TRUE,
    color = "black",
    linetype = "dashed",
    formula = "y ~ x"
  )







reg_amount_program <-
  stan_glm(
    formula = Amount ~ Program,
    data = cleaned_data,
    family = gaussian,
    prior = normal(location = 8, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(0, 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )
  # saveRDS(
  #   sim_run_data_second_model_rstanarm,
  #   file = "sim_run_data_second_model_rstanarm.rds"
  # )


  

reg_amount_program_expenseOrRevenue <-
  stan_glm(
    Amount ~ Program + ExpenseOrRevenue,
    data = cleaned_data,
    family = gaussian,
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )
reg_amount_program_expenseOrRevenuw_categoryName <-
  stan_glm(
    formula = Amount ~ Program + ExpenseOrRevenue + CategoryName,
    data = cleaned_data,
    family = gaussian,
    prior = normal(location = 8, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(0, 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

reg_amount_program_expenseOrRevenuw_categoryName_service <-
  stan_glm(
    formula = Amount ~ Program + ExpenseOrRevenue + CategoryName + Service,
    data = cleaned_data,
    family = gaussian,
    prior = normal(location = 8, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(0, 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )

modelsummary(
  list(
    "Program" = reg_amount_program,
    "ExpenseOrRenenu"= logistic_reg_amount_program_expenseOrRevenue,
    "CategoryName" = reg_amount_program_expenseOrRevenuw_categoryName
  ),
  fmt = 3
)


plot_predictions(reg_amount_program_expenseOrRevenuw_categoryName_service, condition = "Program") +
  labs(x = "Program",
       y = "Amount") +
  theme_classic()



pp_check(logistic_reg_amount_program) +
  theme_classic() +
  theme(legend.position = "bottom")

posterior_vs_prior(logistic_reg_amount_program) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom") +
  coord_flip()







amount_predictions <-
  predictions(reg_amount_program_expenseOrRevenuw_categoryName) |>
  as_tibble()

amount_predictions |>
  mutate(ExpenseOrRevenue = factor(ExpenseOrRevenue)) |>
  ggplot(aes(x = Program, y = Amount, color = ExpenseOrRevenue)) +
  stat_ecdf(geom = "point", alpha = 0.75) +
  labs(
    x = "Program",
    y = "Amount",
    color = "Expense Or Revenue"
  ) + 
  theme_classic() + 
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom")























