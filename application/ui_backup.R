library(leaflet)
library(shinydashboard)

# Choices for drop-downs
vars <- c(
  "Is SuperZIP?" = "superzip",
  "Centile score" = "centile",
  "College education" = "college",
  "Median income" = "income",
  "Population" = "adultpop"
)


panel =     tabPanel("Interactive map",
                     div(class="outer",
                         
                         tags$head(
                           # Include our custom CSS
                           includeCSS("www/styles.css"),
                           includeScript("www/gomap.js"),
                           tags$link(href = "https://fonts.googleapis.com/css?family=Raleway:400,300,600,800,900")
                         ),
                         
                         # If not using custom CSS, set height of leafletOutput to a number instead of percent
                         leafletOutput("mymap", width="100%", height="100%"),
                         
                         # Shiny versions prior to 0.11 should use class = "modal" instead.
                         absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                       draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                       width = 330, height = "auto",
                                       
                                       h2("Eco-Rank")
                         )
                     )
)


header <- dashboardHeader( title = "SXC Maps")

sidebar <- dashboardSidebar(
  menuItem("Map", tabName = "map", icon = icon("map")),
  menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
)

# body <- dashboardBody(
#   tabItems(
#     tabItem(tabName = "map",
#             panel
#     ),
#     
#     tabItem(tabName = "dashboard",
#             h2("Widgets tab content")
#     )
#   )
#   
# )

body = dashboardBody()

dashboardPage(header, sidebar, body, skin = "black")


