library(shiny)

shinyServer(function(input, output){
  
  output$distPlot <- renderPlot({
    selected_column_name    <- input$e6
    x <- faithful[, selected_column_name]
    bins <- seq(min(x), max(x), length.out = input$slider_bin_count + 1)
    
    hist(x, breaks = bins, col = "darkblue", border = "yellow", 
         probability = TRUE,
         main = paste("Histogram of", Hmisc::capitalize(selected_column_name)),
         xlab = paste("Number of", Hmisc::capitalize(selected_column_name)))
    
    dens <- density(x, adjust = input$adjust_bw)
    lines(dens, col = "red", type = "l", pch = 22, lty = 1, lwd = 2.5)
  })
  
    output$out_explain_graph <- renderText({
    input$submitText
    isolate(input$explain_graph)
  })

  output$stats <- renderDataTable({
    library(DT)
    selected_column_name    <- input$e6
    x <- faithful[, selected_column_name]
    summary_table <- as.data.frame(round(psych::describe(x),2))[,-1]
    rownames(summary_table) <- NULL
    names(summary_table) <- Hmisc::capitalize(names(summary_table))
    datatable(summary_table, 
              caption = htmltools::tags$caption(
                style = "font-size:200%",
                htmltools::strong(paste("Table 1: Descriptive summary for", selected_column_name))))
  })
})

