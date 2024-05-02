# Global env --------------------------------------------------------------

library(tidyverse)

library(shiny)

# ui ----------------------------------------------------------------------

ui <- fluidPage(
  headerPanel("Welcome to DateSelect!"),
  mainPanel(
    h4("Press the button to select your date"),
    tableOutput("tab")
  )
)


# server ------------------------------------------------------------------


server <- shinyServer(function(input, output, session) {

  output$tab  <- renderTable({
    read.csv("data.csv")
  })
  

})

shinyApp(ui, server)
