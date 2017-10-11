library(shiny)
library(shinythemes)

# Define UI for application

shinyUI(navbarPage(theme = shinytheme("cosmo"),
                   "Internet Service in Brazil",
                   tabPanel("Statistics",
                            sidebarPanel(width = 3,
                              selectInput("company", "Choose a company:",
                                          choices = companies
                                         ),
                              selectInput("state", "Choose a state:",
                                          choices = states
                              )
                              ,
                              h4("Total number of states covered by this company:", textOutput("coverage"))
                            ),
                            mainPanel(width = 9,
                              tabsetPanel(
                                tabPanel("Channels",
                                         h3('Percentage of service channels used in each state by year.'),
                                         plotOutput("plotChannel2015"),
                                         plotOutput("plotChannel2016")
                                ),
                                tabPanel("Quality of service",
                                         h3('Percentage of scores awarded for the service.'),
                                         plotOutput("plotScore"))
                                        
                              )
                            )),
                   tabPanel("Dataset", 
                            dataTableOutput('dataset')
                            ),
                   tabPanel("About",
                            mainPanel(
                            includeMarkdown("about.Rmd"))
                   )
          
))