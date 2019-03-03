#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


ui <- fluidPage(
            sliderInput(inputId = "num",
                        label= "How many years Marine Reserves will be active?",
                        value = 2030,
                        min = 2015,
                        max = 2065),
            plotOutput("hist")
    )
    
        
# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$hist <- renderPlot({
        hist(rnorm(input$num), main = input$title)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
