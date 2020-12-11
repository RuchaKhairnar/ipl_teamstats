

library(ggthemes)
library(plotfunctions)
library(tidyr)
library(ggplot2)
library(moderndive)
library(skimr) 
library(dplyr)

## Load dataset
library(readxl)
deliveries <- read_excel("D:/R projects/datasets/deliveries.xlsx")

 
##  creating a character string containing all team names  
all_teams <-  unique(deliveries$batting_team)


 
team_name <- function(y){               ##  Creating a function
            
 if( !(y %in% all_teams)) { 
  stop("Enter a valid team name") }     ##Show an error if anything other than team names are provided as argument 

  
df <- data.frame(deliveries)    


  
over_dt <- data.frame(inning=numeric(),over=numeric() , bowler= character() ,                     ## Creating an empty data frame with following column names
                        ball=numeric() ,bowling_team=character() , batsman_runs=numeric() ,
                        extra_runs=numeric() , total_runs=numeric(), batting_team=numeric() )


for(x in 1:19){

over_dt <- rbind(over_dt ,df[df$over==x, ])         ## bind the empty dataset with df and iterate in 'for' loop to take values of over from 1 to 19  

grouped_dt <-  over_dt %>% 
                  group_by(over) %>%
                   summarise( match_id, innings=factor(inning,levels = c(1,2)) ,over,
                   "total_bowls" = n() , bowler , ball ,bowling_team, batsman_runs ,
                   extra_runs , total_runs, batting_team )                          ## group by 'over' and add other required columns


Team_ipl <- grouped_dt[grouped_dt$batting_team == y ,]                 ## Choosing the team  


over_totalruns <- Team_ipl %>% 
                    group_by(match_id, .add = TRUE ) %>%
                     summarise( runs = sum( total_runs)) %>%
                      unique()                                ##   calculating total runs scored per match per over


mean_total <- over_totalruns %>% 
                  group_by(over) %>% summarise(avg_runs=mean(runs))          ## Calculating mean of runs scored every over

}

return(  ggplot(data = mean_total, mapping = aes( x= over, y= avg_runs  ))+
             geom_line() + 
             labs(title = paste(y, "throughout IPL"),              ## Create a ggplot 
             subtitle = "Runs scored Per over/ Run Rate ",
             x= "Overs", y= " Avg Runs",
             caption = "IPL Data from 2008-2017 "  ) +
             geom_point(color="red", pch=19 ) +
           theme_bw() )
      
         View(all_teams)

}
 
team_name(y="Chennai Super Kings")


 