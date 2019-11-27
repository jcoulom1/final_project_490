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

## so alkaline rocks should have higher NaO2 and K2O content than the tholeiites
sio2_plot <- ggplot(alk_thol, aes(x = alk_thol$SIO2, y = alk_thol$NA2O + alk_thol$K2O)) + ##plot created with x & y values
  geom_line() +  ## line plot chosen
  labs(title = "SIO2 compared to NA2O & K2O") +  ## gave plot a title and axis labels
  labs(x = "SIO2", y = "NA2O + K2O")
sio2_plot ##print the plot

##this plot looks crazy, not at all what I expected!  Looking at table, I see this new data
## did not include a filter for hawaii.  I do not see a way to do this with current table but 
## maybe I can find a way...

## can I search for hawaii as a keyword in the title column (which seems to indicate what study data was drawn from)
mydata_2$TITLE <- as.character(mydata_2$TITLE)




