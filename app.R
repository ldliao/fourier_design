
library(shiny)

# Define UI 
ui <- pageWithSidebar(
  headerPanel("Sample Size for Clinical Trial:"),
  
  sidebarPanel(
    sliderInput("alpha", label = "alpha level", min = .01, max = .20, value = .05),
    sliderInput("power", label = "desired minimal power", min = .8, max = .99, value = .8),
    sliderInput("theta", label = "theta", min = 0.0001, max = 100, value = .01),
    sliderInput("theta0", label = "theta null", min = 0, max = 10, value = 0),
    sliderInput("var", label = "variance", min= 1, max = 100, value = 1)
  ),
  mainPanel(
    textOutput("text1"),
    plotOutput('plot1')
  )
)

source("dist_sampleSize.R")

server <- function(input, output) {
  output$text1 <- renderPrint({
    dist_sampleSize(input$alpha,input$power,input$theta,input$theta0,input$var)
  })
  output$plot1 <- renderPlot({
    #access function
    dist_sampleSize(input$alpha,input$power,input$theta,input$theta0,input$var)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

