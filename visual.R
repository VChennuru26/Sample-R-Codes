library(ggplot2)

setwd("Data")

data<-read.csv("cropyeild.csv",header=TRUE,sep=",")

ggplot(data, aes(x = crop_type, y = yield)) +
  geom_bar(stat = "identity") +
  labs(title = "Crop Yield by Crop Type", x = "Crop Type", y = "Yield")

ggplot(data, aes(x = harvest_date, y = yield)) +
  geom_line() +
  labs(title = "Crop Yield over Time", x = "Harvest Date", y = "Yield")

ggplot(data, aes(x = temperature, y = yield)) +
  geom_point() +
  labs(title = "Crop Yield vs. Temperature", x = "Temperature", y = "Yield")

ggplot(data, aes(x = precipitation, y = yield)) +
  geom_point() +
  labs(title = "Crop Yield vs. Precipitation", x = "Precipitation", y = "Yield")

ggplot(data, aes(x = soil_type, y = yield)) +
  geom_boxplot() +
  labs(title = "Crop Yield by Soil Type", x = "Soil Type", y = "Yield")

ggplot(data,aes(y=temperature, x=crop_condition))+
  geom_boxplot() +
  labs(title="Yeild depending on Temperature and Crop Condition",y="Temp",x="Crop Condition")

ggplot(data,aes(y=temperature,x=yield)) +
  geom_line()+
  labs(title="Crop Yeild based on Temperature", y="Temp", x="Yield")

ggplot(df, aes(x = crop_type, y = yield, color = area)) +
  geom_point(size = 4) +
  labs(title = "Crop Yield vs. Crop Type", x = "Crop Type", y = "Yield", color = "Area")
