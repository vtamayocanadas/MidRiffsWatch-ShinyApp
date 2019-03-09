##
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
library(here)
library(plotly)
library(tidyverse)
library(gganimate)
library(ggrepel)
library(ggridges)
library(ggpubr)
library(gridExtra)
library(grid)
#height = 300, width =500, src = "logo-cobi-hd.png"


#View(data)
ui <- navbarPage(title = "Midriff's Watch Tool",
                
        tabPanel(title = "Background", #tab1
                 tags$h2("Welcome to the MidRiff Islands - Mexico!"),
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
     
        tabPanel(title = "Conservation, Food and Livelihoods", #tab2
        h3("Select Biomass, Catch or Profits and compare hte projections made with different marine reserve scenarios."), 
        p("There are four Marine Reserve size scenarios: Busniness as Usual (BAU), 5%, 20%, and 40% of the Midriff Islands 
          region in the Gulf of California (study area)."), #text description
       
         navlistPanel(h3("This is the current (2019) status of the 13 main fisheries in the MidRiff Islands"), 
                      img(height = 500, width =800, src = "kobe_w_labels.jpg")
          ), #dropdown menu
        
        radioButtons(inputId="metrics", label = "Choose Biomass Fisheries Metrics",
                     c("Biomass (MT)",
                       "Catch (MT)",
                       "Profit (USD)")),
        mainPanel(
          tabsetPanel(
            type="tab",
            tabPanel("Biomass",
            plotOutput("projectionB")),
          tabPanel("Catch",
            plotOutput("projectionC")),
          tabPanel("Profit",
            plotOutput("projectionP"))
          )
        )),   #tab2
                                       
               
      tabPanel(title = "Explore the Fisheries", #tab3
               navlistPanel(
                  navbarMenu(title = "Choose one",
                           tabPanel((strong("Clam")), em("Atrina tuberculosa")),
                           tabPanel((strong("Crab")),em("Callinectes bellicosus")),
                           tabPanel((strong("Graysby")),em("Cephalopolis cruentata")),
                           tabPanel((strong("Diamond Stingray")),em("Dasyatis dipterura")),
                           tabPanel((strong("Rooster Hind")),em("Epinephelus acanthistius")),
                           tabPanel((strong("Yellow Snapper")),em("Lutjanus argentiventris")),
                           tabPanel((strong("Gulf Weakfish")),em("Cynoscion othonopterus")),
                           tabPanel((strong("White mullet")),em("Mugil curema")),
                           tabPanel((strong("Octopus")),em("Octopus bimaculatus")),
                           tabPanel((strong("Lobster")),em("Panilurus inflatus")), 
                           tabPanel((strong("Atlantic Spanish Mackerel")),em("Scomberomorus maculatus")), 
                           tabPanel((strong("Bullseye puffer")),em("Sphoeroides annulatus")), 
                           tabPanel((strong("Pacific Angel Shark")),em("Squatina californica")) 
                          )
                  )
               )#tab3  
      )#main ui close token              
                     


# Define server logic required to draw a histogram
server <- function(input, output) {
    
  
    output$projectionB <- renderPlot({
      res <- read.csv("www/PatchModel_size.csv")
      linedf<-res%>%
        group_by(Adjusted, Scenario, Size, Year)%>%
        summarize(Biomass_est=sum(Biomass_est)/1000, 
                  Biomass_lo=sum(Biomass_lo)/1000, 
                  Biomass_hi=sum(Biomass_hi)/1000,
                  Catch_est=sum(Catch_est)/1000,
                  Catch_lo=sum(Catch_lo)/1000, 
                  Catch_hi=sum(Catch_hi)/1000, 
                  PV_est=sum(PV_est)/1000000,
                  PV_lo=sum(PV_lo)/1000000, 
                  PV_hi=sum(PV_hi)/1000000)
      plot2<- linedf%>%
        filter(Adjusted=="MT")%>%
        filter (Scenario =="2015"|Scenario == "0")%>%
        filter(!(Size=="50%"))
      
      plot2$Size <- factor(plot2$Size, levels = c("BAU", "5%", "20%", "40%"))
      
      output$Biomass<-ggplot(plot2, aes(x=Year, y= Biomass_est, group=Size, color=Size))+
        geom_line(size=1.5)+
        labs(subtitle= "Biomass", y="1000s MT")+
        theme_classic(base_size = 24) 
      
      
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

