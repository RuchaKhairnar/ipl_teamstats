
library(ggthemes)
library(plotfunctions)
library(tidyr)
library(ggplot2)
library(moderndive)
library(skimr) 
library(dplyr)
library(tidyverse)
library(readxl)

## Load  deliveries dataset
deliveries <- read_excel("D:/R_projects/datasets/deliveries.xlsx")

## Load ipl ball by ball dataset dataset
IPL.Ball.by.Ball.2008.2020 <- read.csv("D:/R_projects/ipl_teams/IPL Ball-by-Ball 2008-2020.csv")

## Load ipl matches dataset
IPL.Matches.2008.2020 <- read.csv("D:/R_projects/ipl_teams/IPL Matches 2008-2020.csv")

# create data frame of deliveries
df <- data.frame(deliveries) 

# create data frame of ipl ball by ball
Ipl_ball_by_ball_2020<- data.frame(IPL.Ball.by.Ball.2008.2020)

# create data frame of ipl matches
Ipl_matches<- data.frame( IPL.Matches.2008.2020)

#merge above matches and ball by ball dataset
merge_df<- merge.data.frame( Ipl_ball_by_ball_2020, Ipl_matches ,by = "id",all.x=TRUE, all.y= TRUE)


##  creating a character string containing all team names  
all_teams <-  unique(merge_df$batting_team)
all_teams

# Change the date so as to show only years in the data set 
year<- merge_df$date %>% str_sub(1,4)

merge_df<- mutate(merge_df,year)

#df2 <- data.frame(merge_df) 

merge_df<- merge_df %>%
  select("match_id"=id, inning, over, bowler ,ball,
         batsman_runs,extra_runs, total_runs, year, batting_team, bowling_team )

# character Strings of years
all_year<- unique(merge_df$year)
