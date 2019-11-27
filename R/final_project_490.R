#####
#Begin Project
#####
## Load data and packages into R
mydata<-read.csv("final_project_490/data/elmnts_data.csv", header = TRUE)
library(dplyr)
library(tidyverse)

#create data frame sorted by rock name to narrow to tholeiite or alkali
alkali_thol <- select(mydata, "SAMPLE.ID", "METHOD":"ZR") %>%
  filter(ROCK.NAME == "ALKALI BASALT" | ROCK.NAME == "THOLEIITE")

#count variables to be sure the dataset is large enough
cnt_alk <- table(alkali_thol$ROCK.NAME)
cnt_alk[names(cnt_alk) == "ALKALI BASALT"]  #I know this additional count was not needed since table was so small, but did it for practice anyway
cnt_alk[names(cnt_alk) == "THOLEIITE"]

## there does appear to be enough data to do a chemcial comparision between 
## tholeiitic basalt and alkali basalt

##Let's load a different data set and see if we can pull more information

## first upload new data set
mydata_2 <- read.csv("final_project_490/data/earthchem_dataset2.csv", header = TRUE)

## Let's see if there are more Alkali vs Tholeiite choices available
alk_thol <- select(mydata_2, "SAMPLE.ID":"TITLE", "METHOD":"ZR") %>%  ##whittle down the columns to just the one's needed
  filter(grepl("HAWAII", mydata_2$TITLE)) %>% ## sort for "hawaii" since I did not limit my orig data set to hawaii samples
           filter(ROCK.NAME == "ALKALI BASALT" | ROCK.NAME == "THOLEIITE") ##choose the two rock names I want to analyze

## Look at table to see if improved results
cnt_rocks <- table(alk_thol$ROCK.NAME)

##so after all that work, it turns out that when filtered to "hawaii", I am left
## with no alkali basalt samples to compare against

## sO...I am going to filter for hawaii and major element data
sio2_sort <- select(mydata_2, "SAMPLE.ID":"TITLE", "METHOD":"ZR") %>%  ##whittle down the columns to just the one's needed
  filter(mydata_2$SIO2 != "NA") %>%  ##filter for only those rows with data avail for sio2
  filter(grepl("HAWAII", TITLE)) ##filter for just samples from hawaii

    
 



