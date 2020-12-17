
##  Creating function team_name
team_name <- function(y){      
  
##Show an error if anything other than team names are provided as argument  
 if( !(y %in% all_teams)) { 
   print(all_teams)
   stop("Enter a valid team name")
    }      

  
#df <- data.frame(deliveries)    

## Creating an empty data frame with following column names
over_dt <- data.frame(inning=numeric(),over=numeric() , bowler= character() ,                   
                        ball=numeric() ,bowling_team=character() , batsman_runs=numeric() ,
                        extra_runs=numeric() , total_runs=numeric(), batting_team=numeric() )


for(x in 1:19){
  
## bind the empty data set with df and iterate in 'for' loop to take values of over from 1 to 19  
over_dt <- rbind(over_dt ,df2[df2$over==x, ])         

## group by 'over' and add other required columns
grouped_dt <-  over_dt %>% 
                group_by(over) %>%
                summarise( id, innings=factor(inning,levels = c(1,2)) ,over,
                "total_bowls" = n() , bowler , ball ,bowling_team, batsman_runs ,
                extra_runs , total_runs, batting_team )                          

## Choosing the team
Team_ipl <- grouped_dt[grouped_dt$batting_team == y ,]            

##   calculating total runs scored per match per over
over_totalruns <- Team_ipl %>% 
                    group_by(id, .add = TRUE ) %>%
                     summarise( runs = sum( total_runs)) %>%
                      unique()                                

## Calculating mean of runs scored every over
mean_total <- over_totalruns %>% 
                  group_by(over) %>% summarise(avg_runs=mean(runs))          

}

return(  ggplot(data = mean_total, mapping = aes( x= over, y= avg_runs  ))+
             geom_line() + 
           scale_x_continuous( breaks = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
           scale_y_continuous( breaks = c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
             labs(title = paste(y, "throughout IPL"),              ## Create a ggplot 
            subtitle = "Runs scored Per over/ Run Rate ",
             x= "Overs", y= " Avg Runs",
             caption = "IPL Data from 2008-2017 "  ) +
             geom_point(color="red", pch=19 ) +
           theme_bw() )
      
 #        View(all_teams)

}
 
team_name(y="Mumbai Indians")






 