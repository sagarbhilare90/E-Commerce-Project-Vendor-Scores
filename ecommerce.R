#Ecomm project
#data preprocessing
dataset<-read.csv("proj.csv")
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
