#### Preamble ####
# Purpose: Tests
# Author: ZeWei Zhou
# Date: 12 March 2024
# Contact: zewei.zhou@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(testthat)
#### Data Path ####
input_file_path_data <- here("data", "analysis_data","data.parquet")

#### Read data ####
cleaned_data <- read_parquet(input_file_path_cleaned_data)

#### Test data ####
test_that("Check class", { expect_type(cleaned_data$Program, "double") })
test_that("Check class", { expect_type(cleaned_data$Service, "double") })
test_that("Check class", { expect_type(cleaned_data$CategoryName, "double") })
test_that("Check class", { expect_type(cleaned_data$ExpenseOrRevenue,"double")})
test_that("Check class", { expect_type(cleaned_data$Amount,"double") })

test_that("Check number of observations is correct", { 
  expect_equal(nrow(cleaned_data), 1312)
})
test_that("Check complete", {
  expect_true(all(complete.cases(cleaned_data)))
})


test_that("Check coefficients", { 
  expect_gt(cleaned_data$Program[0], 0) })
test_that("Check coefficients", { 
  expect_gt(cleaned_data$Service[1], 10) })
test_that("Check coefficients", { 
  expect_gt(cleaned_data$CategoryName[2], 20) })
test_that("Check coefficients", { 
  expect_gt(cleaned_data$ExpenseOrRevenue[3], 30) })
test_that("Check coefficients", { 
  expect_gt(cleaned_data$Amount[4], 30) })









