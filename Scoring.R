#Ecommerce project
library(dplyr)
#import dataset
dataset<-read.csv("Dataset.csv")
dataset$Profit<-dataset$SellingPrice-dataset$CostPrice
dataset$ProfitPercent<- dataset$Profit*100/dataset$CostPrice
Sub_dataset<- select(dataset, Order.Source, Customer.Name, Vendor.Venue, Vendor.Name,
                   Order.Date, State, Zip.code,Ratings, Dispatches, Delivery, ProfitPercent)

for (i in 1:nrow(Sub_dataset)){
  if (Sub_dataset$Delivery[i]==0){
    Sub_dataset$Score[i]<- Sub_dataset$Ratings[i]*Sub_dataset$ProfitPercent[i]*10 }
  #late Delivery
  # }else
  #  if(Sub_dataset$Delivery[i]<Sub_dataset$Dispatches[i]){
  #   Sub_dataset$Score[i]<- Sub_dataset$Ratings[i]*Sub_dataset$ProfitPercent[i]*10 #late Delivery
  # }
    else
   if(Sub_dataset$Delivery[i]==1){
    Sub_dataset$Score[i]<- Sub_dataset$Ratings[i]*Sub_dataset$ProfitPercent[i]*100} #on time Deilvery
  # }else
  #  if (Sub_dataset$Delivery[i]>Sub_dataset$Dispatches[i]){
  #   Sub_dataset$Score[i]<- Sub_dataset$Ratings[i]*Sub_dataset$ProfitPercent[i]*100 #on time Delivery
  # }
    
  }
