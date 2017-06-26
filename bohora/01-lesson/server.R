library(shiny)

shinyServer(function(input, output){

  output$distPlot <- renderPlot({
    selected_column_name    <- input$e6
    x <- faithful[, selected_column_name]
    bins <- seq(min(x), max(x), length.out = input$slider_bin_count + 1)

    hist(x, breaks = bins, col = "darkblue", border = "red")
  })
})
