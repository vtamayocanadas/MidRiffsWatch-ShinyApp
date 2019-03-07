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
                
        tabPanel(title = "Background", #tab1
        img(height = 200, width =200, src = "logo-cobi-hd.png"), #insert logo    
                           
        tags$h2("Welcome!"),
        p("This is a vizualization tool to assess the current status of the most important small scale fisheries in the Midriff Islands, Mexico.",
        br("We show two worlds: 1) No marine protection or fisheries management, and 2) Marine reserves implemented."),
        br("To explore, choose the level of protection you want, and get the effects in Biomass (MT), Catch (MT) and Profits (Millions of dollars)."),
        br("Get to know the results of projecting and aggregating information on the most important 13 fisheries in the region. Those fisheries account for approximately 90% of all landings!"))), #tab1
     
        tabPanel(title = "Conservation, Food and Livelihoods", #tab2
        h3("Select a Marine Reserve scenario and a fishery metric to see how fisheries respond to changes in protected area size."), 
        p("There are three Marine Reserve size scenarios: 5%, 20%, and 40% of the Midriff Islands region in the Gulf of California (study area)."), #text description
       
         navlistPanel(
          navbarMenu(title = "Marine Reserve Size", 
                     tabPanel("5%"),
                     tabPanel("20%"), 
                     tabPanel("40%"))), #dropdown menu
        
        radioButtons("metrics", "Fisheries Metrics",
                     c("Biomass (MT)",
                       "Catch (MT)",
                       "Profit (USD)"
                     ))), #radio buttons
                                            #tab2
               
      tabPanel(title = "Explore the Fisheries", #tab3
                 p("Atrina tuberculosa"),
                   br("Callinectes bellicosus"),
                   br("Cephalopolis cruentata"),
                   br("Dasyatis dipterura"),
                   br("Epinephelus acanthistius"),
                   br("Lutjanus argentiventris"),
                   br("Cynoscion othonopterus"),
                   br("Mugil curema"),
                   br("Octopus bimaculatus"),
                   br("Panilurus inflatus"),
                   br("Scomberomorus maculatus"),
                   br("Sphoeroides annulatus"),
                   br("Squatina californica")
                          ) #tab3               
                      
                      ) #navbarMenu




# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$hist <- renderPlot({
        hist(rnorm(input$size), main = input$title)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

