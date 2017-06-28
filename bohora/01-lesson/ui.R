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
        label      = 'Placeholder',
        # choices    = c("eruptions", "waiting"),
        choices    = colnames(faithful),
        # selected   = "eruptions",
        options    = list(
          placeholder = 'Please select an option below',
          onInitialize = I(sprintf('function() { this.setValue("%s"); }', colnames(faithful)[1]))
        )
      ),
      
      textInput(
        inputId = "explain_graph",
        label   = "Write something about the graph here.",
        width   = '300%'),
      
      submitButton("Submit"),
      hr(),
      br(),
      br(),
      br(),
      br(),
      br(),
      img(src = "rstudio-logo-ball.png", height = 72, width = 72),
      "Shiny is a product of ", span("Rstudio.", style = "color:blue")
    ), #Close the sidebar panel
    
    mainPanel(
      plotOutput("distPlot"),
      p("Note: This is a histogram of the either", code(strong("Number of Eruptions")), "or", code(strong("Waiting Time.")), 
        style = "font-family: 'times'; font-si16pt"),
      verbatimTextOutput("explain_graph"),
      dataTableOutput("stats")
    ) # Close the main panel
  ) # Close the layout
)) # Close the page



