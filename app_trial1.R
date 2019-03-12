##
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#library(tidyverse)
#library(ggplot2)
#library(here)
#library(plotly)
#library(tidyverse)
#library(gganimate)
#library(ggrepel)
#library(ggridges)
#library(ggpubr)
#library(gridExtra)
#library(grid)

#height = 300, width =500, src = "logo-cobi-hd.png"


ui <- navbarPage(title = "Midriff's Watch Tool",

###tab1                                 
        tabPanel(title = "Background", 
                 tags$h2("Welcome to the MidRiff Islands, Mexico!"),
        img(src = ("ocean_basemap.png")), #insert logo    
                           
        tags$h3("Did you know how important this region is for Mexico?"),
        p("The Gulf of California (GOC) generates over 50,000 fishing jobs involving approximately 
          2,600 vessels, of which 2,500 are small scale (Cisneros-Mata, 2010).
        The GOC is characterized by high levels of primary productivity, biological diversity, 
           and fish biomass, thereby providing the local human population
        a large array of economically and culturally important ecosystem services, including fisheries.",
        br("The provision of these services are at risk due to climate change but also well-documented 
           policy failures, some leading to declines in stocks of fish caught in a large number of 
           small-scale fisheries (Cinti A et al., 2014)."), 
        br("The MidRiff's Watch Tool help you to better visualize status and projections of the 
           most important small scale fisheries in the Midriff Islands."),
        br("We show two worlds: 1) No marine protection or fisheries management, and 2) Marine reserves implemented."),
        br("To explore, choose the level of protection you want, and get the effects in Biomass (MT), Catch (MT) and Profits (Millions of dollars)."),
        br("Get to know the results of projecting and aggregating information on the most important 13 fisheries in the region. 
           Those fisheries account for approximately 90% of all landings!"))), #tab1
     
###tab2        
        tabPanel(title = "Conservation, Food, & Livelihoods", 
        h3("Select Biomass, Catch or Profits and compare the projections made with different marine reserve scenarios."), 
        p("There are four Marine Reserve size scenarios: Busniness as Usual (BAU), 5%, 20%, and 40% of the Midriff Islands region in the Gulf of California (study area)."), #text description
       
        sidebarLayout(
          sidebarPanel(
           radioButtons(inputId = "options", label = "Choose Fisheries Measurements",
                        c("Biomass (MT)" = "biomass",
                          "Catch (MT)" = "catch",
                          "Profit (USD)" = "profit")) #radio buttons
          
  ### INSERT ACTION BUTTON HERE           
           #actionButton("conditionsButton","View Existing Conditions",
           #           
           #              mainPanel(
           #               plotOutput("conditions")
           #             ) #mainPanel action button
           #         ) #actionButton
  
  ### code for image of current status kobe plot
      #h3("This is the current status of the 13 main fisheries in the MidRiff Islands (2019)"), 
      #img(height = 500, width =800, src = "kobe_w_labels.jpg"),
  
           ),#sidebarPanel
          
          mainPanel(
            plotOutput("projection")
          
          )#mainPanel
          
             
            )#sidebarlayout
        ), #tab2
      
                                       
###tab3

tabPanel(title = "Explore the Fisheries",
      sidebarLayout(
          sidebarPanel(
              selectInput("fishery", "Explore the Fisheries",
                        c("Clam" = "mollusk",
                          "Crab" = "crab",
                          "Graysby" = "graysby",
                          "Diamond Stingray" = "stingray",
                          "Rooster Hind" = "hind",
                          "Yellow Snapper" = "snapper",
                          "Gulf Weakfish" = "corvina",
                          "White Mullet" = "mullet",
                          "Octopus" = "octopus",
                          "Lobster" = "lobster",
                          "Atlantic Spanish Mackerel" = "mackerel",
                          "Bullseye Puffer" = "puffer",
                          "Pacific Angel Shark" = "shark"
                        
                          ) #c
                    ) #selectInput
                
                ), #sidebarPanel 
        
           mainPanel(
              plotOutput("pic_spp")
            
          ) #mainPanel     
          
          
   ) #sidebarLayout
              
               
      )#tab3  
     

 )#main ui close token              
                     


# Define server logic required to call images of outputs from www folder

server <- function(input, output, session) {
    
#####outputs for projections using radio buttons 
  
    output$projection <- renderImage({
      # When input$n is 3, filename is ./images/image3.jpeg
      
##biomass projection
      biomass.png <- normalizePath(file.path('www/',
                                paste(input$options, 
                                      '.png', 
                                      sep=''))) #normalizepath
      
      # Return a list containing the filename and alt text
      list(src = biomass.png,
           alt = paste("biomass projection", input$options))
      
##catch projection
      
     catch.png <- normalizePath(file.path('www/',
                               paste(input$options, 
                                    '.png', 
                                    sep=''))) #normalizepath

      list(src = catch.png,
           alt = paste("catch projection", input$options))
   
##profit projection   
      profit.png <- normalizePath(file.path('www/',
                              paste(input$options, 
                              '.png', 
                              sep=''))) #normalizepath
      
      # Return a list containing the filename and alt text
      list(src = profit.png,
           alt = paste("profit projection", input$options))
      
    }#renderImage
    , deleteFile = FALSE) #renderImage

    
    
#######outputs for fisheries
    
    output$pic_spp <- renderImage({
      # When input$n is 3, filename is ./images/image3.jpeg
      
##clam photo
      mollusk.png <- normalizePath(file.path('www/',
                                             paste(input$fishery, 
                                                   '.png', 
                                                   sep=''))) #normalizepath
      
      # Return a list containing the filename and alt text
      list(src = mollusk.png,
           alt = paste("clam photo", input$fishery))
    
      
      
    }#renderImage
    , deleteFile = FALSE) #renderImage
    
    
    
    
    
    
    
} #brace for entire server

# Run the application 
shinyApp(ui = ui, server = server)

