
##  Creating a function with arguments y for team name , start for start year
# end for end year with NA as the default value.

team_name_year <- function(y,start,end=NA){               
    
   if(end %in% 2008:2020){
      b<- start:end
   }else{
      b<- start
   }
   

##Show an error if anything other than team names are provided as argument 
   if( !(y %in% all_teams)) { 
      stop("Enter a valid team name") }     
   
  if(!(start %in% all_year)){
   stop("ENter a valid year from 2008-2020")
   }
   
          
## Creating an empty data frame over_dt_year with following column names
   over_dt_year <- data.frame(inning=numeric(),over=numeric() , bowler= character() ,                    
                              ball=numeric() ,bowling_team=character() , batsman_runs=numeric() ,
                              extra_runs=numeric() , total_runs=numeric(), batting_team=numeric(),
                              year=numeric()  )
   
## Creating an empty data over_dt frame with following column names
   over_dt <- data.frame(inning=numeric(),over=numeric() , bowler= character() ,                     
                         ball=numeric() ,bowling_team=character() , batsman_runs=numeric() ,
                         extra_runs=numeric() , total_runs=numeric(), batting_team=numeric(),
                         year=numeric()  )

## Bind and loop the empty data frame over_dt_year with the args start and end
  for ( a in b){
     print(a)     
     over_dt_year<- rbind(over_dt_year,merge_df[merge_df$year==a,]) } 
  
## bind the empty dataset with over_dt and iterate in 'for' loop to take values of over from 1 to 19    
   for(x in 1:19){
   over_dt <- rbind(over_dt ,over_dt_year[ over_dt_year$over==x, ])        
 
## group by 'over' and add other required columns     
      grouped_dt <-  over_dt %>% 
         group_by(over) %>%
         summarise( match_id, innings=factor(inning,levels = c(1,2)) ,over,
                    "total_bowls" = n() , bowler , ball ,bowling_team, batsman_runs ,
                    extra_runs , total_runs, batting_team,year )                          
      
## Choosing the team  
      Team_ipl <- filter(grouped_dt, batting_team==y )
              
##   calculating total runs scored per match per over
      over_totalruns <- Team_ipl %>% 
         group_by(match_id, .add = TRUE ) %>%
         summarise( runs = sum( total_runs), year) %>%
         unique()                               
      
## Calculating mean of runs scored every over
      mean_total <- over_totalruns %>% 
         group_by(over) %>% summarise(avg_runs=mean(runs),year) %>% unique()         
      
   }
   
## Create a ggplot  
   return(     ggplot(data = mean_total, mapping = aes( x= over, y= avg_runs  ))+
               geom_line() +
               scale_x_continuous( breaks = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
               scale_y_continuous( breaks = c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
               labs(title = paste(y, "throughout IPL"),              
                    subtitle = "Runs scored Per over/ Run Rate ",
                    x= "Overs", y= " Avg Runs",
                    caption = paste("IPL data of ",start,"to",end) ) +
               geom_point(color="red", pch=19) +
              theme_bw())  
            
            
                                          
            
   

}

team_name_year(y="Mumbai Indians", start = "2008", end= "2017" )
