# Random Network Shiny Demo
# Keith Hughitt (khughitt@umd.edu)
# 2013/11/03
library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Random Network Demo (binomial)"),

    # Controls
    sidebarPanel(
    sliderInput("degree",
                "Mean degree:",
                min = 1,
                max = 10,
                value = 1)
    ),

    # Plot output
    mainPanel(
        plotOutput("random_net", width='100%')
    )
))
