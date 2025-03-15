#install package required to select data
install.packages("tidyverse")
require(tidyverse)

#Read the .csv file and save it to a variable called "scoobydoo"
library(readr)
scoobydoo <- read_csv("scoobydoo.csv")

#Display the variable scoobydoo
View(scoobydoo)

#View the data types of each column
str(scoobydoo)

# 1. Demonstrate how to work with integers -------------------------------------------------------------------------

#Change the "imdb" column data type to integer
scoobydoo$run_time <- as.integer(scoobydoo$run_time)

#Display the sum of all the elements of colum run_time
scoobydoo %>%
  select(run_time) %>%
  summarise(sum(run_time))


# 2. Demonstrate how to work with numeric -------------------------------------------------------------------------

#Change the "imdb" column data type to numeric 
scoobydoo$imdb <- as.numeric(scoobydoo$imdb)

#Display the average of all the elements of colum imdb
scoobydoo %>%
  select(imdb) %>% 
  na.omit() %>%   #Omit empty elements
  summarise(mean(imdb))


# 3. Demonstrate how to work with logical/boolean -----------------------------------------------------------------

#Change the "monster_real" column data type to logical/boolean
scoobydoo$monster_real <- as.logical(scoobydoo$monster_real)

#Display the chapter title where the monster is real
scoobydoo %>%
  select(title, monster_real) %>% 
  filter(monster_real == TRUE)


# 4. Demonstrate how to work with character -----------------------------------------------------------------------

#Change the "series_name" column to upper case
scoobydoo$series_name <- str_to_upper(scoobydoo$series_name)

#Display the different series_name values in upper case
scoobydoo %>%
  select(c(series_name)) %>%
  distinct()


# 5. Demonstrate how to work with a list --------------------------------------------------------------------------

#Create a list that includes all the monster names, if they are real, and the length in minutes of the chapter
list <- list(scoobydoo$monster_name,
             as.logical(scoobydoo$monster_real),
             scoobydoo$run_time,
             as.numeric(scoobydoo$imdb))
View(list)

#Assign a name to each column
names(list) <- c("Monster name", "Real monster", "Length", "Rating")

#View the structure of the list
str(list)

#Display the first element of the list (which is another list)
list[[1]]

#Loop through the list and print only the  real monsters
for (x in c(1 : length(list[[2]]))) {
  if (is.na(list[[2]][[x]]) == FALSE & list[[2]][[x]] == TRUE){
    print(list[[1]][[x]])
  }
}


#Dataframe display ------------------------------------------------------------------------------------------------
#Declare the dataframe with the same columns as the list
sample_dataframe <- data.frame(
  Monster_name = list[1],
  Real_monster = list[2],
  Length       = list[3],
  Rating       = list[4]
)

print(sample_dataframe)


#Write .csv file --------------------------------------------------------------------------------------------------
write.csv(sample_dataframe, "sample_dataframe.csv")
print(read.csv("sample_dataframe.csv"))






