

  DataFile <- read.csv("SalesData.csv")
  
  
  require(dplyr)
  require(ggplot2)
  
  
  # 1. Compare Sales by region for 2016 with 2015 using bar chart 
  
  A <- DataFile %>% dplyr::group_by(Region) %>% dplyr::summarise(SUM=sum(Sales2015))
  A$YEAR <- "YEAR15"
  
  
  B <- DataFile %>% dplyr::group_by(Region) %>% dplyr::summarise(SUM=sum(Sales2016))
  B$YEAR <- "YEAR16"
  AB <- rbind(A,B)
  
  ggplot2::ggplot(data=AB) + aes(x=Region, y= SUM, fill=YEAR, main = "Sales by Region and Year") + 
    geom_bar(stat="identity", position = "dodge")+ theme(legend.title = 
                                                           element_blank())+ labs(title = "Sales by region and Year")
  
  

  
# 2. Pie charts for sales for each region in 2016 
  
  
  PIE <- DataFile %>% dplyr::group_by(Region) %>% dplyr::summarise(Total_Sale =round(sum(Sales2016)*100/sum(DataFile$Sales2016),2))
  
  
  pie(PIE$Total_Sale, labels =paste0(PIE$Region,PIE$Total_Sale ), main ="SALE of each Region2016")



# 3. Compare sales of 2015 and 2016 with Region and Tiers

  QUE3_1 <-   DataFile %>% dplyr::group_by(Region,Tier) %>% dplyr::summarise(SALE = sum(Sales2015))
  QUE3_1$YEAR<- "YEAR15"
  
  QUE3_2 <-   DataFile %>% dplyr::group_by(Region,Tier) %>% dplyr::summarise(SALE = sum(Sales2016))
  QUE3_2$YEAR<- "YEAR16"
  
  QUE3 <-rbind(QUE3_1,QUE3_2)
  
  
  ggplot2::ggplot(data =QUE3 ) + aes(x =Tier, y =SALE, fill =YEAR ) + geom_bar(stat = "identity", position = "dodge") + 
    facet_grid(.~Region)+ theme(legend.title = element_blank())+labs(title = "Sales of 2015 & 2016 Region & Tiers")







# 4. In East region, which state registered a decline in 2016 as compared to 2015? 

  QUE4 <- DataFile[DataFile$Region =="East",]
  QUE4_1 <- QUE4 %>% dplyr::group_by(State) %>% dplyr::summarise(SALE = sum(Sales2016))
  QUE4_1$YEAR<- "YEAR16"
  
  QUE4_2 <- QUE4 %>% dplyr::group_by(State) %>% dplyr::summarise(SALE = sum(Sales2015))
  QUE4_2$YEAR<- "YEAR15"
  
  QUE412 <- rbind(QUE4_1, QUE4_2)
  
  
  ggplot2::ggplot(data =QUE412 ) + aes(x =State, y =SALE, fill =YEAR ) + geom_bar(stat = "identity", position = "dodge") + 
    theme(legend.title = element_blank())+labs(title = "sales of 2015 and 2016" )



# 5. In all the High tier, which Division saw a decline in number of units sold in 2016 compared to 2015? 

  QUE5<- DataFile[DataFile$Tier=="High",]
  
  QUE5_1 <- QUE5 %>% dplyr::group_by(Division) %>% dplyr::summarise(UNITSOLD = sum(Units2015))
  QUE5_1$YEARLY<- "YEAR15"
  
  QUE5_2 <- QUE5 %>% dplyr::group_by(Division) %>% dplyr::summarise(UNITSOLD = sum(Units2016))
  QUE5_2$YEARLY<- "YEAR16"
  
  QUE512 <-rbind(QUE5_1,QUE5_2)
  
  ggplot2::ggplot(data =QUE512) + aes(x=Division, y =UNITSOLD, fill = YEARLY ) +  geom_bar(stat = "identity", position = "dodge") +
    theme(legend.title = element_blank())+labs(title = "Number of units sold in 2016 & 2015" )






# 6. Create a new column Qtr - 
# Jan - Mar : Q1 
# Apr - Jun : Q2 
# Jul - Sep : Q3 
# Oct - Dec : Q4 


  QUE6Q1 <- DataFile[(DataFile$Month == "Jan") | (DataFile$Month == "Feb") | (DataFile$Month =="Mar"),]
  QUE6Q1$QUARTER <- "Q1"
  
  QUE6Q2 <- DataFile[(DataFile$Month == "Apr") | (DataFile$Month == "May") | (DataFile$Month =="Jun"),]
  QUE6Q2$QUARTER <- "Q2"
  
  QUE6Q3 <- DataFile[(DataFile$Month == "Jul") | (DataFile$Month == "Aug") | (DataFile$Month =="Sep"),]
  QUE6Q3$QUARTER <- "Q3"
  
  QUE6Q4 <- DataFile[(DataFile$Month == "Oct") | (DataFile$Month == "Nov") | (DataFile$Month =="Dec"),]
  QUE6Q4$QUARTER <- "Q4"
  
  QUE6_Qtr <- rbind(QUE6Q1,QUE6Q2,QUE6Q3,QUE6Q4)
  
  head(QUE6_Qtr,10)


# 7. Compare Qtr wise sales in 2015 and 2016 in a bar plot 
  


  QUE7 <-QUE6_Qtr
  QUE7_1 <- QUE7 %>% dplyr::group_by(QUARTER) %>% dplyr::summarise(SALE = sum(Sales2015))
  QUE7_1$YEAR <- "YEAR2015"
  
  QUE7_2 <- QUE7 %>% dplyr::group_by(QUARTER) %>% dplyr::summarise(SALE = sum(Sales2016))
  QUE7_2$YEAR <- "YEAR2016"
  
  
  QUE7A <- rbind(QUE7_1,QUE7_2)
  
  ggplot2::ggplot(data =QUE7A ) + aes(x =QUARTER, y =SALE, fill =YEAR) +geom_bar(stat = "identity", position = "dodge") + 
    theme(legend.title = element_blank())+labs(title = "Qtr sales in 2015 & 2016" )





# 8. Determine the composition of Qtr wise sales in and 2015 with regards to all the Tiers in a pie chart. 
# (Draw 4 pie charts representing a Quarter for each Tier)

### Group the data by Tier and Quarter 

  QUE8_1 <- QUE7 %>% dplyr::group_by(Tier, QUARTER) %>% dplyr::summarise(Sale =round(sum(Sales2015)*100/sum(DataFile$Sales2015),2))
  
  
  QUE8A <- QUE8_1[QUE8_1$Tier =="High", ]
  pie(QUE8A$Sale,labels =paste0(QUE8A$QUARTER,QUE8A$Sale), main ="PIECHARTOFSALE2015 TierHigh")
  
  QUE8B <- QUE8_1[QUE8_1$Tier =="Low", ]
  pie(QUE8B$Sale,labels =paste0(QUE8B$QUARTER,QUE8B$Sale), main ="PIECHARTOFSALE2015 TierLow")
  
  
  QUE8C <- QUE8_1[QUE8_1$Tier =="Med", ]
  pie(QUE8C$Sale,labels =paste0(QUE8C$QUARTER,QUE8C$Sale), main ="PIECHARTOFSALE2015 TierMed")
  
  
  
  QUE8D <- QUE8_1[QUE8_1$Tier =="Out", ]
  pie(QUE8D$Sale,labels =paste0(QUE8D$QUARTER,QUE8D$Sale), main ="PIECHARTOFSALE2015 TierOut")












