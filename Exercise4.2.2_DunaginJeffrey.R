## Setting directory
setwd("C:/Users/12486/DSC520/dsc520")

## Install
library(readxl)
install.packages("plyr")

## Import data
housing_df <- read_excel("data/week-6-housing.xlsx")


## a. Use apply function
## I don't want to apply on columns for the whole data set, since many colunms are not
## numerical. So, I will pick out a column as an example.
apply_example <- apply(housing_df['Sale Price'], 2, mean)
apply_example # mean sale price of houses

## b. Use aggregate function
aggregate_example <- aggregate(housing_df['Sale Price'], list(housing_df$zip5), mean)
aggregate_example # mean sale price of houses for each zip code

## c. Use plyr function
library(plyr)
## reducing into a df with only sale price and zip code for each house
smaller_df <- housing_df[c('Sale Price', 'zip5')]
smaller_df['SalePrice'] <-  smaller_df['Sale Price']
smaller_df
zipcode_avgs<-ddply(smaller_df, .(zip5), summarise,
                       avg.Price=mean(SalePrice),
                       sd.Price=sd(SalePrice)

)
zipcode_avgs

## d. Check distributions of data
sale_price <- housing_df['Sale Price']
my_histogram <- function(data) {
  hist(data,
       main="Housing Prices",
       xlab="Price (Dollars)",
       freq=FALSE)
}
sale_hist <- apply(housing_df['Sale Price'], 2, my_histogram)


## e. We can see some values to the far right that appear to be outliers
max(housing_df['Sale Price'])
## The maximum value is much higher than most of the histogram, which peaks at around 
## $1000000. We can see this by simply looking at the histogram.


## f. Create at least 2 new variables
##    Going to 'total' the number of bathrooms, as well as getting the age of each
##    house using its year built.
housing_df$bath_total <- (housing_df$bath_full_count + 0.5*housing_df$bath_half_count
                          + 0.75*housing_df$bath_3qtr_count)

housing_df$years_old <- 2022 - housing_df$year_built



