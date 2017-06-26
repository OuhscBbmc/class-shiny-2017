library(shiny)

shinyUI(fluidPage(

  titlePanel("Hello Shiny"),

  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId   = "slider_bin_count",
        label     = "Number of bins:",
        min       = 1,
        max       = 50,
        value     = 30
      ),
      # I() indicates it is raw JavaScript code that should be evaluated, instead
      # of a normal character string
      selectizeInput(
        inputId    = 'e6',
        label      = '6. Placeholder',
        choices    = c("eruptions", "waiting"),
        # selected   = "eruptions",
        options    = list(
          placeholder = 'Please select an option below',
          onInitialize = I('function() { this.setValue("eruptions"); }')
        )
      )
    ), #Close the sidebar panel

    mainPanel(
      plotOutput("distPlot")
    ) # Close the main panel
  ) # Close the layout
)) # Close the page
