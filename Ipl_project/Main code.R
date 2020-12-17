




tn<- function(y,start,end){
  #z<- start:end
  #print(z)
  #team_name_year(y,z)
  
b<-start:end
    
for ( a in b ) {
      print(a)      
}   
  
  return(  ggplot(data =  , mapping = aes( x= over, y= avg_runs  ))+
             geom_line() +
             scale_x_continuous( breaks = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
             scale_y_continuous( )+#breaks = c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
             labs(title = paste(y, "throughout IPL"),              ## Create a ggplot 
                  subtitle = "Runs scored Per over/ Run Rate ",
                  x= "Overs", y= " Avg Runs",
                  caption = paste("IPL data of ",start,"to", end) ) +
             geom_point(color="red", pch=19 ) +
             theme_bw() )
  
  
  
}
 
tn(y="Mumbai Indians", start = "2015", end = "2018")



return(  ggplot(data = main_data , mapping = aes( x= over, y= avg_runs  ))+
           geom_line() +
           scale_x_continuous( breaks = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
           scale_y_continuous( breaks = c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19))+
           labs(title = paste(y, "throughout IPL"),              ## Create a ggplot 
                subtitle = "Runs scored Per over/ Run Rate ",
                x= "Overs", y= " Avg Runs",
                caption = paste("IPL data of ",z) ) +
           geom_point(color="red", pch=19 ) +
           theme_bw() )





