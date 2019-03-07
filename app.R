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
  fluidRow(
  tags$h1("Midriff Watch Tool"),
  p("This App shows a two scenario world in the mid-Gulf of California: one scenario where there are no Marine Reserves and one with 5% of the area protected as a net of Marine Reserves. The App will provide information on 13 fisheries that account for approximately 90% catch in the region. Using the model developed by the Midriff Watch Group Project Team, users will be able to visualize both observational data from 2005 to 2015, and projected outputs up to 2105. They will have the option to choose from biomass and revenues from catch, derived from those fisheries. All outputs will allow users to compare two scenarios: Marine Reserves implemented, and Marine Reserves not implemented.")
  ),
  title = "Options",
  navbarPage(title = "Options", 
             navlistPanel(
    navbarMenu(title = "Fisheries", tabPanel("Atrina tuberculosa"), tabPanel("Callinectes Bellicosus"), tabPanel("Cephalopolis cruentata"), tabPanel("Dasyatis dipterura"), tabPanel("Epinephelus acanthistius"), tabPanel("Lutjanus argentiventris"), tabPanel("Cynoscion othonopterus"), tabPanel("Mugil curema"), tabPanel("Octopus bimaculatus"), tabPanel("Panilurus Inflatus"), tabPanel("Scomberomorus maculatus"), tabPanel("Sphoeroides annulatus"), tabPanel("Squatina californica")),
    tabPanel(title = "Biomass"),
    tabPanel(title = "Catch"),
    tabPanel("Profit")),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "num",
        label= "How many years of active Marine Reserves?",
        value = 2030,
        min = 2015,
        max = 2065)), 
    mainPanel(
      plotOutput("hist")
    )
  )
)
)
  
 

        
# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$hist <- renderPlot({
        hist(rnorm(input$num), main = input$title)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
