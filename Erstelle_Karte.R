library(ggmap)
library(keyring)
secret <- rstudioapi::askForSecret("Google API")
register_google(key = secret, write = TRUE)
library(tidyverse)
library(readr)
library(ggplot2)

#Aktuelles Programm einlesen

HEXprogramm <- read.csv("data/HEX-programm.csv")

# Karte erzeugen

library(sf)
library(mapview)
HEX <- st_as_sf(HEXprogramm, coords = c("lon", "lat"), crs = 4326)
mapview (HEX, zcol = "Ziele", legend = TRUE)
