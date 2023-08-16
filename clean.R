library(dplyr)

library(ggplot2)

df<-read.csv("crop_yields.csv",header=TRUE,sep=",")

df_nonempty <- df %>% 
  select_if(~any(!is.na(.)))

df_filtered <- df %>%
  filter(year >= 2010 & year <= 2021)

df_newc <- df_filtered %>% 
  filter(country %in% c("Australia", "Bangladesh", "Canada", "China", "Germany", "India", "Japan", "New Zealand", "Russia", "United Kingdom", "United States"))



df_data <- data.frame(
  Country = rep(countries, each = 11),
  rice_yield = rice_yield,
  year = filtered_rep
)

saveRDS(df_newc,"filcoun.rds")

ggplot(df_data, aes(x = rice_yield, y = year, color = countries, group = countries)) +
  geom_hex() +
  labs(title = "Rice Yield over Time", x = "Rice Yield", y = "Year") +
  theme_minimal()


ggplot(df_data, aes(x = rice_yield, y = year, color = Country, group = Country)) +
  geom_line() +
  labs(title = "Rice Yield over Time", x = "Rice Yield", y = "Year") +
  theme_minimal()
