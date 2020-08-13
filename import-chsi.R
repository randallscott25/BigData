#Randall Taylor
#7 Aug 2019
#IST687 group
#This script imports data from the chsi dataset and combines several sheets to
#make it easier to work with. You need to run it from within the folder that
#contains all the individual csv files
#install packages via console prompt 

# use sqldf for joins
library(sqldf)
library(readr)

#!!change to your own directory where the CSV files are located!!
setwd("C://Users//randa//Desktop//Applied Data Science//Final Project//chsi_dataset")

#this is the one that explains what columns mean
key = read_csv("DATAELEMENTDESCRIPTION.csv")

#Healthypeople is a reference sheet; we shouldn't join it. Instead, we'll use it
#later for comparison to standards
healthypeople = read_csv("HEALTHYPEOPLE2010.csv")

#These 5 will be combined
demographics = read_csv("DEMOGRAPHICS.csv")
vulnpopsandenvhealth = read_csv("VUNERABLEPOPSANDENVHEALTH.csv")
riskfactors = read_csv("RISKFACTORSANDACCESSTOCARE.csv")
leadingcausesofdeath = read_csv("LEADINGCAUSESOFDEATH.csv")
summarymeasures = read_csv("SUMMARYMEASURESOFHEALTH.csv")
  
combined <- sqldf('
select 
  d.county_fips_code
  ,d.state_fips_code
  ,d.chsi_county_name
  ,d.chsi_state_name
  ,d.chsi_state_abbr
  ,d.strata_id_number
  ,d.strata_determining_factors
  ,d.number_counties
  ,d.population_size
  ,d.population_density
  ,d.poverty
  ,d.Age_19_Under
  ,d.Age_19_64                 
  ,d.Age_65_84                 
  ,d.Age_85_and_Over
  ,d.White
  ,d.Black
  ,d.Native_American
  ,d.Asian
  ,d.Hispanic
  ,v.No_HS_Diploma
  ,v.Unemployed
  ,v.Sev_Work_Disabled
  ,v.Major_Depression
  ,v.Recent_Drug_Use
  ,v.Ecol_Rpt 
  ,v.Ecol_Rpt_Ind
  ,v.Ecol_Exp 
  ,v.Salm_Rpt 
  ,v.Salm_Rpt_Ind              
  ,v.Salm_Exp 
  ,v.Shig_Rpt 
  ,v.Shig_Rpt_Ind 
  ,v.Shig_Exp 
  ,v.Toxic_Chem 
  ,v.Carbon_Monoxide_Ind 
  ,v.Nitrogen_Dioxide_Ind 
  ,v.Sulfur_Dioxide_Ind 
  ,v.Ozone_Ind 
  ,v.Particulate_Matter_Ind 
  ,v.Lead_Ind 
  ,v.EH_Time_Span  
  ,r.No_Exercise
  ,r.Few_Fruit_Veg
  ,r.Obesity
  ,r.High_Blood_Pres
  ,r.Smoker
  ,r.Diabetes
  ,r.Uninsured
  ,r.Elderly_Medicare
  ,r.Disabled_Medicare
  ,r.Prim_Care_Phys_Rate
  ,r.Dentist_Rate
  ,r.Community_Health_Center_Ind
  ,r.HPSA_Ind
  ,l.A_Wh_Comp
  ,l.A_Bl_Comp
  ,l.A_Ot_Comp
  ,l.A_Hi_Comp
  ,l.A_Wh_BirthDef
  ,l.A_Bl_BirthDef
  ,l.A_Ot_BirthDef
  ,l.A_Hi_BirthDef
  ,l.B_Wh_Injury
  ,l.B_Bl_Injury
  ,l.B_Ot_Injury
  ,l.B_Hi_Injury
  ,l.B_Wh_Cancer
  ,l.B_Bl_Cancer
  ,l.B_Ot_Cancer
  ,l.B_Hi_Cancer
  ,l.B_Wh_Homicide
  ,l.B_Bl_Homicide
  ,l.B_Ot_Homicide
  ,l.B_Hi_Homicide
  ,l.C_Wh_Injury
  ,l.C_Bl_Injury
  ,l.C_Ot_Injury
  ,l.C_Hi_Injury
  ,l.C_Wh_Homicide
  ,l.C_Bl_Homicide
  ,l.C_Ot_homicide
  ,l.C_Hi_Homicide
  ,l.C_Wh_Suicide
  ,l.C_Bl_Suicide
  ,l.C_Ot_Suicide
  ,l.C_Hi_Suicide
  ,l.C_Wh_Cancer
  ,l.C_Bl_Cancer
  ,l.C_Ot_Cancer
  ,l.C_Hi_Cancer
  ,l.D_Wh_Injury
  ,l.D_Bl_Injury
  ,l.D_Ot_Injury
  ,l.D_Hi_Injury
  ,l.D_Wh_Cancer
  ,l.D_Bl_Cancer
  ,l.D_Ot_Cancer
  ,l.D_Hi_Cancer
  ,l.D_Wh_HeartDis
  ,l.D_Bl_HeartDis
  ,l.D_Ot_HeartDis
  ,l.D_Hi_HeartDis
  ,l.D_Wh_Suicide
  ,l.D_Bl_Suicide
  ,l.D_Ot_Suicide
  ,l.D_Hi_Suicide
  ,l.D_Wh_HIV
  ,l.D_Bl_HIV
  ,l.D_Ot_HIV
  ,l.D_Hi_HIV
  ,l.D_Wh_Homicide
  ,l.D_Bl_Homicide
  ,l.D_Ot_Homicide
  ,l.D_Hi_Homicide
  ,l.E_Wh_Cancer
  ,l.E_Bl_Cancer
  ,l.E_Ot_Cancer
  ,l.E_Hi_Cancer
  ,l.E_Wh_HeartDis
  ,l.E_Bl_HeartDis
  ,l.E_Ot_HeartDis
  ,l.E_Hi_HeartDis
  ,l.F_Wh_HeartDis
  ,l.F_Bl_HeartDis
  ,l.F_Ot_HeartDis
  ,l.F_Hi_HeartDis
  ,l.F_Wh_Cancer
  ,l.F_Bl_Cancer
  ,l.F_Ot_Cancer
  ,l.F_Hi_Cancer
  ,l.LCD_Time_Span
  ,s.ALE 
  ,s.US_ALE
  ,s.All_Death 
  ,s.US_All_Death 
  ,s.Health_Status 
  ,s.US_Health_Status 
  ,s.Unhealthy_Days 
  ,s.US_Unhealthy_Days 
from demographics d 
left join vulnpopsandenvhealth v on v.county_fips_code=d.county_fips_code and v.state_fips_code=d.state_fips_code
left join riskfactors r on r.county_fips_code=d.county_fips_code and r.state_fips_code=d.state_fips_code
left join leadingcausesofdeath l on l.county_fips_code=d.county_fips_code and l.state_fips_code=d.state_fips_code
left join summarymeasures s on s.county_fips_code=d.county_fips_code and s.state_fips_code=d.state_fips_code
' )

# We know that negative numbers are really NAs; let's replace them
combined[,-1:-7] <-  data.frame(lapply(combined[,-1:-7], function(x){
    as.numeric(gsub("-1*|-2*|-9*",NA,x))
}))

str(combined)
write_csv()

#replace NAs with mean of column auto
na_mean_swap <- function(x) {
  replace(x, is.na(x),mean(as.numeric(x),na.rm=TRUE))
}

mean_clean <- replace(combined,TRUE, lapply(combined[,-1,-7], na_mean_swap))
str(mean_clean)

#establishing the librarys that are required 
#for the visualizations via HTML 

#ONLY INSTALL VIA CONSOLE 
#install.packages("sf")
#install.packages("raster")
#install.packages(“dplyr”)
#install.packages(“stringr”)
#install.packages("spData")
#install.packages("leaflet")
#install.packages("sp")
#install.packages("tidyr")
#install.packages("tmap")
#install.packages("tmaptools")
#devtools::install_github("Nowosad/spDataLarge")
#devtools::install_github("geocompr/geocompkg")

#install_github("mtennekes/tmaptools")
#install_github("mtennekes/tmap")



library(sf)
library(raster)
library(dplyr)
library(stringr)
library(spData)
library(leaflet)
library(sp)
library(tidyr)
library(devtools)
library(ggplot2)
library(tmap)
library(tmaptools)
#data set = mean_clean
dim(mean_clean) #two dimmensional rows 3141 columns 140 
nrow(mean_clean)#how many rows 
ncol(mean_clean)#how many columns
class(mean_clean)#what is this objects classification 
#make Randall dataset based upon dplyr, tidyr

rstDataset = mean_clean %>% 
  select(State_FIPS_Code, CHSI_County_Name, Number_Counties, Population_Size, Poverty, Age_19_Under, Age_19_64, Age_65_84, Age_85_and_Over, No_HS_Diploma, Unemployed,Sev_Work_Disabled, Major_Depression, Recent_Drug_Use,No_Exercise, Few_Fruit_Veg, Obesity, Smoker, Diabetes, Uninsured, Elderly_Medicare, Disabled_Medicare)

#for that map and the data to match, there must be primary key matches 1st change CHSI_County_Name to "NAME"
rstDataSet = rstDataset %>%
  rename(NAME = CHSI_County_Name)
rstDataSet = rstDataSet %>%
  rename()
##for that map and the data to match, there must be primary key matches 1st change CHSI_County_Name to "NAME"

#let us find a county map within the spData 
spData::us_states
plot(us_states)
#beautiful
usMap = spData::us_states
View(usMap)
plot(usMap)


View(rstDataSet)

usDataMap = inner_join( usMap,rstDataSet, by = "NAME")
#We now have data
plot(usDataMap)
plot()
View(usDataMap)

# Randall 
#create more visualization based on single categories
#like "map" "poverty" / "map" "no hs diploma"

usdm.1 = usDataMap %>% 
  select(-starts_with("user."), -starts_with("Number_C"), 
         -starts_with("CHSI_"), -starts_with("Age")) %>% 
  rename(Population.Size = Population_Size ) %>%
  select(starts_with("Poverty"), starts_with("NAME"), starts_with("total_pop_15"))
usdm.1

View(usdm.1)
plot(usdm.1)

#ggplot(usdm.1) + geom_sf(aes(fill = Poverty / total_pop_15))

#ggplot(usdm.1) + geom_sf(aes(fill = Poverty / total_pop_15)) + scale_fill_gradient(low = "green", high = "red")

usdm.1 %>%
  mutate(poverty_to_population = Poverty / total_pop_15)

usdm.1v = tm_shape(usdm.1) + tm_polygons("Poverty", "Red", alpha = 1, palette = "Greens", style = "order") 
tmap_mode("view")
usdm.1v

#as.numeric(usDataMap)
usdm.2 = usDataMap %>% 
  select(-starts_with("user."), -starts_with("Number_C"), 
         -starts_with("CHSI_"), -starts_with("Age")) %>% 
  rename(Population.Size = Population_Size ) %>%
  select(starts_with("Major_Depression"), starts_with("NAME"), starts_with("GEOID"), starts_with("total_pop_15"))

usdm.2 = usdm.2 %>%
  mutate(Major_Depression_to_population_total = total_pop_15 /  Major_Depression )
View(usdm.2)

#ggplot(usdm.2) + geom_sf(aes(fill = Major_Depression ))

#ggplot(usdm.2) + geom_sf(aes(fill = Major_Depression)) + scale_fill_gradient(low = "green", high = "red") + geom_bar() 



usdm.2v = tm_shape(usdm.2) + tm_polygons("Major_Depression", palette = "white", style = "order",  n = 4, alpha = , stretch.palette = TRUE,  style = c("pretty", "fixed")) +  tm_shape(usdm.2)  + tm_polygons("Major_Depression_to_population_total", title = "United States Major Depression Totals compared to State Populations 2015", palette_explorer ="null", style = "order", n = 4, convert2density = TRUE ) + tm_facets( sync=TRUE, ncol = 2) + tmap_mode('view')

tm_f

usdm.2v

?tm_polygons

tmap_mode("view")

usdm.3 = usDataMap %>% 
  select(-starts_with("user."), -starts_with("Number_C"), 
         -starts_with("CHSI_"), -starts_with("Age")) %>% 
  select(starts_with("Uninsured"), starts_with("NAME"), starts_with("total_pop_15"))
usdm.3$Uninsured



usdm.3v = tm_shape(usdm.2) + 
  tm_fill("NAME", style="pretty", breaks=c(0,23000 ,27000,100000 ),
        labels=c("under 23,000", "23,000 to 27,000", "above 27,000"),
        palette="Greens") + tm_shape(usdm.2) + tm_polygons("Uninsured", title = "United States Uninsured Totals", palette_explorer = "null", style = "order", n = 4, convert2density = TRUE ) +   tm_borders("grey") + tm_legend(outside = TRUE, text.size = .8) + tm_layout(frame = FALSE)
usdm.3v









?tmaptools::palette_explorer()
