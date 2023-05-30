library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)

mental_music_df <- read.csv("C:\\Users\\aarus\\Desktop\\201-projects\\final code\\mental_music_df.csv")

anxiety_df <- mental_music_df %>% 
  group_by(Age) %>% 
  summarise(Anxiety = mean(Anxiety))

depression_df <- mental_music_df %>% 
  group_by(Age) %>% 
  summarise(Depression = mean(Depression))

OCD_df <- mental_music_df %>% 
  group_by(Age) %>% 
  summarise(OCD = mean(OCD))

insomnia_df <- mental_music_df %>% 
  group_by(Age) %>% 
  summarise(Insomnia = mean(Insomnia))

mental_music_df <- left_join(anxiety_df,depression_df,by = "Age")
mental_music_df <- left_join(mental_music_df,OCD_df,by = "Age")
mental_music_df <- left_join(mental_music_df,insomnia_df,by = "Age")
mental_music_df <- mental_music_df %>% pivot_longer(!"Age",
                          names_to = "Mental_Illness",
                          values_to = "Average_Symptoms")


## Age vs severity of mental illness##


server <- function(input,output){
  
  output$mh_plotly<- renderPlotly({
    
    
    filtered_mh_df <- mental_music_df %>% 
      filter(Mental_Illness %in% input$mh_choice)
    
    mh_plotly <- ggplot(data = filtered_mh_df)+
      geom_point(aes(x = Age , y = Average_Symptoms , color = Mental_Illness)) +
      labs(title = "Mental Illness Severity vs Age", 
           x = "Age", 
           y = "Severity (0-10)",
           color = "Mental Illness")+
      scale_x_continuous(name = "Age",breaks = seq(10,90,10),limits = c(10,80))+
      scale_y_continuous(name = "Average Severity Rating (0-10)",limits = c(0,10))

    
    mh_plotly <- ggplotly(mh_plotly, tooltip = "text")
    return(ggplotly(mh_plotly))
  })
}

