

# Carregar e instalar pacotes com pacman ----------------------------------
if(!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, tabulizer, janitor)



# Carregar e instalar pacote caso não tenha o mesmo -----------------------

if (!require("googlesheets4")) install.packages("googlesheets4", 
                                                repos = "http://cran.us.r-project.org")
if (!require("brazilmaps")) install_github("rpradosiqueira/brazilmaps")


