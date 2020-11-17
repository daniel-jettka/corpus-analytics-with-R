library(xml2)

############ Samples of Parameters ############
# metadata files (XML)
# metadata_files <- c("http://hdl.handle.net/11022/0000-0007-D821-0")
#
# XPath to find URLs of further linked metadata files
# m_xpath <- ".//*[local-name()='ResourceProxy' and *[local-name()='ResourceType']/@mimetype='application/xml+cmdi']/*[local-name()='ResourceRef']"
#
# XPath to find URLs of content files (XML)
# c_xpath <- ".//*[local-name()='ResourceProxy' and *[local-name()='ResourceType']/@mimetype='application/tei+xml;format-variant=tei-iso-spoken']/*[local-name()='ResourceRef']"
################################################


### Sample call of function (read into list) ###
#
# 1. read TEI from INEL Dolgan Corpus 1.0
# content <- parse(c("http://hdl.handle.net/11022/0000-0007-D821-0"), ".//*[local-name()='ResourceProxy' and *[local-name()='ResourceType']/@mimetype='application/xml+cmdi']/*[local-name()='ResourceRef']", ".//*[local-name()='ResourceProxy' and *[local-name()='ResourceType']/@mimetype='application/tei+xml;format-variant=tei-iso-spoken']/*[local-name()='ResourceRef']")
# 
# 2. read EXB from Selkup Language Corpus 1.0.0 
# content <- parse(c("http://hdl.handle.net/11022/0000-0007-D2C8-A"), ".//*[local-name()='ResourceProxy' and *[local-name()='ResourceType']/@mimetype='application/xml+cmdi']/*[local-name()='ResourceRef']", ".//*[local-name()='ResourceProxy' and *[local-name()='ResourceType']/@mimetype='application/xml;format-variant=exmaralda-exb']/*[local-name()='ResourceRef']")
#
################################################

parse <- function(metadata_files, m_xpath, c_xpath){
	if(length(metadata_files) == 0){
		return()
	}
	
	content <- list()
	metas <- list()
	
	# iterate over all metadata files
	for (file in metadata_files) {
	
	  xml <- read_xml(file)
	
	  # read content into list
	  content_files <- xml_text(xml_find_all(xml, c_xpath))
	  for (c in content_files) {
		content[[c]] <- read_xml(c)
	  }
	  
	  # read next level of metadata files into list
	  metas <- xml_text(xml_find_all(xml, m_xpath))
	  
	}
	
	return(c(content,parse(metas, m_xpath, c_xpath)))
	
}

