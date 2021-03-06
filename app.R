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

ui <- fluidPage(theme = shinytheme("cerulean"),
              navbarPage(title = "Midriff Watch Tool",
###tab1                                 
      tabPanel(title = "Background", 
              tags$h2("Welcome to the Midriff Islands, Mexico!"),
              img(src = "ocean_basemap.png", height = 600, width = 500),
              h6("The above map shows the Midriff Islands region of the Gulf of California.                         Yellow polygons indicate a network of marine 
                      reserves proposed by COBI in 2015."), #insert map   
                      
              tags$h3("Do you know how important this region is for Mexico?"),
              p("The Gulf of California (GOC) generates over 50,000 
                      fishing jobs, which involves approximately 2,600 vessels. Of these, 2                         ,500 are small-scale fishers (Cisneros-Mata, 2010).The GOC is                                 characterized by high levels of primary productivity, biological                              diversity, and fish biomass. This provides local people with a wide                           array of economically and culturally important ecosystem                                      services, including fisheries.",
              br("Policy failures and climate change threaten the provision of                       these services, including declines in fish stocks caught by many small             -scale fisheries (Cinti A et. al., 2014)."), 
              br("The Midriff's Watch Tool is designed to visualize the current and future                          status of the most important small scale fisheries in the Midriff                             Islands under different marine reserve scenarios."),
              br("We show two worlds: 1) Business as Usual BAU (no marine protection), and 2)                       Marine Reserves implemented."),
              br("To explore, Choose to explore Biomass (MT), Catch (MT) and Profits (Millions of dollars) for the most important 13 fisheries in the region. These fisheries account for                        approximately 90% of all landings!"),                          
             br("You can also learn about the model we used, learn more about the fisheries and the parameters used in the model, and get to know our team."),
              br("This project was developed by the Midriif's Watch Team in collaboration with Community and Biodiversity (COBI), which is a Mexican civil society organization."),
             br("COBI was interested in quantifying the consequences of delayed management actions in the Midriffs Islands. With COBI as their client, the Midriff Watch Team worked from April 2018 to May 2019 to analyze the consequences of delaying management actions in the region (they proposed a marine reserve network in 2015 that was never implemented by the government)."),
             br("Data from this project was provided by the federal government of Mexico (CONAPESCA), and filtered by Midriff region landing sites from 2000-2015.")

 ),#p
 #h5("Click to watch COBI video"), 
 img(src = "cobi_logo.png", height = 30, width = 90),
 img(src = "mrw_logo.png", height = 120, width = 90)
 #plotOutput("video")
              ), #tab1

             
###tab2        
        tabPanel(title = "Conservation, Food, & Livelihoods", 
                h3("Select Biomass (Conservation), Catch (Food) or Profits (Livelihoods) and                        compare the projections made with different marine reserve scenarios."),
                p("There are four Marine Reserve size scenarios: Business as Usual (BAU)= 0%,                       5%, 20%, and 40% of the Midriff Islands region in the Gulf of California                       (study area)."),  #p
#text description
                      
sidebarLayout(
        sidebarPanel(
          #radiobuttons  
          radioButtons(inputId = "options", label = "Projections",
                                       c("Biomass (MT)" = "biomass",
                                         "Catch (MT)" = "catch",
                                         "Profit (USD)" = "profit")) #radio buttons
##action button                          
        #actionButton(inputId = "clicks",
        #                 label = "See species and catch (%)", 
        #                 data = "table_percent") #action button
                          
          ),#sidebarPanel
                        
  mainPanel( 
    tabsetPanel(
      type = "tab",
      
##projection tab panel 

    tabPanel("Projections",

    p(br(strong("BIOMASS - Conservation")),
        br("This projection shows total biomass (MT) of the 13 focus species in the Midriff Islands region from 2015 to 2065. Each colored line represents a different marine size scenario."),
        br(strong("CATCH - Food")),
        br("Catch in metric tons (MT) for the 13 main fisheries from 2015 to 2065. Each colored line represents a different marine size scenario."),
        br(strong("PROFIT - Livelihoods")),
        br("Profits are calculated in USD based on 2018 market prices with a 10% discount rate (the rate used by the Mexican government). Profits are projected from 2015 to 2065. Each colored line represents a different marine size scenario.")), #p               
               
    plotOutput("projection")
    ), #tab panel
      
##current status tab panel      
      tabPanel("Current Status",
          h4("This is the current status of the 13 main fisheries in the                                  Midriff Islands (2019)."), 
          h6("The quadrants of this KOBE plot show species status as follows: Species in the red quadrant have experienced historical overfishing and are currently overfished. Species in the yellow quadrant have been historically overfished. Species in the orange quadrant are currently experiencing overfishing, and species in the green quadrant are in good health."), #h6
               
  img(height = 300, width =480, src = "kobe_w_labels.jpg"),
  br(),
  br()
        
              ) #current status tab panel
      
            ) #tabsetPanel
      
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
        
    ),#tab3  
   
###tab4    
        
tabPanel(title = "Our Model", 
         h3("Fisheries Model"),
         p("A catch-only algorithm was used to get fisheries reference points. Those results 
         were used as the inputs for a dynamic Schaefer surplus production model (Equation 1). The project area was divided into a matrix of 11,236 patches, each with an area of 1km2. Time steps were annual. The area-perimeter ratio for the 5% reserve network size was maintained 
for the proposed 5% marine reserve network size. For 20% and 40% scenarios, the ratio was not 
maintained, but randomly generated using a sample function in RStudio. The model simulates biomass, catch, and fishing exploitation rate inside and outside the marine reserve in every patch at every time step.",
         br(),
         br("Equation 1: Bij, t+1 =Bij, t+Bij, t r(1-(Bij, t/Kij)- Fij, t Bij, t+Iij, t-mBij, t"),
         h6("The matrix model (patchij, row i, column j) represents the project area. Where fishing exploitation rate (F) is equal to Fij,t> 0 if a patch is outside the reserve network, and equal to 0 if a patch is inside the network. Biomass (Bij,t) is the biomass of fish species in each patch in time period t; in t=1 Bij,1=B1/total patches. Logistic growth in each patch is represented by parameters r and K, where Kij=K/total patches. Immigration (I) is modeled using Von Neumann neighborhood movement and a parameterized migration rate (m) for each fishery based on home range estimates (Das, 2011). 
                       5%, 20%, and 40% of the Midriff Islands region in the Gulf of California (study area)."), 
         h3("Economic Model"),
         p("Profits to be made are a function of Bt and Ft (adopted from Costello et al., 2016) (Equation 2):"),
         br(),
         br("Equation 2: t= pHt - cFt"),
         h6("Where p is the ex vessel price of fish, Ht=FtBtis harvest, c is a cost parameter, and F is the fishing exploitation rate.  𝛽 is held constant at 1 as a scalar cost parameter that determines a linear relationship between units of effort added to the fishery and associated cost.")),
         #text description
         
         sidebarLayout(
           sidebarPanel(
             #radiobuttons
             radioButtons(inputId = "table", label = "Current Status and Parameters",
                          c("Model Parameters" = "parameters",
                            "Species Contribution to Total Catch" = "table_percent")) #radio buttons2
           ), #sidebar panel
           mainPanel(
                plotOutput("two_tables")
                )#mainPanel
           
           )#sidebarlayout
           
           
), #tab4
               
###tab 5
tabPanel(title = "Meet the Team", 
         h4("The Midriff Watch Team is a group of Master's students from the Bren School of Environmental Science & Management - University of California Santa Barbara (UCSB) (Class of 2019)."),
         h5("The team:"),
         img(src = "mrw_logo.png", height = 150, width = 100),
         br("Juliette Verstaen - Communications and outreach manager"),
         br("Vienna Saccomanno - Editor"),
         br("Seleni Cruz - Data Manager"),
         br("Edaysi Bucio - Financial Manager"),
         br("Valeria Tamayo-Canadas - Project Manager"),
         br("Hunter Lenihan - Faculty Advisor"),
         br("Erin Winslow - PhD Advisor"),
         br(),
         img(height = 250, width =350, src = "group_pic.jpg"),
         
         h5("Analysis was completed with the support of the Sustainable Fisheries Group - The Bren School, UCSB"),
         br("Tracy Mangin, Juan Carlos Villasenor, Chris Free"),
         br("Christopher Costello - External Advisor"),
         br(),
         br()
         
         ) #tab5

  )#navbarpage

) #fluidPage
             

# Define server logic required to call images of outputs from www folder

server <- function(input, output, session) {
  
###output video
  #output$video <- a("cobi video", href = "https://cobi.org.mx/en/")
  #output$video <- renderUI({
   # taglist("URL link")
    #if(is.null(data()))
     # h6("Intro COBI", br(), tags$link(src ='', type="video/mp4", width = "400px", height = "350px", controls = "controls"))
     # return()
    
  #})
  
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
  
#####outputs for buttons 2 in model tab
  
    output$two_tables <- renderImage({
    # When input$n is 3, filename is ./images/image3.jpeg
    
##gif showing cost of no action
      
    #kobe_no0.3.gif <- normalizePath(file.path('www/',
                                          # paste(input$table, 
                                                # '.gif', 
                                                 #sep=''))) #normalizepath
    
    # Return a list containing the filename and alt text
    #list(src = kobe_no0.3.gif, 
       #  contentType = 'image/gif',
        # alt = paste("animation of KOBE plot showing how fisheries 
         #            will change in absence of marine reserves", input$table))#list
    
##table showing spp contribution to percent total catch
    
    table_percent.png <- normalizePath(file.path('www/',
                                         paste(input$table, 
                                               '.png', 
                                               sep=''))) #normalizepath
    
    list(src = table_percent.png,
         alt = paste("table showing the percent contribution of each species to total catch", input$table))
    
    parameters.png <- normalizePath(file.path('www/',
                                              paste(input$table, 
                                                    '.png', 
                                                    sep=''))
                                    ) #normalizepath
    
    list(src = parameters.png,
         alt = paste("Parameters used in the model", input$table))
    
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

