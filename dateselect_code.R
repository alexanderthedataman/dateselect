# Global env --------------------------------------------------------------

library(tidyverse)

library(shiny)

library(audio)

library(wav)

library(shinyjs)

library(future)

library(promises)

df <-
  read.csv(
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vTDZAzPbFcNrTJleCI2xduG9RP7Bbvtmt7wCfnP3xNaXhJUWyuHBKmcu6MXe39I3IpPLgQIOvDeEv2N/pub?gid=0&single=true&output=csv"
  )

options <- df[, 1]

drumroll <- play(read_wav("drumroll.wav"),
                 rate = 48000)
pause(drumroll)

crash <- play(read_wav("crash.wav"),
              rate = 48000)
pause(crash)


snark <- c("Enough already!",
           "Stop it!",
           "Please stop the music",
           "Just tell me already"
           )



# ui ----------------------------------------------------------------------

ui <- fluidPage(
  useShinyjs(),
  headerPanel("Welcome to DateSelect!"),
  mainPanel(
    h4("Press the button to select your date"),
    actionButton("select",
                 "Select!",
                 icon = icon("hand-holding-heart")),
    actionButton("enough",
                 label = sample(snark,1)),
    h3(),
    textOutput("choice") %>%
      span(style = "font-weight: bold")
  )
)


# server ------------------------------------------------------------------


server <- shinyServer(function(input, output, session) {
  # On init
  shinyjs::hide("enough")

  # On select
  
  observe({
    future_promise() %...>%
      {
        Sys.sleep(3)
        shinyjs::show("enough")
      }
    rewind(drumroll)
    resume(drumroll)
    shinyjs::hide("select")
  }) %>%
    bindEvent(input$select,
              ignoreInit = TRUE)
  
  # On second button
  
  observe({
    
    future_promise() %...>%
      {
        Sys.sleep(3)
        shinyjs::show("select")
      }
    
      output$choice <- renderPrint({
        sample(options, 1) %>%
          cat
      })
      
      pause(drumroll)
      rewind(crash)
      resume(crash)
      shinyjs::hide("enough")

  }) %>% bindEvent(input$enough,
                   ignoreInit = TRUE)

})

shinyApp(ui, server)
