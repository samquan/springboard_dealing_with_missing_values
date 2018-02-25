# packages
library(dplyr)

# load data (came from https://www.kaggle.com/c/titanic/data)
df <- read.csv("titanic_original.csv")

# replace missing values in embarked with 'S'
#??? HOW DO I CHECK TO SEE IF THERE ARE ANY MORE MISSING VALUES - ASK KAREN
df$embarked <- sub("^$", "S", df$embarked)


# calculate mean of the age column and use value to populate the missing values
# ? what other ways could you have populated the missing values in the age column
# ? why would you pick any of those over the mean (or not)
mean_age <- mean(df$age, na.rm = TRUE)
df$age[which(is.na(df$age))] <- mean_age

# fill empty slots in boat column with a dummy value ('None' or 'NA')
df$boat <- sub("^$", NA, df$boat)

# make new column has_cabin_number (1 if there is a number, 0 if otherwise)
df$has_cabin_number <- df$cabin
df$has_cabin_number <- sub("^$", 0, df$has_cabin_number)
df <- df %>% 
  mutate(has_cabin_number = gsub(pattern = "A.*|B.*|C.*|D.*|E.*|F.*|G.*|H.*|I.*|J.*|K.*|L.*|M.*|N.*|O.*|P.*|Q.*|R.*|S.*|T.*|U.*|V.*|W.*|X.*|Y.*|Z.*", replacement = 1, x = has_cabin_number))

# export and uplaod to Github (include code, original CSV, clean CSV)
write.csv(df, file = "titanic_code.csv")