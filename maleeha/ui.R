library(shiny)
ui <- fluidPage(
  sliderInput(inputId = "num",
              label = "Blah",
              value = 25, min =1, max =100),
  plotOutput(outputId = "hist")

)
