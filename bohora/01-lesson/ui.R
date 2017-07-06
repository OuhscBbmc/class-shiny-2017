library(shiny)

shinyUI(fluidPage(

  titlePanel("Hello Shiny"),

  sidebarLayout(
    sidebarPanel(
      tags$form (
      sliderInput(
        inputId   = "slider_bin_count",
        label     = "Number of bins:",
        min       = 1,
        max       = 50,
        value     = 30
      ),
      
      sliderInput("adjust_bw",
        label     = " Bandwidth adjustment",
        min       = 0.2,
        max       = 2,
        value     = 1,
        step      = 0.2),
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
        # actionButton("submitText1", "Submit text")
      ),
      
      br(),
      br()
      ),
      
      tags$form (
        textInput(
        inputId = "explain_graph",
        label   = 'Write something about the graph here.',
        width   = '300%',
        placeholder = "Explain graph here here."),
        actionButton("submitText", "Submit text")
      ),
      
      hr(),
      br(),
      br(),
      br(),
      br(),
      br(),
      tags$a(href = "www.rstudio.com", img(src = "rstudio-logo-ball.png", height = 72, width = 72)),
      "Shiny is a product of ", span(tags$a(href = "www.rstudio.com", "Rstudio."), style = "color:blue")
    ), #Close the sidebar panel
    
    mainPanel(
      plotOutput("distPlot"),
      p("Note: This is a histogram of the either", code(strong("Number of Eruptions")), "or", code(strong("Waiting Time")), "as shown above", 
        style = "font-family: 'times'; font-size: 14pt"),
      p(strong("Graph explanation:"), style = "font-family: 'times'; font-size: 18pt", textOutput("out_explain_graph")),
      br(),
      br(),
      dataTableOutput("stats")
    ) # Close the main panel
  ) # Close the layout
)) # Close the page
