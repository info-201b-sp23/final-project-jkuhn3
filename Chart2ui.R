library(plotly)

ui <- fluidPage(
  
    
  tabPanel(
    "Second Tab - Graph",
    sidebarLayout(
      sidebarPanel(
        h2("Options"),
        checkboxGroupInput(
          inputId = "mh_choice",
          label = "Mental Illness",
          choices = c("Anxiety","Depression","Insomnia","OCD"),
          selected = "OCD")
      ),
      mainPanel(
        h1("Scatterplot of Time vs Choice of Y-axis"),
        plotlyOutput("mh_plotly"),
        p("This graphshows the correlation between the average severity of each mental
          illness compared to age. Our goal with this chart was create a visual representation
          of the data, in order to see if any mental illness is more positively or negatively
          correlated with age. From our data, Anxiety and Depression tended to have a spike around
          the age group of 20-30, in terms of self-reported severity from 0-10, and generally
          tended to show a slightly negative correlation over age. Adults in the age groups
          40-60 tended to report higher severity in Insomnia, and overall, OCD tended to be
          the least severe mental illness reported all across the age groups in the data.Each
          mental illness ")
      ),
    ))
)

  
