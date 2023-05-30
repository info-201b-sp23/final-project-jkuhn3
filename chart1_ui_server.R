# Code to be put in ui 

library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(scales)

file <- "mxmh_survey_results.csv"
mental_music_df <- read.csv(file)

anxiety_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
  summarise(Anxiety = mean(Anxiety))
depression_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
  summarise(Depression = mean(Depression))
OCD_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
  summarise(OCD = mean(OCD))
insomnia_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
  summarise(Insomnia = mean(Insomnia))
mental_health_df <- left_join(anxiety_df, depression_df, by = "Hours.per.day")
mental_health_df <- left_join(mental_health_df, OCD_df, by = "Hours.per.day")
mental_health_df <- left_join(mental_health_df, insomnia_df, by = "Hours.per.day")
mental_health_df <- mental_health_df %>% pivot_longer(!"Hours.per.day", 
                                                      names_to = "Disease",
                                                      values_to =  "Average_Symptoms")
# will need to be a navbar page
ui <- fluidPage(
  h1("Do Number of Hours Listened Affect Mental Health Symptoms?"),
  p("This chart shows the severity of the mental illness compared to the hours 
  of music listened to per day. Because we are looking at averages, this chart 
  shows listening from hours 0-12 as the observations after that were only one 
  per hour, which would skew the data. On average, regardless of hours listened, 
  most experienced anxiety the most severely and OCD the least severely. 
  Generally, the data does not show much correlation between hours listened per 
  day and severity of mental illness, the graph stays within a stable range 
    regardless of the hours for the most part."),
  sidebarLayout(
    sidebarPanel(
      h3("Select Mental Illness"),
      selectInput(
        inputId = "mentalIllness",
        label = "Mental Illness",
        choices = mental_health_df$Disease,
        selected = "Anxiety",
        multiple = TRUE
      )
    ),
    mainPanel(plotlyOutput("graph1"))
  )
  
  
  # Code to be put in server file
  library(dplyr)
  library(shiny)
  library(plotly)
  library(ggplot2)
  library(scales)
  
  file <- "mxmh_survey_results.csv"
  mental_music_df <- read.csv(file)
  
  anxiety_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
    summarise(Anxiety = mean(Anxiety))
  depression_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
    summarise(Depression = mean(Depression))
  OCD_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
    summarise(OCD = mean(OCD))
  insomnia_df <- mental_music_df %>% group_by(Hours.per.day) %>% 
    summarise(Insomnia = mean(Insomnia))
  mental_health_df <- left_join(anxiety_df, depression_df, by = "Hours.per.day")
  mental_health_df <- left_join(mental_health_df, OCD_df, by = "Hours.per.day")
  mental_health_df <- left_join(mental_health_df, insomnia_df, by = "Hours.per.day")
  mental_health_df <- mental_health_df %>% pivot_longer(!"Hours.per.day", 
                                                        names_to = "Disease",
                                                        values_to =  "Average_Symptoms")

server <- function(input, output){
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
    
    
}