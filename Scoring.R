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
dataset<- read.csv("ScoreData.csv",stringsAsFactors = FALSE)
dataset<-dataset[,3:ncol(dataset)]
dataset$Order_count<- 1
Order_Sum<- group_by(dataset, Order.Source)%>%summarise(OS=sum(Order_count))
Order_Scr<- group_by(dataset, Order.Source)%>%summarise(OSc=sum(Score))
Order_Sum$Scale<- (Order_Sum$OS-min(Order_Sum$OS))*100/(max(Order_Sum$OS)-min(Order_Sum$OS))
Order_Sum$Scale<- Order_Sum$Scale*100/sum(Order_Sum$Scale)
Order_Scr$Scale<- (Order_Scr$OSc-min(Order_Scr$OSc))*100/(max(Order_Scr$OSc)-min(Order_Scr$OSc))
Order_Scr$Scale<- Order_Scr$Scale*100/sum(Order_Scr$Scale)


#Grouping data based on State
State_Sum<- group_by(dataset, State)%>%summarise(SS=sum(Order_count))
State_Scr<- group_by(dataset, State)%>%summarise(SSc=sum(Score))
State_Sum$Scale<- (State_Sum$SS-min(State_Sum$SS))*100/(max(State_Sum$SS)-min(State_Sum$SS))
State_Scr$Scale<- (State_Scr$SSc-min(State_Scr$SSc))*100/(max(State_Scr$SSc)-min(State_Scr$SSc))
State_Sum$Scale<- State_Sum$Scale*100/sum(State_Sum$Scale)
State_Scr$Scale<- State_Scr$Scale*100/sum(State_Scr$Scale)

#Grouping data based on Vendor Venue
Venue_Sum<- group_by(dataset, Vendor.Venue)%>%summarise(VS=sum(Order_count))
Venue_Scr<- group_by(dataset, Vendor.Venue)%>%summarise(VSc=sum(Score))
Venue_Sum$Scale<- (Venue_Sum$VS-min(Venue_Sum$VS))*100/(max(Venue_Sum$VS)-min(Venue_Sum$VS))
Venue_Scr$Scale<- (Venue_Scr$VSc-min(Venue_Scr$VSc))*100/(max(Venue_Scr$VSc)-min(Venue_Scr$VSc))
Venue_Sum$Scale<- Venue_Sum$Scale*100/sum(Venue_Sum$Scale)
Venue_Scr$Scale<- Venue_Scr$Scale*100/sum(Venue_Scr$Scale)

#Grouping data based on Vendor Name
Vendor_Sum<- group_by(dataset, Vendor.Name)%>%summarise(VdS=sum(Order_count))
Vendor_Scr<- group_by(dataset, Vendor.Name)%>%summarise(VdSc=sum(Score))
Vendor_Sum$Scale<- (Vendor_Sum$VdS-min(Vendor_Sum$VdS))*100/(max(Vendor_Sum$VdS)-min(Vendor_Sum$VdS))
Vendor_Scr$Scale<- (Vendor_Scr$VdSc-min(Vendor_Scr$VdSc))*100/(max(Vendor_Scr$VdSc)-min(Vendor_Scr$VdSc))
Vendor_Sum$Scale<- Vendor_Sum$Scale*100/sum(Vendor_Sum$Scale)
Vendor_Scr$Scale<- Vendor_Scr$Scale*100/sum(Vendor_Scr$Scale)

#Visualisation base on Order Source
library(ggplot2)
Orderb<- ggplot(data = Order_Sum, aes(x=Order.Source,y= Scale,fill=Order.Source))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))+xlab("")

Orderpie<- ggplot(data=Order_Sum, aes(x = "", y = Scale, fill = Order.Source))+geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0)+scale_colour_gradientn(colours=rainbow(2))

#Visualisation base on State
library(ggplot2)
Stateb<- ggplot(data = State_Sum, aes(x=State,y= Scale,fill=State))+
  geom_bar(stat="identity")+scale_colour_gradientn(colours=rainbow(10))

Statepie<- ggplot(data=State_Sum, aes(x = "", y = Scale, fill = State))+geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0)+scale_colour_gradientn(colours=rainbow(2))
