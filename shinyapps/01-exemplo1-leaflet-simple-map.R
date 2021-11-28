
# Using Leaflet with Shiny
# Exemplo: https://rstudio.github.io/leaflet/shiny.html

# Carregar pacotes --------------------------------------------------------
library(shiny)
library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()


# Ui ----------------------------------------------------------------------
ui <- fluidPage(
    leafletOutput("mymap"),
    p(),
    actionButton("recalc", "New points")
)


# Server ------------------------------------------------------------------
server <- function(input, output, session) {
    
    points <- eventReactive(input$recalc, {
        
        cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
        
    }, 
    ignoreNULL = FALSE
    
    )
    
    output$mymap <- renderLeaflet({
        
        leaflet() %>%
            addProviderTiles(
                providers$Stamen.TonerLite,
                options = providerTileOptions(noWrap = TRUE)
            ) %>%
            addMarkers(data = points())
    })
}

shinyApp(ui, server)
