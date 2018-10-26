library(shiny)
library(plotly)


ui <- fluidPage(
  
  headerPanel("Fleetwings Quality of Life Data Visualization"),
  sidebarPanel(
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
  ),
  mainPanel(
    plotlyOutput('trendPlot')
  )
)

server <- function(input, output) {
  
  output$trendPlot <- renderPlotly({
    
    # p <- plot_ly(MyData, x = MyData$city, autobinx = F, type = "histogram",
    #              xbins = list(start = minx, end = maxx, size = size))
    # # style the xaxis
    # layout(p, xaxis = list(title = "Ratings", range = c(minx, maxx), autorange = F,
    #                        autotick = F, tick0 = minx, dtick = size))
    test <- select(MyData, city, input$column)
    ggplot(data=test, aes(x=city, y = as.vector(t(test[,2])))) +
      geom_bar(stat="identity") 
  })
}

shinyApp(ui, server)