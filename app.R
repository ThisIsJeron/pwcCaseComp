library(shiny)
library(plotly)
library(dplyr)
# library(tidyr)
#todo radio for big
#     radio for only 3
#     selection for big

ui <- fluidPage(          
  
  headerPanel("Fleetwings Quality of Life Shiny App"),
  sidebarPanel(
    radioButtons("only3", h3("Compare Main Selected Cities:"),
                 choices = list("Yes" = 1, "No" = 2), selected = 1),
    radioButtons("big", h3("Compare Major Categories:"),
                 choices = list("Yes" = 1, "No" = 2), selected = 1),
    conditionalPanel(
      condition = "input.big == 1",
        uiOutput("onlyBig")
    ),
    conditionalPanel(
      condition = "input.big == 2",
      uiOutput("attributes")
    )
  ),
  mainPanel(
    plotlyOutput('plot')
  )
)

server <- function(input, output) {
  
  output$onlyBig <- renderUI({
    selectInput("bigcol", "Select Major Category to View:",
                c("Job" = "job",
                  "Cost of Living" = "col",
                  "Safety and Wellbeing" = "swb"))
  })

  output$attributes <- renderUI({

    selectInput("column", "Select an Attribute to View:",
                c("Population" = "pop",
                  "People under 5" = "pu5",
                  "People under 18" = "pu18",
                  "People over 65" = "p65p",
                  "Active Labor Force" = "alf",
                  "Household Income" = "hi",
                  "Median Home Value" = "mhv",
                  "Median Gross Rent" = "mgr",
                  "Number of People Living in Poverty" = "pov",
                  "Average Transportation Time" = "att",
                  "College Attainment" = "ca"))
  })
  
  output$plot <- renderPlotly({
    # if(input$only3 == 1){
    #   mydf <- mydfS
    # }
    if (input$big == 1){
      mydf <- select(mydf, city, input$bigcol)
    }
    if (input$big == 2){
      
      mydf <- select(mydf, city, input$column)
    }

    # if (input$onlyBig == 2){
    #   
    # }
    # mydf <- select(MyData, city, input$column)
    if (input$only3 == 1){
      mydf <- slice(mydf, 1:3)
      # mydf <-select(mydf, city, input$column)
    }
    # mydf <- select(mydf, city, input$column)
    City <- as.vector(t(mydf[,2]))
    index <- as.vector(t(mydf[,2]))
    ggplot(data=mydf, aes(x=reorder(city, City), y = index, fill = factor(city))) +
      geom_bar(stat="identity") +
      labs(x = "City")
  })
}

shinyApp(ui, server)