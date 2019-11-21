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

## Let's see if we can look at magma sources using just basalt and major element data
basalt <- select(mydata, "SAMPLE.ID", "METHOD":"ZN") %>%
  filter(TIO2 != "NA")




         