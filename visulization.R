#Bar chart
counts <- table(crime_2016$TYPE)
barplot(counts, main="Crime type Distribution",ylim = c(0,4000),col=c("Red","Yellow","Green","pink","Orange","Brown","Grey","violet"),las=2, axisnames = T,cex.names = 0.8)

#Boxplot for comparing different variable
boxplot(crime_2016_omit,las=1,names= c(crime_2016),col = c("Red","Yellow","Green","blue","Orange","Brown","Grey","violet"), main="Comparison of all the attribute of dataset")

#scatter plot
plot(crime_2016$X,crime_2016$Y)
