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


#Sub_dataset<- select(dataset, Order.Source, Customer.Name, Vendor.Venue, Vendor.Name,
  #               Order.Date, State, Zip.code,Ratings, Dispatches, Delivery, ProfitPercent)


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


#Grouping data based on Order Source
library(ggplot2)
library(dplyr)
dataset<- read.csv("ScoreData.csv",stringsAsFactors = FALSE)
dataset<-dataset[,3:ncol(dataset)]
dataset$Order_count<- 1
Order_Sum<- group_by(dataset, Order.Source)%>%
  summarise(No_of_transaction=sum(Order_count),Mean_Rating=mean(Ratings),Mean_Score=mean(Score))

#Grouping data based on State
State_Sum<- group_by(dataset, State)%>%
  summarise(No_of_transaction=sum(Order_count),Mean_Rating=mean(Ratings),Mean_Score=mean(Score))

#Grouping data based on Vendor Venue
Venue_Sum<- group_by(dataset, Vendor.Venue)%>%
  summarise(No_of_transaction=sum(Order_count),Mean_Rating=mean(Ratings),Mean_Score=mean(Score))

#Grouping data based on Vendor Name
Vendor_Sum<- group_by(dataset, Vendor.Name)%>%
  summarise(No_of_transaction=sum(Order_count),Mean_Rating=mean(Ratings),Mean_Score=mean(Score))

#based on Order Source
Orderb<- ggplot(data = Order_Sum, aes(x=Order.Source,y= Mean_Rating,fill=Order.Source))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+ggtitle("Average ratings Vs Source of Order") +
xlab("Source of Order")+
ylab("Average Rating")

Orderb1<- ggplot(data = Order_Sum, aes(x=Order.Source,y= Mean_Score,fill=Order.Source))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+ggtitle("Average Score Vs Source of Order") +
  xlab("Source of Order")+
  ylab("Average Score")


#Visualisation based on State
Stateb<- ggplot(data = State_Sum, aes(x=State,y= Mean_Rating,fill=State))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+
  ggtitle("Average ratings Vs State") +
  xlab("State")+
  ylab("Average Rating")

Stateb1<- ggplot(data = State_Sum, aes(x=State,y= Mean_Score,fill=State))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+ggtitle("Average Score Vs State") +
  xlab("State")+
  ylab("Average Score")

#Visualisation based on Vendor Venue
Venueb<- ggplot(data = Venue_Sum, aes(x=Vendor.Venue,y= Mean_Rating,fill=Vendor.Venue))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+
  ggtitle("Average ratings Vs Vendor Venue") +
  xlab("Vendor Venue")+
  ylab("Average Rating")

Venueb1<- ggplot(data = Venue_Sum, aes(x=Vendor.Venue,y= Mean_Score,fill=Vendor.Venue))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+ggtitle("Average Score Vs Vendor Venue") +
  xlab("Vendor venue")+
  ylab("Average Score")

#Visualisation based on Vendor Name
Vendorb<- ggplot(data = Vendor_Sum, aes(x=Vendor.Name,y= Mean_Rating,fill=Vendor.Name))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+
  ggtitle("Average ratings Vs Vendor name") +
  xlab("Vendor Name")+
  ylab("Average Rating")

Vendorb1<- ggplot(data = Vendor_Sum, aes(x=Vendor.Name,y= Mean_Score,fill=Vendor.Name))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+ggtitle("Average Score Vs Vendor Name") +
  xlab("Vendor Name")+
  ylab("Average Score")

VisualSelect<- function(num){
  
  if (num==1){Orderb
    Orderb1}
  else if (num==2){
    Stateb
    Stateb1
  }
  else if (num==3){
    Venueb
    Venueb1
  }
  else if(num==4){
    Vendorb
    Vendorb1
  }
  else {
    print("Wrong Input")
  }
}

print("Dependence on Order Source  : 1
Dependence on State         : 2
Dependence on vendor Venue  : 3
Dependence on vendor name   : 4")
num= readline("Enter the Visual Number")
num=as.numeric(num)
VisualSelect(num)
