library(maptools)
library(ggplot2)
require("rgdal") # requires sp, will use proj.4 if installed
require("maptools")
require("ggplot2")
require("plyr")
require(sp)
require(rgdal)
require(maps)

# Set working directory
setwd("C:\\Users\\gaura\\Documents\\MIM - UMCP\\3rd Sem\\Visualization\\Final Project\\shapefile")

# reading data/shapefile
zip_area <- readShapePoly("ZIP_CODE_040114.shp")

# Plot Area
zip = readOGR(dsn=".", layer="ZIP_CODE_040114")
zip@data$id = rownames(zip@data)
zip.points = fortify(zip, region="id")
zip.df = join(zip.points, zip@data, by="id")

#ggplot(zip.df, aes(x=long, y=lat, group = group)) + geom_point()
#ggplot() + geom_path(data = zip_area, aes(x=long, y=lat, group = group))

summary(zip_area)

#Join Shapefile with Taxi Data
class(green_sample)
coordinates(green_sample) <- ~Pickup_longitude+Pickup_latitude
proj4string(green_sample)<- proj4string(zip)
proj4string(green_sample)<- CRS("+proj=longlat +datum=NAD83")
green_sample<- spTransform(green_sample, CRS(proj4string(zip)))
identical(proj4string(green_sample), proj4string(zip))
summary(zip)
proj4string(zip)

#Only the locations inside the map
inside_zip<- !is.na(over(green_sample, as(zip, "SpatialPolygons")))
mean(inside_zip)
#inside_zip<- over(green_sample, as(zip, "SpatialPolygons"))
green_map <- as.data.frame(inside_zip)

#Compute ZIPs
green_sample$zip <- over(green_sample, zip)
green <- as.data.frame(green_sample)
green['population']<-green$zip['POPULATION']
green['area']<-green$zip['AREA']
green['po_name']<-green$zip['PO_NAME']
green['county']<-green$zip['COUNTY']
green['inside_zip'] <- green_map['inside_zip']
green['zip']<-green$zip['ZIPCODE']
#write.csv(green, "greenTaxiWithZip_all.csv")

#Draw the map
green_viz <- subset(green, green$inside_zip != 'FALSE')
ggplot() + geom_path(data = zip, aes(x=long, y=lat, group = group)) + geom_point(data = green_viz, aes(x= Pickup_longitude, y=Pickup_latitude), color = "green")

#Save data for all the points inside the map
#write.csv(green_viz, "green_viz.csv")



#Repeate the procedure for Dropoff locations

#Join Shapefile with Taxi Data
class(green_viz)
coordinates(green_viz) <- ~Dropoff_longitude+Dropoff_latitude
proj4string(green_viz)<- proj4string(zip)
proj4string(green_viz)<- CRS("+proj=longlat +datum=NAD83")
green_viz<- spTransform(green_viz, CRS(proj4string(zip)))
identical(proj4string(green_viz), proj4string(zip))
summary(zip)
proj4string(zip)

#Only the locations inside the map
inside_zip<- !is.na(over(green_viz, as(zip, "SpatialPolygons")))
mean(inside_zip)
#inside_zip<- over(green_sample, as(zip, "SpatialPolygons"))
green_map_drop <- as.data.frame(inside_zip)

#Compute ZIPs
green_viz$drop_zip <- over(green_viz, zip)
green <- as.data.frame(green_viz)
green['drop_population']<-green$drop_zip['POPULATION']
green['drop_area']<-green$drop_zip['AREA']
green['drop_po_name']<-green$drop_zip['PO_NAME']
green['drop_county']<-green$drop_zip['COUNTY']
green['drop_inside_zip'] <- green_map_drop['inside_zip']
green['drop_zip']<-green$drop_zip['ZIPCODE']
#write.csv(green, "greenTaxiWithZip_all.csv")

#Draw the map
green_viz <- subset(green, green$drop_inside_zip != 'FALSE')
ggplot() + geom_path(data = zip, aes(x=long, y=lat, group = group)) + geom_point(data = green_viz, aes(x= Dropoff_longitude, y=Dropoff_latitude), color = "green")

#Save data for all the points inside the map
write.csv(green_viz, "green_viz_July.csv")

#Remove all objects in R
rm(list = ls())

