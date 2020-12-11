library(tidyverse)


IPL.Ball.by.Ball.2008.2020 <- read.csv("D:/R projects/ipl teams/IPL Ball-by-Ball 2008-2020.csv")
 # View(IPL.Ball.by.Ball.2008.2020)
   
 IPL.Matches.2008.2020 <- read.csv("D:/R projects/ipl teams/IPL Matches 2008-2020.csv")
 #View(IPL.Matches.2008.2020)
 
 
 deliveries <- read_excel("D:/R projects/datasets/deliveries.xlsx")
 df <- data.frame(deliveries) 
 
 
 Ipl_ball_by_ball_2020<- data.frame(IPL.Ball.by.Ball.2008.2020)
 Ipl_matches<- data.frame( IPL.Matches.2008.2020)
 
merge_df<- merge.data.frame( Ipl_ball_by_ball_2020, Ipl_matches ,by = "id",all.x=TRUE, all.y= TRUE)
 

year<- merge_df$date %>% str_sub(1,4)

merge_df<- mutate(merge_df,year)

merge_df<- merge_df %>%
            select("match_id"=id, inning, over, bowler ,ball, batsman_runs,extra_runs, total_runs, year, batting_team, bowling_team )



##  creating a character string containing all team names  
all_teams <-  unique(merge_df$batting_team)
all_teams

all_year<- as.numeric(merge_df$year)


team_name <- function(y,z){               ##  Creating a function
   
   if( !(y %in% all_teams)) { 
      stop("Enter a valid team name") }     ##Show an error if anything other than team names are provided as argument 
   
  if(!(z %in% all_year)){
      stop("ENter a valid year from 2008-2020")
   }
   
   df <- data.frame(merge_df)    
   
   
   
   over_dt <- data.frame(inning=numeric(),over=numeric() , bowler= character() ,                     ## Creating an empty data frame with following column names
                         ball=numeric() ,bowling_team=character() , batsman_runs=numeric() ,
                         extra_runs=numeric() , total_runs=numeric(), batting_team=numeric(),year=numeric()  )
   
   
   for(x in 1:19){
      
      over_dt <- rbind(over_dt ,df[df$over==x, ])         ## bind the empty dataset with df and iterate in 'for' loop to take values of over from 1 to 19  
      
      grouped_dt <-  over_dt %>% 
         group_by(over) %>%
         summarise( match_id, innings=factor(inning,levels = c(1,2)) ,over,
                    "total_bowls" = n() , bowler , ball ,bowling_team, batsman_runs ,
                    extra_runs , total_runs, batting_team,year )                          ## group by 'over' and add other required columns
      
      
      Team_ipl <- filter(grouped_dt, batting_team==y, year==z  )
         #grouped_dt[grouped_dt$batting_team == y ,]                 ## Choosing the team  
      
      
      over_totalruns <- Team_ipl %>% 
         group_by(match_id, .add = TRUE ) %>%
         summarise( runs = sum( total_runs), year) %>%
         unique()                                ##   calculating total runs scored per match per over
      
      
      mean_total <- over_totalruns %>% 
         group_by(over) %>% summarise(avg_runs=mean(runs),year)          ## Calculating mean of runs scored every over
      
   }
   
   return(  ggplot(data = mean_total, mapping = aes( x= over, y= avg_runs  ))+
               geom_line() + 
               labs(title = paste(y, "throughout IPL"),              ## Create a ggplot 
                    subtitle = "Runs scored Per over/ Run Rate ",
                    x= "Overs", y= " Avg Runs",
                    caption = paste("IPL data of ",z) ) +
               geom_point(color="red", pch=19 ) +
               theme_bw() )
   
   View(all_teams)
   
}

team_name(y="Chennai Super Kings", z= "2020" )









