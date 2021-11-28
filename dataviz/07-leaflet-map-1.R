
# Interactive Maps
# Example leaflet: https://slcladal.github.io/maps.html


# Load packages -----------------------------------------------------------
library(leaflet)
library(maptools) # data come from here

# Load data ---------------------------------------------------------------
data(wrld_simpl)

# calculate population density and add it to the data
wrld_simpl@data$PopulationDensity <-
    round(wrld_simpl@data$POP2005 / wrld_simpl@data$AREA, 2)

wrld_simpl@data$PopulationDensity <-
    ifelse(wrld_simpl@data$PopulationDensity == "Inf",
           NA,
           wrld_simpl@data$PopulationDensity)


# Plot map ----------------------------------------------------------------

# define colors
qpal <- colorQuantile(rev(viridis::viridis(10)),
                      wrld_simpl$PopulationDensity, n = 10)

# generate visualization
map <- 
    # base map
    leaflet(
    wrld_simpl, 
    options = leafletOptions(
        attributionControl = FALSE,
        minzoom = 1.5)
    ) |> 
    
    # add shapes
    addPolygons(
        label = ~ stringr::str_c(
            NAME, 
            ' ',
            formatC(
                PopulationDensity,
                big.mark = ',',
                format = 'd'
                )
            ),
        labelOptions = labelOptions(direction = 'auto'),
        weight = 1,
        color = '#333333',
        opacity = 1,
        fillColor = ~ qpal(PopulationDensity),
        fillOpacity = 1,
        highlightOptions = highlightOptions(
            color = '#000000',
            weight = 2,
            bringToFront = TRUE,
            sendToBack = TRUE
        )
    ) |> 
    
    # add legend
    addLegend(
        "topright",
        pal = qpal,
        values = ~ PopulationDensity,
        title = htmltools::HTML("Population density <br> (2005)"),
        opacity = 1
    )

# display visualization
map
