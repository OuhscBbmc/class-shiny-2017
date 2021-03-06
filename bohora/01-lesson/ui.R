library(shiny)

shinyUI(fluidPage(

  titlePanel("Life Expectancy & Expenditure"),

  sidebarLayout(
    sidebarPanel(
      width = 3,
      tags$form (
        selectizeInput(
          inputId    = 'first_var',
          label      = 'First variable',
          # choices    = c("eruptions", "waiting"),
          choices    = colnames(ds_health),
          # selected   = "Life.Expectancy",
          options    = list(
            placeholder = 'Please select an option below',
            onInitialize = I(sprintf('function() { this.setValue("%s"); }', colnames(ds_health)[6])))
          # actionButton("submitText1", "Submit text")
          ),
        selectizeInput(
          inputId    = 'second_var',
          label      = 'Choose second variable to correlate with first one',
          choices    = numeric_columns,
          options    = list(
            placeholder = 'Please select an option below',
            onInitialize = I(sprintf('function() { this.setValue("%s"); }', numeric_columns[3])))
          # actionButton("submitText1", "Submit text")
        ),
        sliderInput(
        inputId   = "slider_bin_count",
        label     = "Number of bins:",
        min       = 1,
        max       = 50,
        value     = 30
      ),
      
      # I() indicates it is raw JavaScript code that should be evaluated, instead
      # of a normal character string
        checkboxInput(inputId = "individual_obs",
        label = strong("Show individual observations"),
        value = FALSE),
        
        checkboxInput(inputId = "density",
        label = strong("Show density estimate"),
        value = FALSE),
        
        br(),
        sliderInput("adjust_bw",
        label     = " Bandwidth adjustment",
        min       = 0.2,
        max       = 2,
        value     = 1,
        step      = 0.2),
        
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
        "Shiny is a product of ", span(tags$a(href = "www.rstudio.com", "Rstudio."), style = "color:blue"),
      tags$style("body{background-color:linen; color: black"),
      tags$style(".container-fluid{font-style:normal; color: black"),
      tags$style(".col-sm-3{font-style:normal; border-style: solid; color: black"),
      tags$style(".col-sm-6{font-style:oblique; border-style: solid; color: black")
    ), #Close the sidebar panel
    
    mainPanel(
      column(6, offset = 0,plotOutput("distPlot")),
      
      column(6, plotOutput("corrPlot")),
      p("Note: This is a Shiny application to describe the data obtained from", a("public Google health data", href = "https://www.google.com/publicdata/directory"), "dataset.",
        style = "font-family: 'times'; font-size: 14pt"),
      p(strong("Graph explanation:"), style = "font-family: 'times'; font-size: 18pt", textOutput("out_explain_graph")),
      br(),
      br(),
      dataTableOutput("stats")
    ) # Close the main panel
  ) # Close the layout
)) # Close the page
