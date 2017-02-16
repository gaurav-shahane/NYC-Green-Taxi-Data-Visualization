#The script will visualize New York Shapefile, Project the Taxi data on it, Calculate points that fall in New York Shapefiles,
#Identify ZIPs, append them to the Taxi Data with ZIP informatiopn, Write the modified data file


library(maptools)
library(ggplot2)
require("rgdal") # requires sp, will use proj.4 if installed
require("maptools")
require("ggplot2")
require("plyr")
require(sp)
require(rgdal)
require(maps)


setwd("C:\\Users\\gaura\\Documents\\MIM - UMCP\\3rd Sem\\Visualization\\Final Project\\shapefile")


# reading data/shapefile
zip_area <- readShapePoly("ZIP_CODE_040114.shp")

#plot(zip_area)

zip = readOGR(dsn=".", layer="ZIP_CODE_040114")
zip@data$id = rownames(zip@data)
zip.points = fortify(zip, region="id")
zip.df = join(zip.points, zip@data, by="id")

ggplot(zip.df, aes(x=long, y=lat, group = group)) + geom_point()
ggplot() + geom_path(data = zip_area, aes(x=long, y=lat, group = group))

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
inside_zip<- over(green_sample, as(zip, "SpatialPolygons"))
green_map <- as.data.frame(inside_zip)

#Compute ZIPs
green_sample$zip <- over(green_sample, zip)
green <- as.data.frame(green_sample)

green['population']<-green$zip['POPULATION']

green['zip']<-green$zip['ZIPCODE']    #['ZIPCODE']
abc<-green$zip['ZIPCODE'] 
#['POPULATION']
green['area']<-green$zip['AREA']
green['cty_fips']<-green$zip['CTY_FIPS']
green['z_id']<-green$zip.id
green['inside_zip'] <- green_map['inside_zip']
class(green)
write.csv(green, "greenTaxiWithZip_2.csv")

#Draw the map
green_viz <- subset(green, inside_zip =! '')
ggplot() + geom_path(data = zip, aes(x=long, y=lat, group = group)) + geom_point(data = green_viz, aes(x= Pickup_longitude, y=Pickup_latitude), color = "green")

names(greenDf)

#Write data file for the data points that fall in the shape file area
#Repeat the procedure for all the monthwise data files
write.csv(green_viz, "green_viz.csv")
