# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
library(dplyr)
install.packages("nycflights13")
library(nycflights13)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
number_of_rows <- nrow(flights)
number_of_columns <- ncol(flights)
names_columns <- colnames(flights)
??flights

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- flights %>% mutate(gain_time = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, desc(gain_time))
View(head(flights))

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- flights %>% mutate(gain_time = arr_delay - dep_delay) %>% 
  arrange(desc(gain_time))

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$gain_time)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights$gain_time, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
sea <- flights %>% select(dest, origin, gain_time) %>% filter(dest == "SEA")

# On average, did flights to SeaTac gain or loose time?
summarize(jfk_sea, mean = mean(gain_time, na.rm = T))

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
jfk_sea <- flights %>% 
  filter(origin == "JFK", dest == "SEA") %>% 
  select(origin, dest, gain_time)