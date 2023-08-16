library(plumber)
library(tidyverse)
library(forcats)

theme_set(theme_bw()+
            theme(panel.grid= element_blank()))

get_plot <- function() {
  new_od <- readr::read_rds("new_od.rds")
  new_od %>%
    group_by(country...1) %>%
    summarise(mean_yield = mean(rice_yield.1, na.rm = TRUE)) %>%
    mutate(country...1 = fct_reorder(country...1, mean_yield)) %>%
    ggplot(aes(x = country...1, y = mean_yield)) +
    geom_point(size = 5, color = "blue") +
    geom_segment(aes(x = country...1, y = mean(new_od$rice_yield.1), xend = country...1, yend = mean_yield), color = "grey") +
    geom_hline(yintercept = mean(new_od$rice_yield.1, na.rm = TRUE), color = "grey") +
    theme(axis.text.x = element_text(angle = 90)) +
    labs(title = "Average Yield",
         x = "Countries",
         y = "Rice Yield")
}


#* @serializer png
#* @get /average_yield
function() {
  plot <- get_plot()
  print(plot)
}