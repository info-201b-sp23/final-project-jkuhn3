# Music and Mental Health 
## INFO 201 "Foundational Skills for Data Science" — Spring 2023

Authors: Adriana Vassek (vasseka@uw.edu), Aarushi Seetalakshmi (baarush@uw.edu), Jainish Malhotra (jainish@uw.edu), Zach Hyde (zhyde@uw.edu), and Jason Kuhn (jkuhn3@uw.edu)

(https://jainish.shinyapps.io/group_project/)

Please create the necessary files for your multi-page Shiny app in this GitHub repository. Consult the Canvas assignment for more details. Be sure to publish your app on Shinyapps.io.

When you are finished, please add the text from your introductory and concluding pages below. You might want to use this GitHub repository as part of your digital portfolio, so you want this README.md to offer a brief description of the project and key takeaways.

# Introduction
Major Questions

The primary goal of this study is to explore the relationship between symptoms of mental illness (i.e. Anxiety, Depression) and music. More specifically, we aim to look at how the frequency of listening, age of listeners, and favored genres of music relate to respondent's moods. The rise in popularity of music therapy has many folks asking if music truly improves mental health or if it simply results in a temporary change in mood. In order to answer this, we looked at data collected from a survey on Music and Mental Health that quizzed respondents on their listening habits and the severity of mental health symptoms. In order to answer the larger question of whether music impacts mental health, we must first break that question down into a few smaller questions that we can more easily visualize through data:


What relationship exists between the amount of time spent listening to music and the severity of reported mental illness symptoms?
To answer this question, we will look at the two variables: the reported amount of time spent listening to music each day, and the reported severity of each symptom of mental illness (Anxiety, Depression, Insomnia, and OCD). Using a line chart, we can observe how listening habits vary across respondents with different symptom severities.


How does mental health severity vary between different ages?
In order to establish a pattern, we also need to acknowledge any confounding variables, particularly the age of the respondents. Starting by once again grouping the data based on different mental health symptoms, we can then use a scatterplot to demonstrate the distribution of self-reported mental health symptoms across various ages.


How does the effect of music on mood vary between age groups?
Building on the results of our second question, we will also explore the specific impacts of listening to music and certain age groups. Survey respondents were given the option to indicate if listening to music improved, worsened, or had no effect on mental health symptoms. Respondents will be divided into six age groups and then the effects of listening habits on mood will be displayed using a stacked bar chart.


About the Data

The data we're using originates from Kaggle, a data science and machine learning community, and was collected by a Computer Science student at the University of Washington named Catherine Rasgaitis. All data was collected through a Google form, posted on various social media platforms, and advertised in public locations such as libraries and parks. According to the author, the data was collected in order to explore potential relationships between a person's music taste and their reported mental health.

Picture of Kaggle logo Music and Mental Health Survey Results
We chose this dataset for three reasons: 1) the pool of respondents is relatively larger considering the specificity of the topic, 2) the questions explore multiple factors involved in listening habits, and 3) the symptoms are indicated by respondents on a scale of severity, rather than just a binary 'yes/no' response.

When discussing the results of this data, we must acknowledge certain generalizations that are made in regard to mental illness. The data aims to bring awareness to possible solutions. It must be acknowledged that what works for one person may not work for all people experiencing the same symptoms. Two people may report similar severity of certain symptoms but have entirely different responses to music. We aim to look at the overall trends between groups, but the results are not indicative of one set of habits that are useful for all music listeners.


Challenges and Limitations

There are several limitations to this dataset worth acknowledging. Firstly, many of the variables are self-reported and thus susceptible to personal biases. Self-reported data also introduces the possibility of exaggeration, acquiescence, and perceptive differences. For example, two people might both respond with an “8” for anxiety but experience very different levels of anxiety in their day-to-day lives. Since their responses are subjective, there is no way of verifying all responses are completely accurate to the respondents’ actual lived experiences.

Secondly, definitions are not provided by the authors for all variables in the dataset. One column in the dataset is labeled “BPM”, but it is not clear if this is meant to indicate the respondents’ resting heart rates or their heart rates when listening to specific music. Since the authors did not share a copy of the original questions asked, there is the potential for possible confusion in regard to certain variables in our report. For this reason, we only included variables with defined responses in our analysis.

Thirdly, the dataset focuses on respondents' current listening habits and preferred genres but contains little to no data on how different respondents with varying levels of interest respond to the same genre (i.e. do they feel their effects “worsen” in response to some genres and “improve” with others?). In order to get the most out of our chosen dataset, it is important to acknowledge the limitations in scope and the potential challenges that may arise.


# Conclusion / Summary Takeaways

Key Takeaways
Our Project takes into consideration how music and listening habits correlate to mental health. Throughout the project we have worked with different paramenters of the dataset to develop a better understanding of music and the effects on mental health.

Some of the key takeaways and understanings from our analysis are:
1. Understanding how listening to music affects one's mood: From our graphical representations we see that there is a varied effect on how music affects one's mood depending on the person's age. On the whole, music has a positive effect on the individual's mood as the data clearly indicates that irrepective of the age, there is a positive effect that music has on one's mood.

2. More specifically, we see a great correlation on how age is a big factor that realtes to music to mood. Typically, people between 18-25 see the most change in moods by listening to music. Understading this particular data can lead to conclusions that younger people tend to relate to music more and hence show more changes on mood. Each age bracket correclates to a different generation of people that have different tastes in music and hence show a different result for change in moods.

3. The third major takeaway is how the severity of mental illness relates to age and how does music play a role in changing that: The data shows that ages from 10-45 show high levels of Anxiety and Depression. This is in accordance from our second takeaway that shows major change in moods between people aged 18-25. The two sets of data help us find anomalies and eventually draw up solutions using music in everyday life. For example, one implication is that people that show anxiety and depresion betwen the ages of 10-45 should try and listen to music more often as it is seen to have changes in mood. This change in mood might lead the individual to become happy which eventually lowers stress/ anxiety levels.

Bellow we present a list of calculated values from our Exploratory Analysis:

What is the average amount of time respondents spent listening to music each day?
For all respondents, the average number of hours was 3.57. Interestingly, that number was higher for all symptom groups: respondents experiencing anxiety listened to music an average of 3.67 hours per day, depression an average of 3.84 hours, insomnia an average of 4.13 hours, and OCD an average of 4.14 hours.

What is the most frequently listened to genre among all respondents?
The answer was, not too unsurprisingly Rock. In fact, was the most popular genre for all symptom groups! In this regard, there was no significant difference in preference between groups.

What are the listening habits of this study’s respondents?
The most popular streaming platform was Spotify. Approximately 54.9% of respondents listened to music in languages they did not speak, and 78.7% of respondents listened to music during work.

To summarize, these 3 takeawys really structure our argument on the impacts of music on mental health. Finding anomalies in the data with the help of visualizations has lead to these findings and potential solutions to different mental helath issues.
