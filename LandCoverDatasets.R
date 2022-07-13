
library(sf)
library(terra)


#state <- sf::st_read('L:/Projects_active/EnviroScreen/data/geographies/state/colorado.geojson')

counties <- tigris::counties(state = "CO")

land <- terra::rast('L:/Projects_active/EnviroScreen/data/NLCD/Land Cover/nlcd_2019_land_cover_l48_20210604.img') 

#transforming counties is easier than land. Will transform cropped/smaller landcover in lesson
counties <- st_transform(counties, crs(land))

land_co <- land %>% 
  terra::crop(vect(counties)) %>%
  terra::mask(vect(counties))


#aggregate to ~1km for ease of processing/analysis in course
land_co1km <- terra::aggregate(land_co, fact = 33, fun = "modal")

terra::writeRaster(land_co1km, filename = "data/NLCD_CO.tif", overwrite = TRUE)
