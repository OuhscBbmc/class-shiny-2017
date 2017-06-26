library(shiny)

# Define server logic for slider examples
function(input, output) {

  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({

    # Compose data frame
    data.frame(
      Name = c("Integer",
               "Decimal",
               "Min & Max",
               "Minimum",
               "Custom Format",
               "Animation"),
      Value = as.character(c(input$integer,
                             input$decimal,
                             paste(input$range, collapse=' '),
                             input$minimum + 1000,
                             input$format,
                             input$animation)),
      stringsAsFactors=FALSE)
  })

  # Show the values using an HTML table
  output$values222 <- renderTable({
    sliderValues()
  })
}
