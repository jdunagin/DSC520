## Jeff Dunagin
## DSC 520
## Week 5 Exercise
## 16 January 2022

## Setting directory - to where my data is stored
setwd("C:/Users/12486/DSC520/dsc520")

## Read data
library(readxl)
housing_df <- read_excel("data/week-6-housing.xlsx")

## I'm going to just pick a few columns out of this data set to make it easier
columns <- c('Sale Price', 'zip5', 'square_feet_total_living', 'bedrooms', 
             'bath_full_count','bath_half_count', 'bath_3qtr_count',
             'year_built')
data <- housing_df[columns]

## rename column to eliminate whitespace
names(data)[names(data) == 'Sale Price'] <- 'sale_price'

## Get dplyr
library(dplyr)
library(magrittr)

## a. Use dplyr functions: GroupBy, Summarize, Mutate, Filter, Select, and Arrange

## group_by and summarise
price_by_zip <- data %>% group_by(zip5) %>% summarise(avg_price = 
                                                  mean(sale_price))
price_by_zip # is a data set showing avg price for each zip

## select and mutate
bath_data_only <- (data %>% select(bath_full_count, bath_half_count, bath_3qtr_count)
                           %>% mutate(bath_total_count = 
                                        bath_full_count +
                                        0.5*bath_half_count + 
                                        0.75*bath_3qtr_count))
bath_data_only # contains the full, half, 3/4, and total bath count for all homes

## filter
expensive <- data %>% filter(sale_price > mean(sale_price))
expensive # contains only the houses that are more expensive than the mean

## arrange
ordered <- data %>% arrange(sale_price)
ordered # house data ordered from least to greatest sale price

## b. Use purrr packages
# install.packages("purrr") - optional if purrr is not installed
library(purrr)
library(magrittr)
sale_prices <- data['sale_price']
sale_prices
## use map() to get the log base 10 of sale prices
log_prices <- sale_prices %>% map(function(x) log(x,10))
log_prices
## use every to check is sale_prices is numeric
prices_is_numeric <- sale_prices %>% every(is.numeric)
prices_is_numeric

## c. use cbind() and rbind()
library(dplyr)
a_vector <- data[['sale_price']]
b_vector <- data[['zip5']]
c_vector <- data[['bath_full_count']]
into_rows <- rbind(a_vector, b_vector, c_vector)
into_rows
into_columns <- cbind(a_vector, b_vector, c_vector)
into_columns

## d. Split a string, then concatenate the results back together
string <- 'This is my string. I am going to split and rejoin it.'
strings <- strsplit(string, ' ') # split
strings
new_string <- paste(strings[[1]], collapse = ' ') # rejoin
new_string

