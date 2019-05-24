
# Load the libraries
library(pacman)
pacman::p_load("dplyr", "data.table", "plyr", "tidyr", "ggplot2", "knitr", "ggthemes",
               "httr", "jsonlite", "xtable", "viridis", "kableExtra")

# Api endpoints
api_endpoints = list(reports    =  "https://api.ers.usda.gov/data/arms/report?",
                     categories =  "https://api.ers.usda.gov/data/arms/category?",
                     surveys    =  "https://api.ers.usda.gov/data/arms/surveydata?",
                     variables  =  "https://api.ers.usda.gov/data/arms/variable?"
)

# Api key (Public API. Feel free to use the key.)
myKey = "6RsZmKx15kBm51TuChv7rhWhZZniKf6i56db4QPt"

# Filter Definition for our Survey
filters = list(
  "year" = 2010:2017,
  "state" = "all",
  "report" = "farm Business Income Statement",
  "variable" = "incfi",
  "category" = "Production Specialty"
)

# API POST request
response = POST(
  url = api_endpoints[["surveys"]],
  add_headers("x-Api-key" = myKey),
  body = filters,
  encode = "json",
  accept_json(),
  verbose()
)

# Get status code of the request
status_code(response)

# Transform JSON response into data tables
response_body = content(response, "text", encoding = "UTF-8")
result = fromJSON(response_body)

# Make table
table = as.data.frame( result[["data"]] )
table = jsonlite::flatten(table)
table[,1:8]

# Get unique category value
unique(table[,"category_value"])

# Next Steps:
# Get Aggreate Data for : Crops and Livestocks
# Year, (Livestocks, Crops)