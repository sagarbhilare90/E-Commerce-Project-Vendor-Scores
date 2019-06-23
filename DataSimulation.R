#Ecomm project
#data preprocessing and cleaning
dataset<-read.csv("proj.csv")
dataset$Order.Date<-as.Date(dataset$Order.Date,format="%m/%d/%Y")
dataset$ReturnPercent<- (dataset$Returned/dataset$Quantity)*100
dataset$RetainedPercent<-100-dataset$ReturnPercent

#dealing with na values
dataset$Vendor.Venue<-sub("#N/A", "Stark", dataset$Vendor.Venue)
dataset$Vendor.Name<-sub("#NAME", "Vendor11923", dataset$Vendor.Name)


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


#adding attributes(simulating new variables)
dataset$CostPrice<- (dataset$Item.Price)*(runif(nrow(dataset),0.7,0.99))*(runif(nrow(dataset),1.01,1.11))*(dataset$Quantity-dataset$Returned)
dataset$SellingPrice<- dataset$Item.Price*(dataset$Quantity-dataset$Returned)
dataset$Dispatches[1:nrow(dataset)]<-sample(0:1,nrow(dataset),replace = TRUE)
dataset$Delivery[1:nrow(dataset)]<- sample(0:1,nrow(dataset),replace = TRUE)
dataset$Profit<-dataset$SellingPrice-dataset$CostPrice



#write.csv(dataset, "Dataset.csv")
#arrange in decreasing ratings
#desc_ratings<-arrange(dataset,desc(Ratings))






