
library(shiny)
library(ggplot2)

data("diamonds")

shinyUI(fluidPage(
  titlePanel("Diamond Cost by Carat, Cut, Color and Clarity"),
  sidebarLayout(sidebarPanel(h4("Choose Diamond Factors"),
  selectInput("cut", "Cut", (sort(unique(diamonds$cut), decreasing = T))),
  selectInput("color", "Color", (sort(unique(diamonds$color)))),
  selectInput("clarity", "Clarity", (sort(unique(diamonds$clarity), decreasing = T))),
  sliderInput("lm", "Carat", min = min(diamonds$carat), max = max(diamonds$carat), value = mean(diamonds$carat), step = 0.1), h4("Predicted Price"), verbatimTextOutput("predict"), width = 4),
  mainPanel("Price/Carat", plotOutput("distPlot"))
)))