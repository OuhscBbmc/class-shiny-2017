library(shiny)

#requireNamespace("shiny")

ui <- fluidPage(
  sliderInput(inputId = "num",
              label = "Choose a number",
              value = 25, min = 1, max = 100),
  plotOutput("hist"),
  verbatimTextOutput("stats")
)

server <- function(input, output) {

  data <- reactive({
    rnorm(input$num)
  })

  output$hist <- renderPlot({ # Reactive function receives input from reactive value and causes the display object to repond
    hist(data())
  })
  output$stats <- renderPrint({
    summary(data())
  })
}

shinyApp(ui = ui, server = server)

# shinyapps.io (sharing what you build or how to build your own server)
# 7 functions in the reactive tool-kit
# renderDataTable()
# renderImage()
# renderPlot()
# renderPrint()
# renderTable()
# renderText()
# renderUI()





