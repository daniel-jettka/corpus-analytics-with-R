library(xml2)

############ Samples of Parameters ############
# Base directory of EXMARaLDA corpus (local)
# base_directory <- c("C:/Users/Daniel/Desktop/demo-corpus/")
#
# Name of coma file (path from base directory)
# coma_file <- "EXMARaLDA_DemoKorpus.coma"
#
# XPath to find paths to content files (here: EXS files)
# c_xpath <- ".//*[local-name()='Transcription' and *[local-name()='Description']/*[local-name()='Key' and @Name='segmented']='true']/*[local-name()='NSLink']"
################################################


### Sample call of function (read into list) ###
#
# 1. read EXS from Coma file (for EXMARaLDA corpus downloaded to local directory)
# content <- parse_coma("C:/Users/Daniel/Desktop/demo-corpus/", "EXMARaLDA_DemoKorpus.coma", ".//*[local-name()='Transcription' and *[local-name()='Description']/*[local-name()='Key' and @Name='segmented']='true']/*[local-name()='NSLink']")
# 
# 2. read EXB from Coma file (for EXMARaLDA corpus downloaded to local directory)
# content <- parse_coma("C:/Users/Daniel/Desktop/demo-corpus/", "EXMARaLDA_DemoKorpus.coma", ".//*[local-name()='Transcription' and *[local-name()='Description']/*[local-name()='Key' and @Name='segmented']='false']/*[local-name()='NSLink']")
#
################################################

parse_coma <- function(base_directory, coma_file, c_xpath){
      
	xml <- read_xml(paste(base_directory, coma_file, sep=""))

	# read content into list
	content <- list()
	content_files <- xml_text(xml_find_all(xml, c_xpath))
	for (c in content_files) {
		content[[c]] <- read_xml(paste(base_directory, c, sep=""))
	}

	return(content)
}
