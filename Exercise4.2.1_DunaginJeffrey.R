## Setting directory
setwd("C:/Users/12486/DSC520/dsc520")

## Import data
scores_df <- read.csv("data/scores.csv")

summary(scores_df)
str(scores_df)

## 1. The observational units appear to be 'count', in units of number of students;
##    and 'score', in units of points earned.

## 2. In the narrative paragraph, the variables are points earned, which is a quantitative variable
##    section, which is a categorical variable, and course grade, which is categorical.

## 3. Let's break up the data frame by section
regular_scores <-  scores_df[scores_df$Section == 'Regular',]
sports_scores <- scores_df[scores_df$Section == 'Sports',]

## 4. Plotting
library(ggplot2)
(ggplot(regular_scores) + geom_bar(aes(x=Score, y=Count, fill='Regular'), stat='identity',color='blue',
                                   fill='blue') + labs(title='Regular (Blue) and Sports (Black) Classes')

  + geom_bar(sports_scores, mapping=aes(x=Score, y=Count, fill='Sports'), stat='identity', color='black', fill='black')
)

##   a. It's hard to tell who scored more; central tendency looked similar.
##      I would want to compute some values to get a real answer. Visually it
##      is inconclusive.
##   b. No, every student from one section did not score more than every student in
##      the other section. Statistical tendency would mean that on average, students
##      from one section outscored students from another. Not every time.
##   c. One variable that could be underlying here is the GPA of the students enrolled
##      in the class. A 'sports themed' class might attract a different type of student,
##      and that difference could be reflected in their average performance in school
##      as a whole.



