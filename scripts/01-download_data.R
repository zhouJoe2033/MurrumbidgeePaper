#### Preamble ####
# Purpose: Downloads and saves the data from OpenDataToronto
# Author: ZeWei Zhou
# Date: March 8, 2024
# Contact: zewei.zhou@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(httr)
library(here)

#### Download data ####
url = "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/2c90a5d3-5598-4c02-abf2-169456c8f1f1/resource/d55a2458-f116-456e-a3be-4a0d867fa190/download/approved-operating-budget-summary-2016.xlsx"

#### Save data ####
# Specify the path where the downloaded file will be saved
save_to <- here("data", "raw_data", "raw_data.xlsx")

# Download the file by sending an HTTP request GET to the url and write to the 
# disk with the specified path
GET(url, write_disk(save_to, overwrite = TRUE))

