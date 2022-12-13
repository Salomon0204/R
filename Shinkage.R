library(eFRED)
api_key <- "1740c3471a5b519723a2615d05c686d0"
set_fred_key(api_key)

FRED_API_KEY="1740c3471a5b519723a2615d05c686d0"
fredr_set_key("1740c3471a5b519723a2615d05c686d0")


library(fredr)
library(readr)
library(fbi)
library(BVAR)
library(psych)
library(ggplot2)
library(dtplyr)
library(dbplyr)
library(dbplyr)
library(tidyverse)

# devtools::install_github("cykbennie/fbi")


fred_md <- read_csv("data/raw_data/fred_md.csv", 
                    col_types = cols(sasdate = col_date(format = "%d/%m/%Y")))
View(fred_md)

fredr(
  series_id = "UNRATE",
  observation_start = as.Date("1990-01-01"),
  observation_end = as.Date("2000-01-01")
)  

fredr(
  series_id = "UNRATE",
  observation_start = as.Date("1990-01-01"),
  observation_end = as.Date("2000-01-01"),
  frequency = "q", # quarterly
  units = "chg" # change over previous value
)
library(dplyr)
library(ggplot2)

popular_funds_series <- fredr_series_search_text(
  search_text = "federal funds",
  order_by = "popularity",
  sort_order = "desc",
  limit = 1
)

popular_funds_series_id <- popular_funds_series$id

popular_funds_series_id %>%
  fredr(
    observation_start = as.Date("1990-01-01"),
    observation_end = as.Date("2000-01-01")
  ) %>%
  ggplot(data = ., mapping = aes(x = date, y = value, color = series_id)) +
  geom_line() +
  labs(x = "Observation Date", y = "Rate", color = "Series")



library(purrr)

map_dfr(c("UNRATE", "FEDFUNDS"), fredr) %>%
  ggplot(data = ., mapping = aes(x = date, y = value, color = series_id)) +
  geom_line() +
  labs(x = "Observation Date", y = "Rate", color = "Series")



