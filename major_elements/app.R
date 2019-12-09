##App to create plots of differing major elements against Silica
##Load packages and data into file

library(shiny)
library(dplyr)
library(tidyverse)
mydata_2 <- read.csv("C:/Users/labry/Documents/R/final_project_490/data/earthchem_dataset2.csv")
sio2_sort <- select(mydata_2, "SAMPLE.ID":"TITLE", "METHOD":"P2O5") %>% 
  filter(mydata_2$SIO2 != "NA") %>%  
  filter(grepl("HAWAII", TITLE))

sio2_elements <- select(sio2_sort, "SIO2":"P2O5")

##create set of variables to choose from
elementch <- c("Choose Element" = "", "TIO2", "AL203", "CR2O3", "FE203", "FE203T", "FEO", "FEOT", "NIO", "MNO", "MGO", "CAO", "SRO", "NA2O", "K2O", "P205") 


# Define UI for application that draws a scatterplot
ui <- fluidPage(

    # Application title
    titlePanel("Major Element Comparision with Silica"),

    # Sidebar with a dropdown menu for title and elements
    sidebarLayout(
        sidebarPanel(
            textInput("plot_title", "Title of Your Plot"),
            selectInput("element", "Choose an element", elementch),
            actionButton("action", "Create Plot")
            ),
        
        # Show a plot of the ggenerated values
        mainPanel(
           plotOutput("plot")
        )
    )
)

# Define server logic required to draw a scatterplot
server <- function(input, output) {
 
  myplot <- eventReactive(input$action, {
    ggplot(sio2_elements, aes(x = sio2_sort$SIO2, y = input$element)) + 
      geom_point() + 
      ggtitle(input$plot_title)
  })
  
  output$plot <- renderPlot({
    
    myplot()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
