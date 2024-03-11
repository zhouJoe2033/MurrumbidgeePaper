#### Preamble ####
# Purpose: Clean the downloaded raw data
# Author: ZeWei Zhou
# Date: March 8, 2024
# Contact: zewei.zhou@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(dplyr)
library(readxl)
library(here)
library(arrow)

#### Clean data ####
input_file_path <- here("data", "raw_data", "raw_data.xlsx")
output_file_path_analysis_parquet <- here("data", "analysis_data", "cleaned_data.parquet")
output_file_path_parquet <- here("data", "analysis_data", "data.parquet")
output_file_path_csv <- here("data", "analysis_data", "cleaned_data.csv")

raw_data <- readxl::read_xlsx(input_file_path)
cleaned_data = raw_data

colnames(cleaned_data)[3] <- "CategoryName"
colnames(cleaned_data)[4] <- "ExpenseOrRevenue"
colnames(cleaned_data)[5] <- "Amount"

Program_list <- unique(cleaned_data$Program)
Service_list <- unique(cleaned_data$Service)
CategoryName_list <- unique(cleaned_data$CategoryName)
ExpenseOrRevenue_list <- unique(cleaned_data$ExpenseOrRevenue)



for(i in 1:length(cleaned_data$Program)){
  cleaned_data$Program[i] = grep(cleaned_data$Program[i], Program_list)
}
for(i in 1:length(cleaned_data$Service)){
  cleaned_data$Service[i] = grep(cleaned_data$Service[i], Service_list)
}
for(i in 1:length(cleaned_data$CategoryName)){
  cleaned_data$CategoryName[i] = grep(cleaned_data$CategoryName[i], CategoryName_list)
}
for(i in 1:length(cleaned_data$ExpenseOrRevenue)){
  cleaned_data$ExpenseOrRevenue[i] = grep(cleaned_data$ExpenseOrRevenue[i], ExpenseOrRevenue_list)
}





# cleaned_data <- 
#   raw_data |>
#   mutate(
#     Program = case_when(
#       Program == '311 Toronto' ~ 1,
#       Program == 'Affordable Housing Office' ~ 2,
#       Program == "Arena Boards of Management" ~ 3,
#       Program == "Association of Community Centres" ~ 4,
#       Program == "Auditor General's Office" ~ 5,
#       Program == "Capital & Corporate Financing" ~ 6,
#       Program == "Children's Services" ~ 7,
#       Program == "City Clerk's Office" ~ 8,
#       Program == "City Council" ~ 9,
#       Program == "City Manager's Office" ~ 10,
#       Program == "City Planning" ~ 11,
#       Program == "Court Services" ~ 12,
#       Program == "Economic Development & Culture" ~ 13,
#       Program == "Engineering & Construction Services" ~ 14,
#       Program == "Exhibition Place" ~ 15,
#       Program == "Facilities, Real Estate, Environment & Energy" ~ 16,
#       Program == "Fire Services" ~ 17,
#       Program == "Fleet Services" ~ 18,
#       Program == "Heritage Toronto" ~ 19,
#       Program == "Information & Technology" ~ 20,
#       Program == "Integrity Commissioner's Office" ~ 21,
#       Program == "Legal Services" ~ 22,
#       Program == "Long Term Care Homes & Services" ~ 23,
#       Program == "Mayor's Office" ~ 24,
#       Program == "Municipal Licensing & Standards" ~ 25,
#       Program == "Non-Program Expenditures" ~ 26,
#       Program == "Non-Program Revenues" ~ 27,
#       Program == "Office of the Chief Financial Officer " ~ 28,
#       Program == "Office of the Lobbyist Registrar" ~ 29,
#       Program == "Office of the Ombudsman" ~ 30,
#       Program == "Office of the Treasurer" ~ 31,
#       Program == "Parks, Forestry & Recreation" ~ 32,
#       Program == "Policy, Planning, Finance & Administration" ~ 33,
#       Program == "Shelter, Support & Housing Administration" ~ 34,
#       Program == "Social Development, Finance & Administration" ~ 35,
#       Program == "Solid Waste Management Services" ~ 36,
#       Program == "Theatres" ~ 37,
#       Program == "Toronto & Region Conservation Authority" ~ 38,
#       Program == "Toronto Atmospheric Fund" ~ 39,
#       Program == "Toronto Building" ~ 40,
#       Program == "Toronto Employment & Social Services" ~ 41,
#       Program == "Toronto Paramedic Services" ~ 42,
#       Program == "Toronto Parking Authority" ~ 43,
#       Program == "Toronto Police Service" ~ 44,
#       Program == "Toronto Police Services Board" ~ 45,
#       Program == "Toronto Public Health" ~ 46,
#       Program == "Toronto Public Library" ~ 47,
#       Program == "Toronto Transit Commission - Conventional" ~ 48,
#       Program == "Toronto Transit Commission - Wheel Trans" ~ 49,
#       Program == "Toronto Water" ~ 50,
#       Program == "Toronto Zoo" ~ 51,
#       Program == "Transportation Services" ~ 52,
#       Program == "Yonge-Dundas Square" ~ 53,
#       .default = as.integer(Program)
#     ), 
#     Service = case_when(
#       match(Service, Service_list) ~ grep(Service, Service_list),
#       is.na(Service_list) ~ 0,
#     )
#   ) |>
#   select(Program, Service)






  








#### Save data ####
write_parquet(cleaned_data, sink=output_file_path_analysis_parquet)
write_parquet(data, sink=output_file_path_parquet)
write.csv(cleaned_data, output_file_path_csv)
