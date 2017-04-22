#DBScan clustering
sample_data <- crime_2016_omit[, c(7:8)]

# UTM to radial degree cinversion
library("rgdal")
utmcoor<-SpatialPoints(sample_data[1,], proj4string=CRS("+proj=utm +zone=10"))
longlatcoor<-spTransform(utmcoor,CRS("+proj=longlat"))
for(i in 2:9851){
  utmcoor<-SpatialPoints(sample_data[i,], proj4string=CRS("+proj=utm +zone=10"))
  
  longlatcoor1<-spTransform(utmcoor,CRS("+proj=longlat"))
  longlatcoor <- rbind(longlatcoor,longlatcoor1)
  
}
x<- data.frame(longlatcoor)

sample_dist<- earth.dist(x[1:7000,],dist = TRUE)

#dbscan::kNNdistplot()
dbscan::kNNdistplot(sample_dist, k =10)
abline(h = 0.45, lty = 2)

#DBScan Using dbscan class
dfs<- dbscan(sample_dist,0.45,10)

#showing Outliers with the black clor dots
library("factoextra")
fviz_cluster(dfs, x[1:7000,], geom = "point")

#simplify data with cluster
sample_crime_with_cluster <- data.frame(x[1:7000,],dfs$cluster)
sample_cluster0 <- subset(sample_crime_with_cluster, dfs$cluster==0)
sample_cluster1 <- subset(sample_crime_with_cluster, dfs$cluster==1) 
sample_cluster2 <- subset(sample_crime_with_cluster, dfs$cluster==2) 
sample_cluster3 <- subset(sample_crime_with_cluster, dfs$cluster==3) 

#remove outliers from original data
crime_2016_omit<- subset(crime_2016_omit,crime_2016_omit$X!=sample_cluster0[1,]$X)
for(z in 2:38){
  crime_2016_omit<- subset(crime_2016_omit,crime_2016_omit$X!=sample_cluster0[z,]$X)
}

