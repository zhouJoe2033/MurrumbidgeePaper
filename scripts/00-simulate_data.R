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


#### Data Path ####
input_file_path_data <- here("data", "analysis_data","data.parquet")
input_file_path_cleaned_data <- here("data", "analysis_data","cleaned_data.parquet")

reg_amount_program_path <- 
  here("models", "reg_amount_program_expenseOrRevenue.rds")
reg_amount_program_expenseOrRevenue_path <- 
  here("models", "reg_amount_program_expenseOrRevenue.rds")
reg_amount_program_expenseOrRevenuw_categoryName_path <- 
  here("models", "reg_amount_program_expenseOrRevenuw_categoryName.rds")
reg_amount_program_expenseOrRevenuw_categoryName_service_path <- 
  here("models", "reg_amount_program_expenseOrRevenuw_categoryName_service.rds")


#### Read data ####
cleaned_data <- read_parquet(input_file_path_cleaned_data)

reg_amount_program = readRDS(reg_amount_program_path)
reg_amount_program_expenseOrRevenue = 
  readRDS(reg_amount_program_expenseOrRevenue_path)
reg_amount_program_expenseOrRevenuw_categoryName = 
  readRDS(reg_amount_program_expenseOrRevenuw_categoryName_path)
reg_amount_program_expenseOrRevenuw_categoryName_service = 
  readRDS(reg_amount_program_expenseOrRevenuw_categoryName_service_path)


#### Simulate data ####
cleaned_data |> 
  ggplot(aes(x=Program, y=Amount, alpha=0.001)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 5, linetype = "dashed") +
  theme_classic() +
  scale_x_log10() + 
  scale_y_log10()

cleaned_data |> 
  ggplot(aes(x=CategoryName, y=Amount, alpha=0.11)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10()

cleaned_data |> 
  ggplot(aes(x=ExpenseOrRevenue, y=Amount, alpha=0.11)) +
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
    method = "glm",
    se = TRUE,
    color = "black",
    linetype = "dashed",
    formula = "y ~ x"
  )

modelsummary(
  list(
    "Program" = reg_amount_program,
    "ExpenseOrRenenu"= reg_amount_program_expenseOrRevenue,
    "CategoryName" = reg_amount_program_expenseOrRevenuw_categoryName
  ),
  fmt = 3
)


plot_predictions(reg_amount_program, 
                 condition = "Program") +
  labs(x = "Program", y = "Amount") +
  theme_classic()



pp_check(reg_amount_program) +
  theme_classic() +
  theme(legend.position = "bottom")

posterior_vs_prior(reg_amount_program) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom") +
  coord_flip()







amount_predictions <-
  predictions(reg_amount_program_expenseOrRevenue) |>
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























