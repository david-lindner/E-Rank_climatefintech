source('plotting.R')
library(leaflet)
library(shinydashboard)




panel =   tabPanel("Interactive map",
                   div(class="outer",
                       
                       tags$head(
                         # Include our custom CSS
                         includeCSS("www/styles.css"),
                         includeScript("www/gomap.js"),
                         tags$link(href = "https://fonts.googleapis.com/css?family=Raleway", rel='stylesheet')
                       ),
                       
                       # If not using custom CSS, set height of leafletOutput to a number instead of percent
                       leafletOutput("mymap", width="100%", height="100%")
                       #,
                       # Shiny versions prior to 0.11 should use class = "modal" instead.
                       # absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                       #               draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                       #               width = 330, height = "auto",
                       #               
                       #               h2("Eco-Rank")
                       # )
                   )
)


main_title =
  tags$div(
    tags$span('E -', style="color: #eb5600"),
    tags$span("Rank", style="color: #1a9988"),
    style = 'font-family:Raleway'
  )


header = dashboardHeader(title = main_title)

sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Maps", tabName = "map", icon = icon("map")),
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
  )
)

body= dashboardBody(
  tabItems(
    # First tab content
    tabItem(tabName = "map",
            panel
    ),
    
    # Second tab content
    tabItem(tabName = "dashboard",
            
            fluidRow(
              box(width = 6,
                uiOutput("scoreHTML")
              )
            ),
            
            fluidRow(
              column(width = 6,
                  uiOutput("ETHImage")
              ),
              
              box(width = 6, height = 650,
                      plotOutput("barplot")
              )
              

            )
    )
  )
)

dashboardPage(header, sidebar, body, skin = "black")