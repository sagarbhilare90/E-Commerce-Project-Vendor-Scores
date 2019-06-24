#Ecommerce project
library(dplyr)
#import dataset
dataset<-read.csv("Dataset.csv")
dataset$Profit<-dataset$SellingPrice-dataset$CostPrice
dataset$ProfitPercent<- dataset$Profit*100/dataset$CostPrice


#dealing with na values
dataset$Vendor.Venue<-sub("#N/A", "Stark", dataset$Vendor.Venue)
dataset$Vendor.Name<-sub("#NAME", "Vendor11923", dataset$Vendor.Name)
for (i in 1:nrow(dataset)){
if (is.na(dataset$ProfitPercent[i])==TRUE){
dataset$ProfitPercent[i]=0
    }
 }


#Generating Scores
for (i in 1:nrow(dataset)){
  if (dataset$Delivery[i]==0){
    dataset$Score[i]<- (dataset$Ratings[i]/5)*dataset$ProfitPercent[i]*0.5 } #late Delivery

    else
   if(dataset$Delivery[i]==1){
    dataset$Score[i]<- (dataset$Ratings[i]/5)*dataset$ProfitPercent[i]*1} #on time Deilvery
}



#final scores on a scale of 0-100
dataset$Score<- (dataset$Score-min(dataset$Score))*100/(max(dataset$Score)-min(dataset$Score))
write.csv(dataset, "ScoreData.csv")
