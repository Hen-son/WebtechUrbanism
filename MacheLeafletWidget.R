library(leaflet)
library(dplyr)


webtech_berlin <- read.csv("data/webtech_located.csv", stringsAsFactors=FALSE)
label <- paste(sep = "<br/>", webtech_berlin$Firma, webtech_berlin$URL)

WebtechKarte <- leaflet(data = webtech_berlin) %>%
  addTiles() %>% # Add default OpenStreetMap map tiles
  addMarkers(lng= ~Lon, lat= ~Lat, popup = ~as.character(label), label = ~as.character(Firma))

# # # save a stand-alone, interactive map as an html file
library(htmlwidgets)
saveWidget(widget = WebtechKarte, file = 'WebtechBerlin.html', selfcontained = T)
