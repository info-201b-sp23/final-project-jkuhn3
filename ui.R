library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(scales)
library(tidyverse)
library(bslib)
library(shinythemes)

intro_theme <- shinytheme("sandstone"
)

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


ui <- fluidPage(theme = intro_theme,
  
  navbarPage(

  
  # Title
  titlePanel("Music and Mental Health"),
    
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
    ),
  
    tabPanel("Chart 1",
             h1("Do Number of Hours Listened Affect Mental Health Symptoms?"),
             p("This chart shows the severity of the mental illness compared to the hours of music listened to per day. Because we are looking at averages, this chart shows listening from hours 0-12 as the observations after that were only one per hour, which would skew the data. On average, regardless of hours listened, most experienced anxiety the most severely and OCD the least severely. Generally, the data does not show much correlation between hours listened per day and severity of mental illness, the graph stays within a stable range regardless of the hours for the most part."),
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
      ),
    ),
  
    tabPanel("Chart 2",
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
          the least severe mental illness reported all across the age groups in the data. ")
               ),
             )
    ),
  
    tabPanel("Chart 3",
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
                 plotlyOutput("chart")
               )
             )
    ),
    
  
    tabPanel("Summary",
             h2("Key Takeaways"),
             p("Our Project takes into consideration how music and listening habits correlate to mental health. Throughout the project we have worked with different paramenters of the dataset to develop a better understanding of music and the effects on mental health."),
             p(),
             h3("Some of the key takeaways and understanings from our analysis are:"),
             p("     1. Understanding how listening to music affects one's mood: From our graphical representations we see that there is a varied effect on how music affects one's mood depending on the person's age. On the whole, music has a positive effect on the individual's mood as the data clearly indicates that irrepective of the age, there is a positive effect that music has on one's mood."),
             p("     2. More specifically, we see a great correlation on how age is a big factor that realtes to music to mood. Typically, people between 18-25 see the most change in moods by listening to music. Understading this particular data can lead to conclusions that younger people tend to relate to music more and hence show more changes on mood. Each age bracket correclates to a different generation of people that have different tastes in music and hence show a different result for change in moods."),
             p("     3. The third major takeaway is how the severity of mental illness relates to age and how does music play a role in changing that: The data shows that ages from 10-45 show high levels of Anxiety and Depression. This is in accordance from our second takeaway that shows major change in moods between people aged 18-25. The two sets of data help us find anomalies and eventually draw up solutions using music in everyday life. For example, one implication is that people that show anxiety and depresion betwen the ages of 10-45 should try and listen to music more often as it is seen to have changes in mood. This change in mood might lead the individual to become happy which eventually lowers stress/ anxiety levels."),
             p(),
             p("Bellow we present a list of calculated values from our Exploratory Analysis:"),
             p(),
             h4("What is the average amount of time respondents spent listening to music each day?"),
             p("For all respondents, the average number of hours was 3.57. Interestingly, that number was higher for all symptom groups: respondents experiencing anxiety listened to music an average of 3.67 hours per day, depression an average of 3.84 hours, insomnia an average of 4.13 hours, and OCD an average of 4.14 hours."),
             h4("What is the most frequently listened to genre among all respondents?"),
             p("The answer was, not too unsurprisingly Rock. In fact, was the most popular genre for all symptom groups! In this regard, there was no significant difference in preference between groups."),
             h4("What are the listening habits of this study’s respondents?"),
             p("The most popular streaming platform was Spotify. Approximately 54.9% of respondents listened to music in languages they did not speak, and 78.7% of respondents listened to music during work."),
             p(),
             h5(" To summarize, these 3 takeawys really structure our argument on the impacts of music on mental health. Finding anomalies in the data with the help of visualizations has lead to these findings and potential solutions to different mental helath issues.")
    )
  
)
)
