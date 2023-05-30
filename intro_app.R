library(shiny)
library(bslib)

# Introduction theme
intro_theme <- bs_theme(bg = "white", #background color
                        fg = "#003882", #foreground color
                        primary = "#9BD0F3", # primary color
               )

# Define UI

ui <- fluidPage(
  # Set theme
  theme = intro_theme,
  
  # Title
  titlePanel("Music and Mental Health"),
  
  # Introduction tab
  tabsetPanel(
    
    # Major questions of interest
    tabPanel("Introduction",
             
             h2("Major Questions"),
             br(),
             
             p("The primary goal of this study is to explore the relationship between symptoms of mental illness (i.e. Anxiety, Depression) and music. More specifically, we aim to look at how the frequency of listening, age of listeners, and favored genres of music relate to respondent's moods. The rise in popularity of music therapy has many folks asking if music truly improves mental health or if it simply results in a temporary change in mood. In order to answer this, we looked at data collected from a survey on Music and Mental Health that quizzed respondents on their listening habits and the severity of mental health symptoms. In order to answer the larger question of whether music impacts mental health, we must first break that question down into a few smaller questions that we can more easily visualize through data:"),
             br(),
             
             h4("What relationship exists between the amount of time spent listening to music and the severity of reported mental illness symptoms?"),
             p("To answer this question, we will look at the two variables: the reported amount of time spent listening to music each day, and the reported severity of each symptom of mental illness (Anxiety, Depression, Insomnia, and OCD). Using a line chart, we can observe how listening habits vary across respondents with different symptom severities."),
             br(),
             
             h4("How does mental health severity vary between different ages?"),
             p("In order to establish a pattern, we also need to acknowledge any confounding variables, particularly the age of the respondents. Starting by once again grouping the data based on different mental health symptoms, we can then use a scatterplot to demonstrate the distribution of self-reported mental health symptoms across various ages."),
             br(),
             
             h4("How does the effect of music on mood vary between age groups?"),
             p("Building on the results of our second question, we will also explore the specific impacts of listening to music and certain age groups. Survey respondents were given the option to indicate if listening to music improved, worsened, or had no effect on mental health symptoms. Respondents will be divided into six age groups and then the effects of listening habits on mood will be displayed using a stacked bar chart."),
             br(),
    
             
    # A little summary about the data and 
    # where it comes from
             h2("About the Data"),
             br(),
    
             p("The data we're using originates from Kaggle, a data science and machine learning community, and was collected by a Computer Science student at the University of Washington named Catherine Rasgaitis. All data was collected through a Google form, posted on various social media platforms, and advertised in public locations such as libraries and parks. According to the author, the data was collected in order to explore potential relationships between a person's music taste and their reported mental health."),
    
             img(src = "kaggle.png",
                 alt = "Picture of Kaggle logo"),
             
             a("Music and Mental Health Survey Results", 
               href = "https://www.kaggle.com/datasets/catherinerasgaitis/mxmh-survey-results"),
    
             p("We chose this dataset for three reasons: 1) the pool of respondents is relatively larger considering the specificity of the topic, 2) the questions explore multiple factors involved in listening habits, and 3) the symptoms are indicated by respondents on a scale of severity, rather than just a binary 'yes/no' response."),
    
             p("When discussing the results of this data, we must acknowledge certain generalizations that are made in regard to mental illness. The data aims to bring awareness to possible solutions. It must be acknowledged that what works for one person may not work for all people experiencing the same symptoms. Two people may report similar severity of certain symptoms but have entirely different responses to music. We aim to look at the overall trends between groups, but the results are not indicative of one set of habits that are useful for all music listeners."),
             br(),
    
    
    # A brief description of the challenges and
    # limitations inherent to the data set
             h2("Challenges and Limitations"),
             br(),
    
             p("There are several limitations to this dataset worth acknowledging. Firstly, many of the variables are self-reported and thus susceptible to personal biases. Self-reported data also introduces the possibility of exaggeration, acquiescence, and perceptive differences. For example, two people might both respond with an “8” for anxiety but experience very different levels of anxiety in their day-to-day lives. Since their responses are subjective, there is no way of verifying all responses are completely accurate to the respondents’ actual lived experiences."),
    
             p("Secondly, definitions are not provided by the authors for all variables in the dataset. One column in the dataset is labeled “BPM”, but it is not clear if this is meant to indicate the respondents’ resting heart rates or their heart rates when listening to specific music. Since the authors did not share a copy of the original questions asked, there is the potential for possible confusion in regard to certain variables in our report. For this reason, we only included variables with defined responses in our analysis."),
    
             p("Thirdly, the dataset focuses on respondents' current listening habits and preferred genres but contains little to no data on how different respondents with varying levels of interest respond to the same genre (i.e. do they feel their effects “worsen” in response to some genres and “improve” with others?). In order to get the most out of our chosen dataset, it is important to acknowledge the limitations in scope and the potential challenges that may arise.")
    )
  )
  
)

# Define server
server <- function(input, output) {
  
}

# Run the app
shinyApp(ui = ui, server = server)

