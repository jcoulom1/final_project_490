Hawaiian Basalts
================
Julie M. Coulombe
11/30/2019

## Alkali-Basalt vs Tholeiite

The dataset was pulled from <https://search.earthchem.org/> with Feature
Name = OceanIsland:Hawaii and Sample Types =
igenous:volcanicmafic:alkali.basalt, tholeiite, trachyte, trachytebasalt

``` r
alkali_thol <- select(mydata, "SAMPLE.ID", "METHOD":"ZR") %>%
  filter(ROCK.NAME == "ALKALI BASALT" | ROCK.NAME == "THOLEIITE")
cnt_alk <- table(alkali_thol$ROCK.NAME)
cnt_alk
```

    ## 
    ## ALKALI BASALT        BASALT HYALOCLASTITE     THOLEIITE 
    ##             1             0             0            70

This data set did not include enough information to analyze - due to
only having 1 alkali basalt. When trying to filter for only sio2, that
data was not available for any of the observations. At this point I went
back to the original database and pulled a new dataset.

``` r
alk_thol2 <- select(mydata_2, "SAMPLE.ID", "METHOD":"ZR") %>%  
  filter(ROCK.NAME == "ALKALI BASALT" | ROCK.NAME == "THOLEIITE")
cnt_rocks2 <- table(alk_thol2$ROCK.NAME)
cnt_rocks2
```

    ## 
    ## ALKALI BASALT     THOLEIITE  TRACHYBASALT      TRACHYTE 
    ##          1630          4577             0             0

This is great - lots of alkali and tholeiite to pull from \#\# Let’s see
if we can plot the elements for alkali and basalt

``` r
alk_thol_plot <- ggplot(alk_thol2, aes(x = SIO2, y = NA2O + K2O)) +
  geom_point()
alk_thol_plot
```

    ## Warning: Removed 4271 rows containing missing values (geom_point).

![](hawaiian_markdown_files/figure-gfm/Plot%20of%20SIO2%20vs%20Na2O%20&%20K2O-1.png)<!-- -->

This plot looks a little crazy - determined that data pull from database
did not filter for Hawaii samples only. Let’s try to do this in R

``` r
alk_thol3 <- select(mydata_2, "SAMPLE.ID":"TITLE", "METHOD":"ZR") %>% 
  filter(grepl("HAWAII", mydata_2$TITLE)) %>%
  filter(ROCK.NAME == "ALKALI BASALT" | ROCK.NAME == "THOLEIITE")
cnt_rocks3 <- table(alk_thol3$ROCK.NAME)
cnt_rocks3
```

    ## 
    ## ALKALI BASALT     THOLEIITE  TRACHYBASALT      TRACHYTE 
    ##             0          1313             0             0

so after all that work, it turns out that when filtered to “hawaii”, I
am left with no alkali basalt samples to compare against

So let’s look at Hawaii and some major element data, and compare Mg to
Si

``` r
sio2_sort <- select(mydata_2, "SAMPLE.ID":"TITLE", "METHOD":"ZR") %>% 
  filter(mydata_2$SIO2 != "NA") %>%  
  filter(grepl("HAWAII", TITLE))
```

and the plot for that filter selection

``` r
sio2_plot2 <- ggplot(sio2_sort, aes(x = SIO2, y = MGO)) + 
  geom_point() +   
  geom_smooth() +  
  ggtitle("SiO2 compared to MgO") +  
  xlab("SiO2") + 
  ylab("MgO")
sio2_plot2
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](hawaiian_markdown_files/figure-gfm/Plot%20SIO2%20vs%20MgO-1.png)<!-- -->
