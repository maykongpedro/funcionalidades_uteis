

# Carregar e instalar pacotes ---------------------------------------------
if(!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, tabulizer, janitor)




# Visualizar código hex das cores em paletas ------------------------------

# usando o pacote scales e a função show_col
scales::show_col(viridis::viridis_pal(option = "viridis")(7)) 
scales::show_col(viridis::viridis_pal(option = "magma")(7))
scales::show_col(viridis::viridis_pal(option = "cividis")(7))

# pegar o número diretamente
viridis::viridis(6)