library(shiny)
library(ggplot2)
library(dplyr)

# Import the data frame
music_mental_health <- read.csv("mental_music_df.csv")

# Chart 3 - Impacts of listening to music on different ages
chart_3_df <- music_mental_health %>%
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

ui <- fluidPage(
  titlePanel("Does age change the effect music has on mental health levels?"),
  p("This chart shows how music has an effect on the mental health levels based on the
     age of the respondent. We can see from this chart that the age range of respondents falls under the
     18-25 year old range. We can also see that the most common effect on mood that music had on the respondents 
     is the improvement of mental health symptoms. Music as a medium seems to have a self-reported
     improvement of mental health overall."),
  sidebarLayout(
    sidebarPanel(
      selectInput("effect", "Effect on Mood", choices = c("Improve", "No effect", "Worsen", "All effects"))
    ),
    mainPanel(
      plotOutput("chart")
    )
  )
)

server <- function(input, output) {
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
}

shinyApp(ui, server)
