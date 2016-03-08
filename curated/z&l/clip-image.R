library(adimpro)
setwd("C:/Users/Etienne/Google Drive/Curate Science/website/curated")
my.image <- read.image("forest_plot_Z&L.png")
clipped <- clip.image(my.image, xind = 335:632, yind = 15:680)  #fuck y-dimension doesn't line up !#@#@#
write.image (clipped, file = "forest_plot_Z&L_clipped.png")
