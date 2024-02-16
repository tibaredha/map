# set variable 
ir <- "Inspection Régionale"

# subtitle <-  paste("Wilaya de ")
caption  <-  paste("Source: Dr R.TIBA \n DSP Wilaya de Djelfa \n Tel : 0772718059")

# regions
region_16 <- c("Alger" , "Blida","Boumerdès","Tipaza")
region_25 <- c("Constantine","Annaba","Skikda","Jijel","Mila","Souk Ahras" ,"El Tarf","Guelma","Tébessa","Oum el Bouaghi")
region_31 <- c("Oran","Tlemcen","Mostaganem","Aïn Témouchent","Sidi Bel Abbès","Mascara")
region_26 <- c("Médéa","Chlef","Aïn Defla","Djelfa","M'Sila","Laghouat")
region_19 <- c("Sétif","Batna","Khenchela","Bordj Bou Arréridj","Béjaïa","Bouira","Tizi Ouzou" )
region_14 <- c("Tiaret","Saïda" ,"Tissemsilt","Naâma","El Bayadh","Relizane")
region_08 <- c("Béchar","Tindouf","Adrar","Bordj Bou Arréridj")# beni abass ,timimoune
region_30 <- c("Ouargla","Ghardaïa","Biskra","El Oued")#meniaa,ouleddjelal,elmaghair,toughort
region_11 <- c("Tamanghasset","Illizi")#ainsalah, ainghazam,djnet

# loading shape files

## algerie

dz <- read_sf("shp/gadm41_DZA_0.shp")
# st_crs(dz)
# glimpse(dz)
# str(dz)
# head(dz)
# tail(dz)
# class(dz)
# View(dz)

## wilayas algerie

dzw <- read_sf("shp/gadm41_DZA_1.shp") %>%
  dplyr::select(CC_1,NAME_1) %>% 
  dplyr::rename("CW"= CC_1,"WILAYA"= NAME_1) %>% 
  dplyr::mutate("CW"= as.numeric(CW)) %>% 
  dplyr::arrange(CW)
# st_crs(dzw)
# glimpse(dzw)
# str(dzw)
# head(dzw)
# tail(dzw)
# class(dzw)
# View(dzw)
wilayasf <- unique(dzw$WILAYA) 
## communes algerie

dzc <- read_sf("shp/gadm41_DZA_2.shp") %>%
  dplyr::select(CC_2,NAME_1,NAME_2) %>% 
  dplyr::rename("CC"= CC_2,"WILAYA"= NAME_1,"COMMUNE"= NAME_2) %>% 
  dplyr::mutate("CC"= as.numeric(CC)) %>% 
  dplyr::arrange(CC)
# st_crs(dzc)
# glimpse(dzc)
# str(dzc)
# head(dzc)
# tail(dzc)
# class(dzc)
# View(dzc)


#st_write(obj = djelfa, dsn = "gpkg/djelfa.gpkg", layer = "djelfa", delete_layer = TRUE)
#st_write(obj = djelfa, "shp/djelfa.shp", delete_layer = TRUE)

# loading data population
aindefla_c <- read.csv(file = "data/aindefla/aindefla_c.csv",encoding = "UTF-8")
aindefla_d <- read.csv(file = "data/aindefla/aindefla_d.csv",encoding = "UTF-8")
aindefla_m <- merge(x = aindefla_c , y = aindefla_d, by.x = "IDD", by.y = "ID")
chlef_c <- read.csv(file = "data/chlef/chlef_c.csv",encoding = "UTF-8")
chlef_d <- read.csv(file = "data/chlef/chlef_d.csv",encoding = "UTF-8")
chlef_m <- merge(x = chlef_c , y = chlef_d, by.x = "IDD", by.y = "ID")
djelfa_c <- read.csv(file = "data/djelfa/djelfa_c.csv",encoding = "UTF-8")
djelfa_d <- read.csv(file = "data/djelfa/djelfa_d.csv",encoding = "UTF-8")
djelfa_m <- merge(x = djelfa_c , y = djelfa_d, by.x = "IDD", by.y = "ID")
laghouat_c <- read.csv(file = "data/laghouat/laghouat_c.csv",encoding = "UTF-8")
laghouat_d <- read.csv(file = "data/laghouat/laghouat_d.csv",encoding = "UTF-8")
laghouat_m <- merge(x = laghouat_c , y = laghouat_d, by.x = "IDD", by.y = "ID")
medea_c <- read.csv(file = "data/medea/medea_c.csv",encoding = "UTF-8")
medea_d <- read.csv(file = "data/medea/medea_d.csv",encoding = "UTF-8")
medea_m <- merge(x = medea_c , y = medea_d, by.x = "IDD", by.y = "ID")
msila_c <- read.csv(file = "data/msila/msila_c.csv",encoding = "UTF-8")
msila_d <- read.csv(file = "data/msila/msila_d.csv",encoding = "UTF-8")
msila_m <- merge(x = msila_c , y = msila_d, by.x = "IDD", by.y = "ID")
region_c <- dplyr::bind_rows(aindefla_m,chlef_m,djelfa_m,laghouat_m,medea_m,msila_m)
# merging 
medea_r <- read.csv(file = "data/region/medea_r.csv",encoding = "UTF-8")
region <- merge(x =region_c , y = medea_r, by.x = "IDW", by.y = "IDW")
write.csv(region,"data/region/region.csv")
# region<- read.csv("data/region/region.csv")
# region$id <- NULL

# loading data ecole paramedicales
chlef_pm <- read.csv("data/chlef/chlef_pm.csv",encoding = "UTF-8")
aindefla_pm <- read.csv("data/aindefla/aindefla_pm.csv",encoding = "UTF-8")
medea_pm <- read.csv("data/medea/medea_pm.csv",encoding = "UTF-8")
djelfa_pm <- read.csv("data/djelfa/djelfa_pm.csv",encoding = "UTF-8")
laghouat_pm <- read.csv("data/laghouat/laghouat_pm.csv",encoding = "UTF-8")
msila_pm <- read.csv("data/msila/msila_pm.csv",encoding = "UTF-8")
region_pm <- dplyr::bind_rows(chlef_pm,aindefla_pm,medea_pm,djelfa_pm,laghouat_pm,msila_pm)
write.csv(region_pm,"data/region/region_pm.csv")
# region_pm <- read.csv("data/region/region_pm.csv")
# region_pm$id <- NULL

# loading data personnels
chlef_p <- read.csv("data/chlef/chlef_p.csv",encoding = "UTF-8")
aindefla_p <- read.csv("data/aindefla/aindefla_p.csv",encoding = "UTF-8")
medea_p <- read.csv("data/medea/medea_p.csv",encoding = "UTF-8")
djelfa_p <- read.csv("data/djelfa/djelfa_p.csv",encoding = "UTF-8")
laghouat_p <- read.csv("data/laghouat/laghouat_p.csv",encoding = "UTF-8")
msila_p <- read.csv("data/msila/msila_p.csv",encoding = "UTF-8")
region_p <- dplyr::bind_rows(chlef_p,aindefla_p,medea_p,djelfa_p,laghouat_p,msila_p)
write.csv(region_p,"data/region/region_p.csv")
# region_p <- read.csv("data/region/region_p.csv")
# region_p$id <- NULL

# loading data materiel lourd
chlef_ml <- read.csv("data/chlef/chlef_ml.csv",encoding = "UTF-8")
aindefla_ml <- read.csv("data/aindefla/aindefla_ml.csv",encoding = "UTF-8")
medea_ml <- read.csv("data/medea/medea_ml.csv",encoding = "UTF-8")
djelfa_ml <- read.csv("data/djelfa/djelfa_ml.csv",encoding = "UTF-8")
laghouat_ml <- read.csv("data/laghouat/laghouat_ml.csv",encoding = "UTF-8")
msila_ml <- read.csv("data/msila/msila_ml.csv",encoding = "UTF-8")
region_ml <- dplyr::bind_rows(chlef_ml,aindefla_ml,medea_ml,djelfa_ml,laghouat_ml,msila_ml)
write.csv(region_ml,"data/region/region_ml.csv")
# region_ml <- read.csv("data/region/region_ml.csv")
# region_ml$id <- NULL

# loading data etatblissements
chlef_e <- read.csv("data/chlef/chlef_e.csv",encoding = "UTF-8")
aindefla_e <- read.csv("data/aindefla/aindefla_e.csv",encoding = "UTF-8")
medea_e <- read.csv("data/medea/medea_e.csv",encoding = "UTF-8")
djelfa_e <- read.csv("data/djelfa/djelfa_e.csv",encoding = "UTF-8")
laghouat_e <- read.csv("data/laghouat/laghouat_e.csv",encoding = "UTF-8")
msila_e <- read.csv("data/msila/msila_e.csv",encoding = "UTF-8")
region_e <- dplyr::bind_rows(chlef_e,aindefla_e,medea_e,djelfa_e,laghouat_e,msila_e)
write.csv(region_e,"data/region/region_e.csv")
# region_e <- read.csv("data/region/region_e.csv")
# region_e$id <- NULL



