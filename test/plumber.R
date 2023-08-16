#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)
library(dplyr)


#* @apiTitle Plumber Example API
#* @apiDescription Plumber example description


#* @param selected_country The selected country from the dropdown menu.
#* @get /dropdown_from_data
#* 
function(selected_country = c(unique_countries)) {
  dropdown_options <- paste(
    lapply(unique_countries, function(country) {
      if (country == selected_country) {
        return(paste("<option value=\"", country, "\" selected>", country, "</option>", sep = ""))
      } else {
        return(paste("<option value=\"", country, "\">", country, "</option>", sep = ""))
      }
    }),
    collapse = ""
  )
  
  response <- sprintf(
    '<html><body><form><select name="selected_country">%s</select><input type="submit"></form></body></html>',
    dropdown_options
  )
  
  return(response)
}
