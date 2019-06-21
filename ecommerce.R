#Ecomm project
#data preprocessing and cleaning
dataset<-read.csv("proj.csv")
dataset$Order.Date<-as.Date(dataset$Order.Date,format="%Y/%m/%d")
dataset$ReturnPercent<- (dataset$Returned/dataset$Quantity)*100
dataset$RetainedPercent<-100-dataset$ReturnPercent


# Company ratings as per returned goods.
for (i in 1:nrow(dataset)){
    if (dataset$RetainedPercent[i]>85){
    dataset$Ratings[i]=5
}

  else if (dataset$RetainedPercent[i]>70 & dataset$RetainedPercent[i]<=85){
    dataset$Ratings[i]=4
}
  else if (dataset$RetainedPercent[i]>60 & dataset$RetainedPercent[i]<=70){
    dataset$Ratings[i]=3
  }
  else if (dataset$RetainedPercent[i]>40 & dataset$RetainedPercent[i]<=60){
    dataset$Ratings[i]=2
  }
  else if (dataset$RetainedPercent[i]<40){
    dataset$Ratings[i]=1
  }
}


#adding attributes
dataset$CostPrice<- dataset$Item.Price*rnorm(nrow(dataset),mean = 0.9,sd=.45)*(dataset$Quantity-dataset$Returned)
dataset$SellingPrice<- dataset$Item.Price*(dataset$Quantity-dataset$Returned)
dataset$Dispatches[1:nrow(dataset)]<-factor(c("Delayed","On time"))
dataset$Delivery[1:nrow(dataset)]<- sample(factor(c("Delayed","On time")))

#write.csv(dataset, "Dataset.csv")
#arrange in decreasing ratings
#desc_ratings<-arrange(dataset,desc(Ratings))



#dealing with na values
#for (i in 1:nrow(dataset)){
 # for (j in 1:ncol(dataset)) {
  #  if (is.na(dataset[i,j])==TRUE){
   #   dataset[i,j]=mean(dataset[,j])
#    }
 # }

#}

#primary visualiation
g<-ggplot(dataset)
g+geom_point(aes(RetainedPercent,Ratings))



