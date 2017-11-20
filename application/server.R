library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(htmltools)

source('plotting.R')

# Load Geo-json Data
print('Reading Data')
#topoData = geojsonio::geojson_read("data/json/few_buildings.json",what = "sp")
topoData =  geojsonio::geojson_read("data/json/buildings_switzerland_filtered_relative_and_compactness_score4.json", what = "sp")
print('Read')

# color palette
pal <- colorNumeric("viridis", NULL)
#pal_01 = colorRamp(c("#1a9988", "#eb5600"), interpolate="linear")
#pal = function(x){pal_01(x/1.5)}

function(input, output, session) {

  ## Interactive Map ###########################################
  

  # Create the map
  output$mymap <- renderLeaflet({
    
    # # Uncomment for empty Map
    # leaflet() %>% setView(lng = 8.5381227 , lat = 47.369878, zoom = 16) %>%
    #     addTiles(
    #       urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
    #       attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    #     )


    # # Uncomment for basic map
    # leaflet(topoData) %>%
    #   addTiles(
    #     urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
    #     attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    #   ) %>%
    #   setView(lng = 9.3708362 , lat = 47.4215067, zoom = 18) %>%
    #   addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
    #               fillColor =  ~pal(score),
    #               label = ~paste(sep = '\n',name,
    #                              'Heat Score: ', round(relative_intensity, 2),
    #                              'Compactness', round(compactness, 2),
    #                              'Total', round(score, 2))
    #   ) %>%
    # 
    #   addLegend(pal = pal, values = ~score, opacity = 1.0)
    
    leaflet(topoData) %>%
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>%
      setView(lng = 8.5381227 , lat = 47.369878, zoom = 16) %>%
      addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                  fillColor =  ~pal(score),
                  label = ~paste(sep = '\n',name,
                                 'Heat Score: ', round(relative_intensity, 2),
                                 'Compactness', round(compactness, 2),
                                 'Total', round(score, 2))
                  ) %>%

      addLegend(pal = pal, values = ~score, opacity = 1.0)

   })
  
  
  # Render the graphs on dashboard
  output$barplot <- renderPlot({
    generate_barplot()
  }, height = 600)
  
  output$scoreHTML = renderUI({
    
    includeHTML("www/score.html")
    
  })
  
  ##Experminetation with Mouseover shapes
  # output$mouseover_details = renderUI({
  #   
  #   print('Firing')
  #   mouseover = input$mymap_shape_mouseover
  #   print(mouseover)
  #   properties = mouseover$properties
  #   
  #   details = tags$div(
  #     tags$h3('Test'),
  #     tags$h3(properties$name)
  #   )
    
  #   return(details)
  #   
  # })
  
  # Render Image of ETH
  output$ETHImage <- renderUI({
    
    tags$div(style="position: relative; z-index: 1;",
             tags$img(src='creditsuisse.png', width = '100%', style="position: relative; z-index: 2; overflow:hidden"),
             tags$div(id="ETHTextOverlay", 
                      tags$span("Bahnhofstrasse"),
                      tags$br(), 
                      tags$span("8001 Zürich", style='font-size:20px'),
                      tags$br(),
                      tags$span("47°22'11.6N 8°32'21.4E", style='font-size:15px')
                       
             )
             
             )
    
  })
    

}
