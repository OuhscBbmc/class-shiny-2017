library(shiny)
library(ggplot2)

shinyServer(function(input, output){
  
  output$distPlot <- renderPlot({
    selected_column_name    <- input$first_var
    x <- unlist(ds_health[selected_column_name])

    if (class(x) == "numeric"){
      bins <- seq(min(x), max(x), length.out = input$slider_bin_count + 1)
      
      hist(x, breaks = bins, col = "darkblue", border = "yellow", probability = TRUE,
           main = paste("Histogram of", Hmisc::capitalize(selected_column_name)),
           xlab = paste("Number of", Hmisc::capitalize(selected_column_name)))
      } else {
        barplot(table(x), xlab = paste("Levels of", toupper(selected_column_name)), 
                ylab = "N", main = paste("Bar plot of", toupper(selected_column_name)))
      }  

    if(input$density){
    dens <- density(x, adjust = input$adjust_bw)
    lines(dens, col = "red", type = "l", pch = 22, lty = 1, lwd = 2.5)
    }
    
    if (input$individual_obs) {
      graphics::rug(unlist(ds_health[selected_column_name]))
    }
  })
  
  output$corrPlot <- renderPlot({
    selected_column_name    <- as.name(input$first_var)
    selected_second_column  <- as.name(input$second_var)
    
    ggplot(ds_health,aes_string(selected_column_name,selected_second_column))+ geom_point() +
      geom_smooth(method = "loess",formula=y~x) + 
      ggtitle(paste("Correlation between", selected_column_name, "and", selected_second_column )) +
      theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=18, hjust = 0.5),
            axis.text = element_text(size=12),
            axis.title = element_text(size = 15 ))
  })
  
    output$out_explain_graph <- renderText({
    input$submitText
    isolate(input$explain_graph)
  })

  output$stats <- renderDataTable({
    library(DT)
    selected_column_name    <- input$first_var
    x <- unlist(ds_health[selected_column_name])
    
    if (class(x) == "numeric"){
    summary_table <- as.data.frame(round(psych::describe(x),2))[,-1]
    rownames(summary_table) <- NULL
    names(summary_table) <- Hmisc::capitalize(names(summary_table))
    datatable(summary_table, 
              caption = htmltools::tags$caption(
                style = "font-size:200%",
                htmltools::strong(paste("Table 1: Descriptive summary for", selected_column_name))))
    } else {
      summary_table <- as.data.frame(table(x))
      colnames(summary_table) <- c(selected_column_name, "Frequency")
      datatable(summary_table,
                caption = htmltools::tags$caption(
                style = "font-size:200%",
                htmltools::strong(paste("Table 1: Descriptive summary for", selected_column_name))))
    }
  })
})
