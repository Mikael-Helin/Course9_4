# This is a shiny app to determine diamond price based on carat, cut, color, and clarity

library(shiny)
library(ggplot2)
library(curl)

# Define server logic
shinyServer(function(input, output)
{
  data("diamonds")
  # create the plot
  output$distPlot <- renderPlot( 
  {
    diamonds_sub <- subset(diamonds, cut == input$cut & color == input$color & clarity == input$clarity)
    p <- ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point() + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price") + xlim(min(diamonds_sub$carat)-0.1, max(diamonds_sub$carat)+0.1) + ylim (0, 20000)
    p
  }, height = 400)
  
  # create linear model
  output$predict <- renderPrint(
  {
    diamonds_sub <- subset(diamonds, cut == input$cut & color == input$color & clarity == input$clarity)
    unname(predict(lm(price~carat,data=diamonds_sub), data.frame(carat = input$lm)))
  })
  
  observeEvent(input$predict, 
  {
    distPlot <<- NULL
    output$distPlot <- renderPlot(
    {
      p <- ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point() + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price") + xlim(0, 6) + ylim (0, 20000)
      p
    }, height = 700)
  })
})