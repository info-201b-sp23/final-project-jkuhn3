library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(scales)
library(tidyverse)


mental_music <- read.csv("mental_music_df.csv")
anxiety_df <- mental_music %>% group_by(Hours.per.day) %>% 
  summarise(Anxiety = mean(Anxiety))
depression_df <- mental_music %>% group_by(Hours.per.day) %>% 
  summarise(Depression = mean(Depression))
OCD_df <- mental_music %>% group_by(Hours.per.day) %>% 
  summarise(OCD = mean(OCD))
insomnia_df <- mental_music %>% group_by(Hours.per.day) %>% 
  summarise(Insomnia = mean(Insomnia))
mental_health_df <- left_join(anxiety_df, depression_df, by = "Hours.per.day")
mental_health_df <- left_join(mental_health_df, OCD_df, by = "Hours.per.day")
mental_health_df <- left_join(mental_health_df, insomnia_df, by = "Hours.per.day")
mental_health_df <- mental_health_df %>% pivot_longer(!"Hours.per.day", 
                                                      names_to = "Disease",
                                                      values_to =  "Average_Symptoms")

chart_3_df <- mental_music %>%
  na.omit() %>%
  mutate(
    Age.group = case_when(
      Age < 18 ~ "10-18",
      Age >= 18 & Age <= 25 ~ "18-25",
      Age >= 26 & Age <= 35 ~ "26-35",
      Age >= 36 & Age <= 45 ~ "36-45",
      Age >= 46 & Age <= 55 ~ "46-55",
      Age >= 56 ~ "55+"
    )
  ) %>%
  select(Age.group, Music.effects) %>%
  filter(Music.effects %in% c("No effect", "Improve", "Worsen"))

anxiety_df <- mental_music %>% 
  group_by(Age) %>% 
  summarise(Anxiety = mean(Anxiety))

depression_df <- mental_music %>% 
  group_by(Age) %>% 
  summarise(Depression = mean(Depression))

OCD_df <- mental_music %>% 
  group_by(Age) %>% 
  summarise(OCD = mean(OCD))

insomnia_df <- mental_music %>% 
  group_by(Age) %>% 
  summarise(Insomnia = mean(Insomnia))

mental_music_df <- left_join(anxiety_df,depression_df,by = "Age")
mental_music_df <- left_join(mental_music_df,OCD_df,by = "Age")
mental_music_df <- left_join(mental_music_df,insomnia_df,by = "Age")
mental_music_df <- mental_music_df %>% pivot_longer(!"Age",
                                                    names_to = "Mental_Illness",
                                                    values_to = "Average_Symptoms")

function(input, output) {
    output$graph1 <- renderPlotly({
    selected_df <- mental_health_df %>% filter(Disease %in% input$mentalIllness)
    hours_listened <- ggplot(data = selected_df) + 
      geom_line(mapping = aes(x = Hours.per.day, y = Average_Symptoms,color = Disease)) +
      
      labs(title = "Mental Illness vs Hours Listened Per Day",
           x = "Hours Per Day",
           y = "Average Rating",
           color = "Mental Illness") + 
      scale_x_continuous(name = "Hours Per Day", limits = c(0, 12), breaks = seq(0,12, 1)) +
      scale_y_continuous(name ="Average Rating", limits = c(0, 10))
    return(ggplotly(hours_listened))
    })
    
    output$chart <- renderPlot({
      if (input$effect == "All effects") {
        filtered_df <- chart_3_df
      } else {
        filtered_df <- chart_3_df %>%
          filter(Music.effects == input$effect)
      }
      
      ggplot(filtered_df) +
        geom_bar(mapping = aes(fill = Music.effects, x = Age.group), position = "stack") +
        scale_fill_manual(values = c("springgreen3", "khaki2", "tomato2")) +
        labs(
          x = "Age",
          y = "# of Respondents",
          fill = "Effect on Mood"
        )
    })
    
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
      
      
      mh_plotly <- ggplotly(mh_plotly)
      return(ggplotly(mh_plotly))
    })
}
