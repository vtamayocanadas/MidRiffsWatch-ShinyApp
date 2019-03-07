##
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)



ui <- navbarPage(title = "Midriff's Watch Tool",
                
                  tabPanel(title = "Background",
                           img(height = 200, width =200, src = "icono-soluciones-1.png"),         
                           
                tags$h2("Welcome!"),
                 p("We hope this tool helps you to better visualize how the most important small scale 
                   fisheries are doing in the Midriff Islands (Gulf of California).",
                 br("We show 2 worlds: 1) No marine protection or fisheries management, and 2) Marine reserves implemented."),
                 br("To explore, choose the level of protection you want, and get the effects in Biomass (MT), Catch (MT) and 
                    Profits (Millions of dollars)."),
                 br("Get to know the results of projecting and aggregating information on the most important 13 fisheries 
                    in the region. Those fisheries account for approximately 90% of all landings!"))),
                
     
                tabPanel(title = "Conservation, Food and Livelihoods"),                 
               
                tabPanel(title = "Explore the Fisheries",
                        
                        navlistPanel(
                   navbarMenu(title = "Put faces to the main Fisheries in the region", 
                              tabPanel(em("Atrina tuberculosa")), tabPanel(em("Callinectes Bellicosus")), 
                              tabPanel(em("Cephalopolis cruentata")), tabPanel(em("Dasyatis dipterura")), tabPanel(em("Epinephelus acanthistius")), 
                              tabPanel(em("Lutjanus argentiventris")), tabPanel(em("Cynoscion othonopterus")), tabPanel(em("Mugil curema")), 
                              tabPanel(em("Octopus bimaculatus")), tabPanel(em("Panilurus Inflatus")), tabPanel(em("Scomberomorus maculatus")), tabPanel(em("Sphoeroides annulatus")), 
                              tabPanel(em("Squatina californica"))))
                    )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$hist <- renderPlot({
        hist(rnorm(input$size), main = input$title)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

