# Vendor-Scoring-

Introduction:
This repository contains project on Vendor scoring.
Vendor Scores: It is a score given to vendor based on his perfprmance in terms of on time delivery of products, Delivering maximum products and profit.

Data Source: The dataset that we had was not complete and it was halfway missing. For Completing the project it was required for us 
to have a complete dataset. 
We originally had this attributes 
1.X   2.Order.ID   3.SKU   4.Item.Price    5.Order.Date   6.Quantity    7.Order.Source    8.Customer.Name   9.State   10.Zip.code   11.Vendor.Venue     12.Vendor.Name
So we simulated some variables which were originally not present in the dataset they are 
13.Ratings   14.Returned    15.ReturnPercent    16.RetainedPercent   17.CostPrice  18.SellingPrice 19.Dispatches   20.Delivery  
21.Profit    22.ProfitPercent


Problem definition: To give Scores to the vendors based on the transaction details also provide a proper visualisation of the data based on it's various parameters in the dataset.


Solution: 
1. We implemented some mathematical formulation with Normalisation and found the scores of the vendors.
2. Scores were generated on a scale of 0-100. 100 being the best so far in the dataset.
3. This Solution is very helpful as every time we add new value in the dataset and run this program it will generate new scores based on new values inputted. All we have to do is import the dataset and run the codes.
4. We have created graphical visualisation which states the dependence of Scores on 
    a.order Source (order  source vs  Average rating and order  source vs  Average Score
    b.Vendor venue (vendor venue vs  Average rating and vendor venue vs  Average Score)
    c.vendor name  (vendor name vs  Average rating and vendor name vs  Average Score
    d.Customer name (vVisualisation not clear as we have too many distinct Customer names)
    e.State   (State vs  Average rating and State vs  Average Score)       
 


