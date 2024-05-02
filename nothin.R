# Global env --------------------------------------------------------------

library(tidyverse)

library(shiny)

# ui ----------------------------------------------------------------------

ui <- fluidPage(
  headerPanel("Welcome to DateSelect!"),
  mainPanel(
    h4("Press the button to select your date"),
    h3(),
    tableOutput("tab")
  )
)


# server ------------------------------------------------------------------


server <- shinyServer(function(input, output, session) {


  
output$tab  <- renderTable({
read.csv(
      "https://docs.google.com/spreadsheets/d/e/2PACX-1vTDZAzPbFcNrTJleCI2xduG9RP7Bbvtmt7wCfnP3xNaXhJUWyuHBKmcu6MXe39I3IpPLgQIOvDeEv2N/pub?gid=0&single=true&output=csv"
    )
  })


  

  
})

shinyApp(ui, server)
