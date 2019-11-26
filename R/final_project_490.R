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
alk_thol <- select(mydata_2, "SAMPLE.ID", "METHOD":"ZR") %>%  ##whittle down the columns to just the one's needed
  filter(ROCK.NAME == "ALKALI BASALT" | ROCK.NAME == "THOLEIITE") ##choose the two rock names I want to analyze

## Look at table to see if improved results
cnt_rocks <- table(alk_thol$ROCK.NAME)

## first let's filter further to only look at samples that contain data for the elements we need
sio2_sort <- filter(alk_thol, alk_thol$SIO2 != "NA")

##before I continue I would like to double check I still have alk & thol avail
cnt_rocks <- table(sio2_sort$ROCK.NAME)
         