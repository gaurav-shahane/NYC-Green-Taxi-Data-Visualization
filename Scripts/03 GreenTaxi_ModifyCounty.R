#The script modifies county of below mentioned ZIPs as southern_NY. This is South Manhattan area where Green Taxi 
#is not allowed to pickup the passanger.

# Set working directory
setwd("C:\\Users\\gaura\\Documents\\MIM - UMCP\\3rd Sem\\Visualization\\Final Project\\shapefile")

#Separating New York COunty in Southern Manhattan and Northen Manhatan
#d<-read.csv('data_green_all.csv', stringsAsFactors = FALSE)
d<-read.csv('green_viz2015_all.csv', stringsAsFactors = FALSE)

d[(d$zip ==10001)|(d$zip==10002)|(d$zip==10024)|(d$zip==10003)|(d$zip==10004)|(d$zip==10006)|(d$zip==10007)
  |(d$zip==10010)|(d$zip==10011)|(d$zip==10012)|(d$zip==10013)|(d$zip==10014)|(d$zip==10016)|(d$zip==10017)
  |(d$zip==10018)|(d$zip==10019)|(d$zip==10021)|(d$zip==10022)|(d$zip==10023)|(d$zip==10028)|(d$zip==10036)
  |(d$zip==10038)|(d$zip==10065)|(d$zip==10075) |(d$zip==10278)|(d$zip==10282)|(d$zip==10280)|(d$zip==10281)
  |(d$zip==10020)|(d$zip==10009), 'county'] <- 'southern_NY'

d[(d$drop_zip==10001)|(d$drop_zip==10002)|(d$drop_zip==10024)|(d$drop_zip==10003)|(d$drop_zip==10004)|(d$drop_zip==10006)
  |(d$drop_zip==10007)|(d$drop_zip==10010)|(d$drop_zip==10011)|(d$drop_zip==10012)|(d$drop_zip==10013)|(d$drop_zip==10014)
  |(d$drop_zip==10016)|(d$drop_zip==10017)|(d$drop_zip==10018)|(d$drop_zip==10019)|(d$drop_zip==10021)|(d$drop_zip==10022)
  |(d$drop_zip==10023)|(d$drop_zip==10028)|(d$drop_zip==10036)|(d$drop_zip==10038)|(d$drop_zip==10065)|(d$drop_zip==10075)
  |(d$drop_zip==10278)|(d$drop_zip==10282)|(d$drop_zip==10280)|(d$drop_zip==10281)|(d$drop_zip==10020)|(d$drop_zip==10009),
  'drop_county'] <- 'southern_NY'

write.csv(d, 'data_green_all2015later_newzips.csv')
