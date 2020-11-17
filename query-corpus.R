library(xml2)

### Samples of parameters ###
# 
# xmllist - list of XML documents
# xpath <- ".//*[local-name()='spanGrp' and @type='gg']/*[local-name()='span' and *[local-name()='span']='lachen']"
# 
#############################

### Sample function call ###
# 
# 1. find all instances of "lachen" in gg tier
# count_in_xml_list(xmllist, ".//*[local-name()='spanGrp' and @type='gg']/*[local-name()='span' and *[local-name()='span']='lachen']")
# 
#############################


count_in_xml_list <- function(xmllist, xpath) {
  temp_Count <- 0
  for(t in xmllist){
    matches <- xml_find_all(t, xpath)
    for (m in matches) {
      temp_Count <- temp_Count + 1
    }
  }
  return(temp_Count)
}

