# Global env --------------------------------------------------------------

library(tidyverse)

library(shiny)

library(googlesheets4)


df <- read.csv(
  "https://docs.google.com/spreadsheets/d/e/2PACX-1vTDZAzPbFcNrTJleCI2xduG9RP7Bbvtmt7wCfnP3xNaXhJUWyuHBKmcu6MXe39I3IpPLgQIOvDeEv2N/pub?gid=0&single=true&output=csv"
)

gs4_deauth()



df <- read_sheet(
  ss = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTDZAzPbFcNrTJleCI2xduG9RP7Bbvtmt7wCfnP3xNaXhJUWyuHBKmcu6MXe39I3IpPLgQIOvDeEv2N/pub?gid=0&single=true&output=csv"
  )

options <- df[, 1]




# ui ----------------------------------------------------------------------

ui <- fluidPage(
  headerPanel("Welcome to DateSelect!"),
  mainPanel(
    h4("Press the button to select your date"),
    actionButton("select",
                 "Select!",
                 icon = icon("hand-holding-heart")),
    textOutput("choice") 
    
    # %>%
    #   span(style = "font-weight: bold")
  )
)


# server ------------------------------------------------------------------


server <- shinyServer(function(input, output, session) {
  
  observe({
    output$choice <- renderPrint({
      sample(options, 1) %>%
        cat
    }) %>% 
      bindEvent(input$select,
                ignoreInit = TRUE)
  })
  
})

shinyApp(ui, server)
