#ESTE SCRIPT CALCULA EL dNBR PARA ESTIMAR LA SEVERIDAD DE LA QUEMA EN EL INCENDIO DE TORRES DEL ESPAÑOL
#OCURRIDO EN JUNIO DE 2019. PARA ELLOS SE UTILZAN DOS IMAGENES SENTINEL2 CON LAS SIGUIENTE INFORMACION:

#BANDA 1 - azul
#BANDA 2 - verde
#BANDA 3 - rojo
#BANDA 4 - NIR (banda 8A en la imagen original)
#BANDA 5 - SWIR (banda 11 en la imagen original)


rm(list = ls())

library(raster)
library(tidyverse)

#Leer imágenes pre y post incendio ()
prefuego <- raster::stack('./data/S2A_20190625.tif')
postfuego <- raster::stack('./data/S2A_20190705.tif')

ndvipre <- ndvi(prefuego$S2A_20190625.3,prefuego$S2A_20190625.4)
ndvipost <- ndvi(postfuego$S2A_20190705.3,postfuego$S2A_20190705.4)

nbrpre <- ndvi(prefuego$S2A_20190625.4,prefuego$S2A_20190625.5)
nbrpost <- ndvi(postfuego$S2A_20190705.4,postfuego$S2A_20190705.5)

dNBR <- (nbrpost-nbrpre)*1000

dNBR.df <- as.data.frame(dNBR, xy=T)

dNBR.df %>%
  rename(dNBR=layer) %>%
  ggplot() +
    geom_tile(aes(x,y,fill=dNBR)) +
    scale_fill_steps2(low='darkgreen',mid='Ivory',high = 'tomato4',
                      breaks = c(-Inf,-100,99,440,660,Inf)) +
    theme_minimal()
