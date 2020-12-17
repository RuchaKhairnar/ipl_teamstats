#library(tidyverse)


#IPL.Ball.by.Ball.2008.2020 <- read.csv("D:/R projects/ipl teams/IPL Ball-by-Ball 2008-2020.csv")
# View(IPL.Ball.by.Ball.2008.2020)

#IPL.Matches.2008.2020 <- read.csv("D:/R projects/ipl teams/IPL Matches 2008-2020.csv")
#View(IPL.Matches.2008.2020)


#deliveries <- read_excel("D:/R projects/datasets/deliveries.xlsx")
#df <- data.frame(deliveries) 
#load deliveries

#Ipl_ball_by_ball_2020<- data.frame(IPL.Ball.by.Ball.2008.2020)
#Ipl_matches<- data.frame( IPL.Matches.2008.2020)
##load matches and ball by ball dataset

#merge_df<- merge.data.frame( Ipl_ball_by_ball_2020, Ipl_matches ,by = "id",all.x=TRUE, all.y= TRUE)
#merge above dataset



#year<- merge_df$date %>% str_sub(1,4)

#merge_df<- mutate(merge_df,year)


#merge_df<- merge_df %>%
 # summarise("match_id"=id, inning, over, bowler ,ball,
  #          batsman_runs,extra_runs, total_runs,"year"= as.numeric(year), 
   #         batting_team, bowling_team )



# Function for years
years <- function(y,start_year,end_year){ 
  
    #print(start_year)
   b<-start_year:end_year
   # print(b)  
 #  a<-filter(merge_df,year==b) 
 #  print(a)
   for ( a in b ) {
print(a)      
    } }  
    
years("Mumbai Indians","2014","2016")
