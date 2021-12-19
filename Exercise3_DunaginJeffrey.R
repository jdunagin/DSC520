## DSC 520
## Exercise 3.2
## Jeff Dunagin


## Where am I?
getwd()

## Set the directory
setwd('../data')

## Reading in the data
data <- read.csv('acs-14-1yr-s0201.csv')

## Check it out:
summary(data)
## i. Elements in data: Id (character), Id2 (integer), Geography (character),
##    PopGroupID (integer), POPGROUP.display.label (character),
##    RacesReported (integer), HSDegree (numeric), BackDegree (numeric)

## ii. The following outputs:
str(data) ## see output (similar to answer for i.)
nrow(data) ## 136
ncol(data) ## 8

# Installing
install.packages("pastecs")
library(pastecs)

## Loading ggplot2
library(ggplot2)
theme_set(theme_minimal())

## iii. Histogram!
ggplot(data, aes(HSDegree)) + geom_histogram(bins=20) +
  ggtitle('Percentage with HS Degree') + xlab('Percentage of People') + 
  ylab('Number of Counties')

## iv. Questions:
##     1. Looks unimodal: there is only one peak.
##     2. This is not symmetrical, one tail is longer.
##     3. The one peak looks kind of bell shaped, but again its not symmetric.
##     4. A normal distribution must be symmetric; the tails are not symmetric.
##        I would say this makes it NOT normal.
##     5. This is NEGATIVELY skewed.
##     6. Plotting histogram with normal distribution laid over.
##        I am using the mean and std of the data to get the normal curve.
##        Changing the y-axis to density to match up with the normal distribution.
ggplot(data, aes(HSDegree)) + geom_histogram(bins=10, aes(y=..density..)) + ggtitle('Percentage with HS Degree') + xlab('Percentage of People') + 
  ylab('Relative Number of Counties') +
  stat_function(fun = dnorm, args = c(mean = mean(data$HSDegree), sd = sd(data$HSDegree)))
  

##     7. As noted above, the asymmetry gives this trouble. If the curve was
##        shifted maybe the left tail would match. I wouldn't model it with a normal distribution. 


## v. Probability plot:   Using a Q-Q plot
qqnorm(data$HSDegree); qqline(data$HSDegree)


## vi. Questions:
##     1. Not normal, it doesn't fit the line very well, particularly on the negative end.
##     2. This is negatively skewed. You can see the data under the line for the negative theoretical values.


## vii. Quantify the stats!
stat.desc(data$HSDegree, basic=FALSE, desc=FALSE, norm=TRUE, p=0.95)
## Here's what the output looks like:
## skewness      skew.2SE      kurtosis      kurt.2SE    normtest.W 
## -1.674767e+00 -4.030254e+00  4.352856e+00  5.273885e+00  8.773635e-01 
## normtest.p 
## 3.193634e-09 

## viii. Describing the skew, kurtosis, and z-scores:
##       Skew - the skew.2SE criteria determines if the skew is significantly
##              different than zero. If skew.2SE > 1, the skew is significant.
##              Since the value is -4.03, we can say it is negatively skewed.
##       Kurtosis - This value measures how large the tails are. A standard normal
##              distribution has a kurtosis of 3. This has a kurtosis of 4.3, meaning
##              it has larger tails.
##       z-scores - the p value given by normtest.p here is very low. This indicates
##               that it is very likely this is not a normal distribution.
##       A larger sample size would likely not fix this. The reason being that there is 
##       a fundamental limit to how far the right tail can go. It can't exceed 100,
##       so the only way to get symmetry would be to drop the mean lower. Still, the tails
##       might end up too short. The boundaries of this problem make it so this data set
##       is not from a normal distribution.