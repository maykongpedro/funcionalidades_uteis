


# Obter mapas com Brazilmaps ----------------------------------------------
brazilmaps::get_brmap(geo = 'Region')



# Obter mapas com geobr ---------------------------------------------------
shp_brasil <- geobr::read_state() 



# Simplificar shapes para ficar mais leve ---------------------------------

shp <- geobr::read_state()

shp |> 
    # dtolerance em metros, quanto maior, mais simplificado
    # sf::st_simplify(dTolerance = 10000) |> 
    leaflet::leaflet() |> 
    leaflet::addTiles() |> 
    leaflet::addPolygons()


# Plotando mapas com highcharts -------------------------------------------


# mapa com dados
mapdata <-
    highcharter::download_map_data("countries/br/br-all") |> 
    highcharter::get_data_from_map()

dplyr::glimpse(mapdata)


# dados para fazer join
data_fake <- mapdata |> 
    dplyr::select(code = `hc-a2`) |> 
    dplyr::mutate(valor = sample(100:115,27,TRUE))#adiciona novas variáveis e preserva as existentes

dplyr::glimpse(data_fake)


# plotar mapa
url_mapa_base <- "countries/br/br-all"
highcharter::hcmap(
    map = "countries/br/br-all",
    data = data_fake,
    value = "valor",
    #joinBy = c("hc-a2", "code"),
    borderColor = "#FAFAFA",
    borderWidth = 0.1,
    name = "Estado",
    dataLabels = list(enabled = TRUE, format = "{point.code}"),
    tooltip = list(valueDecimals = 2, valuePrefix = "R$")
) |> 
    highcharter::hc_title(text = "Brasil") |> 
    highcharter::hc_subtitle(text = "You can use the same functions to modify your map!")
# highcharter::hc_colorAxis(
#     dataClasses = highcharter::color_classes(c(seq(100, 115, by = 5)))
#     ) |> 
# highcharter::hc_legend(layout = "vertical",
#                        align = "right",
#                        valueDecimals = 2)




