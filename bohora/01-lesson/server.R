library(shiny)

shinyServer(function(input, output){

  output$distPlot <- renderPlot({
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$slider_bin_count + 1)

    hist(x, breaks = bins, col = "darkblue", border = "red")
  })
})
