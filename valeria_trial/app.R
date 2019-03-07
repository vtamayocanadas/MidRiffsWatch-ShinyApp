##
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
        tags$h2("Welcome!"),
        p("We hope this tool helps you to better visualize how the most important small scale fisheries are doing in the Midriff Islands (Gulf of California).",
        br("We show 2 worlds: 1) No marine protection or fisheries management, and 2) Marine reserves implemented."),
        br("To explore, choose the level of protection you want, and get the effects in Biomass (MT), Catch (MT) and Profits (Millions of dollars)."),
        br("Get to know the results of projecting and aggregating information on the most important 13 fisheries in the region. Those fisheries account for approximately 90% of all landings!")),
    title = "Options",
    tabsetPanel(title = "Options", 
               
               navlistPanel(
                   navbarMenu(title = "Fisheries", 
                              tabPanel(em("Atrina tuberculosa")), tabPanel(em("Callinectes Bellicosus")), 
                              tabPanel(em("Cephalopolis cruentata")), tabPanel(em("Dasyatis dipterura")), tabPanel(em("Epinephelus acanthistius")), 
                              tabPanel(em("Lutjanus argentiventris")), tabPanel(em("Cynoscion othonopterus")), tabPanel(em("Mugil curema")), 
                              tabPanel(em("Octopus bimaculatus")), tabPanel(em("Panilurus Inflatus")), tabPanel(em("Scomberomorus maculatus")), tabPanel(em("Sphoeroides annulatus")), 
                              tabPanel(em("Squatina californica"))),
                   tabPanel(title = "Biomass"),
                   tabPanel(title = "Catch"),
                   tabPanel("Profit")),
                   
               sidebarLayout(
                   sidebarPanel(
                       sliderInput(
                           inputId = "size",
                           label= "Size of Marine Reserve (% region of interest) ",
                           value = 2030,
                           min = 2015,
                           max = 2065)), 
                   mainPanel(
                       plotOutput("hist")
                   )
               )
    )
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

