library(shiny)
library(plotly)
library(ggplot2movies)

minx <- min(movies$rating)
maxx <- max(movies$rating)

ui <- fluidPage(
  
  headerPanel("Fleetwings Quality of Life Data Visualization"),
  sidebarPanel(
    sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 10)
  ),
  mainPanel(
    plotlyOutput('trendPlot'),
    plotlyOutput('trendPlot2'),
    plotlyOutput('trendPlot3')
  )
)

server <- function(input, output) {
  
  output$trendPlot <- renderPlotly({
    # size of the bins depend on the input 'bins'
    size <- (maxx - minx) / input$bins
    
    # a simple histogram of movie ratings
    p <- plot_ly(movies, x = movies$rating, autobinx = F, type = "histogram",
                 xbins = list(start = minx, end = maxx, size = size))
    # style the xaxis
    layout(p, xaxis = list(title = "Ratings", range = c(minx, maxx), autorange = F,
                           autotick = F, tick0 = minx, dtick = size))
  })
  output$trendPlot2 <- renderPlotly({
    # size of the bins depend on the input 'bins'
    size <- (maxx - minx) / input$bins
    
    # a simple histogram of movie ratings
    p <- plot_ly(movies, x = movies$rating, autobinx = F, type = "histogram",
                 xbins = list(start = minx, end = maxx, size = size))
    # style the xaxis
    layout(p, xaxis = list(title = "Ratings", range = c(minx, maxx), autorange = F,
                           autotick = F, tick0 = minx, dtick = size))
  })
  output$trendPlot3 <- renderPlotly({
    # size of the bins depend on the input 'bins'
    size <- (maxx - minx) / input$bins
    
    # a simple histogram of movie ratings
    p <- plot_ly(movies, x = movies$rating, autobinx = F, type = "histogram",
                 xbins = list(start = minx, end = maxx, size = size))
    # style the xaxis
    layout(p, xaxis = list(title = "Ratings", range = c(minx, maxx), autorange = F,
                           autotick = F, tick0 = minx, dtick = size))
  })
}

shinyApp(ui, server)