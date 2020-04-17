library(RJSONIO)  #zum Konvertierung von JSON-Objekte
library(ggplot2)  #zur Datenvisualisierung
library(ggmap)    #zur Integration von Kartenmaterial bei der Datenvisualisierung in 
library(dplyr)    #zur (komfortableren) Verarbeitung von Data-Frames
library(knitr)    #zur Erstellung dieses Blogposts
library(rmarkdown)#zur Erstellung dieses Blogposts
library(nominatim)#Um Adressdaten zu suchen
library(keyring)

# get API Key from OS X Keychain

secret <- rstudioapi::askForSecret("MapQuest Key")

secret.g <- rstudioapi::askForSecret("Google API Key")


#Arbeitsverzeichns festlegen
setwd("/Users/fuellerh/Documents/Arbeit/Projekte/WebtechUrbanism")

# Help function to look up addresses through OSM



# Style of Map
myMapTheme <- theme(legend.position="bottom",
                    panel.grid.major=element_blank(),
                    panel.grid.minor=element_blank(),
                    axis.title=element_blank(),
                    axis.ticks=element_blank(),
                    axis.text=element_blank(),
                    panel.background = element_rect(fill = "white"))


#CSV-Sheet einlesen

webtech_berlin <- read.csv("data/Webtech_Berlin.csv", stringsAsFactors=FALSE)

# Using the function myOSMGeoCode to find coordinates

for(i in 1:dim(webtech_berlin)[1]){
  
  street <- webtech_berlin[i, "Street"]
  zip <- webtech_berlin[i, "ZIP"]
  city <- webtech_berlin[i, "City"]
  country <- webtech_berlin[i, "Country"]
  
  query <- c(street, zip, city, country)
  
  geo.data <- osm_geocode(query, key = secret)
  
  webtech_berlin[i,"Lon"] <- geo.data$lon[1]
  webtech_berlin[i, "Lat"] <- geo.data$lat[1]
  webtech_berlin[i, "Class"] <- geo.data$class[1]
}

write.csv(webtech_berlin, "data/webtech_located.csv", row.names = TRUE)



# Get a Map of Berlin as a Background (old method, now replaced with leaflet in Rmarkdown File)
# register_google (key=secret.g)
# map.berlin <- get_map(location = "Berlin, Germany", source = "google", color = "bw")

# wt_map <- ggmap(map.berlin)
# wt_map <- wt_map + geom_point(data=webtech_berlin, aes(x=Lon, y=Lat), color="blue", alpha=1, size=1)
# wt_map <- wt_map + geom_text(data=webtech_berlin, aes(x=Lon, y=Lat, label=Firma), hjust=0, vjust=0, fontface="plain", color="blue", size=2)
# g <- wt_map + myMapTheme
# g
# ggsave("WebtechKarteBerlin.png" )
