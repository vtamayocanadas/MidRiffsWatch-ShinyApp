##
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(giphyr)
library(shinythemes)
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

ui <- fluidPage(
  theme = shinytheme("cerulean"),
  
  navbarPage(title = "Midriff's Watch Tool",
             
             ###tab1                                 
             tabPanel(title = "Background", 
                      tags$h2("Welcome to the Midriff Islands, Mexico!"),
                      h6("The map show in yellow the network of marine reserves designed in 2015"),
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
                        br("The Midriff's Watch Tool help you to better visualize status and projections of the 
                           most important small scale fisheries in the Midriff Islands."),
                        br("We show two worlds: 1) Business as Usual BAU (no marine protection), and 2) Marine reserves implemented."),
                        br("To explore, choose the level of protection you want, and get the effects in Biomass (MT), Catch (MT) and Profits (Millions of dollars)."),
                        br("Get to know the results of projecting and aggregating information on the most important 13 fisheries in the region. 
                           Those fisheries account for approximately 90% of all landings!"))), #tab1
             
             ###tab2        
             tabPanel(title = "Conservation, Food, & Livelihoods", 
                      h3("Select Biomass (Conservation), Catch (Food) or Profits (Livelihoods) and compare the projections made with different marine reserve scenarios."), 
                      p("There are four Marine Reserve size scenarios: Business as Usual (BAU)= 0%, 5%, 20%, and 40% of the Midriff 
                        Islands region in the Gulf of California (study area).",
                        br(strong("BIOMASS - Conservation")),
                        br("We show total biomass in the Midriff Islands region from 2015 to 2065. 
                        Different lines correspond to different marine size scenarios."),
                        br(strong("CATCH - Food")),
                        br("Considering 13 main fisheries in the region we show catch from 2015 to 2065. 
                        Different lines correspond to different marine reserves scenarios."),
                        br(strong("PROFIT - Livelihoods")),
                        br("Profits are calculated based on 2018 market prices and have been discounted with 
                        10% rate since that is the rate the Mexican government uses for their projects. 
                        We project profits from 2015 to 2065. Different lines correspond to different marine 
                        reserves scenarios.")),
#text description
                      
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons(inputId = "options", label = "Choose Fisheries Measurements",
                                       c("Biomass (MT)" = "biomass",
                                         "Catch (MT)" = "catch",
                                         "Profit (USD)" = "profit")) #radio buttons
                          
                          ### Checkbox           
                          # checkboxInput("checkbox", label = "View the Cost of No Action", value = TRUE)  #checkbox
                          
                        ),#sidebarPanel
                        
                        mainPanel(
                          tabsetPanel(
                            type = "tab",
                            tabPanel("Current Status", 
                                     h4("This is the current status of the 13 main fisheries 
                                        in the Midriff Islands (2019)"), 
                                     h6("The current conditions of the fisheries are presented in a KOBE plot. 
                                     Quadrants show the status as follows: Species that fall in the red quadrant are overfished
                                     and continue to experience overfishing, species in the yellow quadrant are overfished. 
                                     Orange quadrant correspond to species that are currently experiencing overfishing, 
                                        and green quadrant correspond to species that are in  good health."),
                                     img(height = 300, width =480, src = "kobe_w_labels.jpg"),
                                     actionButton(inputId = "clicks",
                                                  label = "See species and catch (%)", data = "table_percent")),
                            tabPanel("Projection", 
                                     plotOutput("projection",
                                                width = "100%"))
                            
                            )#tabsetPanel
                          
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
                          tabsetPanel(
                            type = "tab",
                            tabPanel("Species", 
                                     plotOutput("pic_spp"))
                          ) #tabsetPanel
                          
                        ) #mainPanel     
                        
                        
                      ) #sidebarLayout
                      
                      
             )#tab3  
             
             
                      )#main ui close token              
  
  )#fluidPage                    


# Define server logic required to call images of outputs from www folder

server <- function(input, output, session) {
  ###output table with species and catch %
  
  #observeEvent(input$clicks, {renderImage({
    #table_percent.png <- normalizePath(file.path('www/',
    #paste(input$clicks,
   # '.png',
    #sep=' ')))}, deleteFile = FALSE)})
  #list(src = table_percent.png,
       #alt = paste("Table of species", input$clicks))
  
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
         alt = paste("biomass projection", input$options),
         height = 400, 
         width = 500)
    
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
  
  
  #####output for checkbox
  
  #      x <- reactive(input$checkbox)
  #    if (x = TRUE) 
  #    {y <- output$no_action}
  #    else
  #    {y <- 0}
  
  #   output$no_action <-  renderImage({
  
  #      kobe_no0.3.gif <- normalizePath(file.path('www/',
  #                                             paste(input$checkbox, 
  #                                                '.gif', 
  #                                               sep=''))) #normalizepath
  
  #Return a list containing the filename and alt text
  #  list(src = kobe_no0.3.gif,
  #      alt = paste("kobe plot showing cost of no action", input$checkbox)) 
  
  
  #    }#renderImage
  #     , deleteFile = FALSE) #renderImage
  
  
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
    
    ##crab photo
    crab.png <- normalizePath(file.path('www/',
                                        paste(input$fishery, 
                                              '.png', 
                                              sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = crab.png,
         alt = paste("crab photo", input$fishery))
    
    
    ##graysby photo
    graysby.png <- normalizePath(file.path('www/',
                                           paste(input$fishery, 
                                                 '.png', 
                                                 sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = graysby.png,
         alt = paste("graysby photo", input$fishery)) 
    
    ##stingray photo
    stingray.png <- normalizePath(file.path('www/',
                                            paste(input$fishery, 
                                                  '.png', 
                                                  sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = stingray.png,
         alt = paste("stingray photo", input$fishery)) 
    
    ##hind photo
    hind.png <- normalizePath(file.path('www/',
                                        paste(input$fishery, 
                                              '.png', 
                                              sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = graysby.png,
         alt = paste("graysby photo", input$fishery)) 
    
    ##snapper photo
    snapper.png <- normalizePath(file.path('www/',
                                           paste(input$fishery, 
                                                 '.png', 
                                                 sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = snapper.png,
         alt = paste("snapper photo", input$fishery)) 
    
    ##corvina/weakfish photo
    corvina.png <- normalizePath(file.path('www/',
                                           paste(input$fishery, 
                                                 '.png', 
                                                 sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = corvina.png,
         alt = paste("corvina photo", input$fishery))
    
    ##mullet photo
    mullet.png <- normalizePath(file.path('www/',
                                          paste(input$fishery, 
                                                '.png', 
                                                sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = mullet.png,
         alt = paste("mullet photo", input$fishery))
    
    ##octopus photo
    octopus.png <- normalizePath(file.path('www/',
                                           paste(input$fishery, 
                                                 '.png', 
                                                 sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = octopus.png,
         alt = paste("octopus photo", input$fishery))
    
    ##lobster photo
    lobster.png <- normalizePath(file.path('www/',
                                           paste(input$fishery, 
                                                 '.png', 
                                                 sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = lobster.png,
         alt = paste("lobster photo", input$fishery))
    
    ##mackerel photo
    mackerel.png <- normalizePath(file.path('www/',
                                            paste(input$fishery, 
                                                  '.png', 
                                                  sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = mackerel.png,
         alt = paste("mackerel photo", input$fishery))
    
    ##puffer photo
    puffer.png <- normalizePath(file.path('www/',
                                          paste(input$fishery, 
                                                '.png', 
                                                sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = puffer.png,
         alt = paste("puffer photo", input$fishery))
    
    ##shark photo
    shark.png <- normalizePath(file.path('www/',
                                         paste(input$fishery, 
                                               '.png', 
                                               sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    list(src = shark.png,
         alt = paste("shark photo", input$fishery))
    
    
  }#renderImage
  , deleteFile = FALSE) #renderImage
  
  
  
  
  
  
  
} #brace for entire server

# Run the application 
shinyApp(ui = ui, server = server)

