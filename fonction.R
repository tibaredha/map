
fct <- function(data,title,subtitle,caption) {
  # library(ggh4x)
  ggplot()+
    geom_sf(data = data,
            fill = "lightgreen",
            color = "black",
            size  = 0.25)+
    theme_void()+
    labs(
      x = "",
      y = "",
      title = title,
      subtitle = subtitle,
      caption = caption)+
    theme(panel.border = element_rect(colour = "black", fill=NA, size=0.25),
          plot.background = element_rect(fill = "lightgreen"), 
          panel.background = element_rect(fill = "bisque", colour="blue"))
}


fct1 <- function(variables) {
  
  nom_wilaya <- paste("Wilaya :",variables) 
  nom_commune <- paste("Commune wilaya :",variables)
  dzc %>%
    dplyr::filter(WILAYA == variables) %>% 
    fct(ir,subtitle=nom_commune,caption)
  
}

## carte 1,2 mapsf
carte <- function(variables) {
  wilayashp <- variables
  mf_theme("candy")                                                                   
  mf_shadow(wilayashp)                                    
  mf_map(wilayashp,
         type="choro",
         var="POP",
         add = TRUE,#pal = "Blues 3",
         leg_pos = "bottomleft2",
         leg_title = "Pop")                          
  mf_arrow()                                               
  mf_scale(size = 5)                                      
  mf_credits(txt = paste0("Sources: R.TIBA,DSP Djelfa,","mapsf ", packageVersion("mapsf"),"\n"))     
  mf_title(paste("Wilaya de ",wilayasf[nbr]))                             
  #mf_annotation(wilayashp[1, ],txt = wilaya[nbr])
  mf_label(x = wilayashp,var = "COMMUNE.x",cex = 0.5,col= "black",halo = TRUE,overlap = FALSE, lines = FALSE) 
}

carte2 <- function(variables) {
  wilayashp <- variables
  mf_init(x = wilayashp, theme = "green")    # Initiate a base map
  mf_shadow(wilayashp, add = TRUE)           # Plot a shadow
  mf_map(wilayashp, add = TRUE)              # plot municipalities
  # plot population
  mf_map(
    x = wilayashp,
    var = "POP",
    type = "prop",
    inches = 0.25,
    col = "brown4",
    leg_pos = "bottomleft2",
    leg_title = "Pop"
  )
  
  # layout
  mf_layout(title = paste("Wilaya de ",wilayasf[nbr]) ,
            credits = paste0("Sources: R. TIBA,DSP Djelfa, 2022\n","mapsf ", packageVersion("mapsf")))
}