
library(highcharter)
library(dplyr)
# Fonte: https://www.datacamp.com/community/tutorials/data-visualization-highcharter-r

# Base de dados -----------------------------------------------------------
pokemon <- highcharter::pokemon


# Gráfico de barras -------------------------------------------------------
pokemon |> 
    dplyr::count(type_1) |> 
    dplyr::arrange(n) |> 
    highcharter::hchart(
        type = "bar", 
        highcharter::hcaes(
            x = type_1, 
            y = n
            )
        )


# Gráfico de colunas ------------------------------------------------------
pokemon%>%
    count(type_1)%>%
    arrange(n)%>%
    hchart(type = "column", hcaes(x = type_1, y = n))



# Treemap -----------------------------------------------------------------
pokemon%>%
    count(type_1)%>%
    arrange(n)%>%
    hchart(type = "treemap", hcaes(x = type_1, value = n, color = n))


# Gráfico de dispersão ----------------------------------------------------
highchart()%>%
    hc_add_series(pokemon, "scatter", hcaes(x = height, y = weight))


# Gráfico de dispersão + smooth -------------------------------------------


set.seed(123)
data <- sample_n(diamonds, 300)

modlss <- loess(price ~ carat, data = data)
fit <- arrange(broom::augment(modlss), carat)

highchart() %>%
    hc_add_series(data, type = "scatter",
                  hcaes(x = carat, y = price, size = depth, group = cut)) %>%
    hc_add_series(fit, type = "line", hcaes(x = carat, y = .fitted),
                  name = "Fit", id = "fit") 
    # essa parte nao quis funcionar
    # hc_add_series(fit, type = "arearange",
    #               hcaes(x = carat, low = .fitted - 2*.se.fit,
    #                     high = .fitted + 2*.se.fit),
    #               linkedTo = "fit")


# Gráfico de área acumulada -----------------------------------------------
highchart() %>%
    hc_chart(type = "area") %>%
    hc_title(text = "Historic and Estimated Worldwide Population Distribution by Region") %>%
    hc_subtitle(text = "Source: Wikipedia.org") %>%
    hc_xAxis(categories = c("1750", "1800", "1850", "1900", "1950", "1999", "2050"),
             tickmarkPlacement = "on",
             title = list(enabled = FALSE)) %>%
    hc_yAxis(title = list(text = "Percent")) %>%
    hc_tooltip(pointFormat = "<span style=\"color:{series.color}\">{series.name}</span>:
             <b>{point.percentage:.1f}%</b> ({point.y:,.0f} millions)<br/>",
             shared = TRUE) %>%
    hc_plotOptions(area = list(
        stacking = "percent",
        lineColor = "#ffffff",
        lineWidth = 1,
        marker = list(
            lineWidth = 1,
            lineColor = "#ffffff"
        ))
    ) %>%
    hc_add_series(name = "Asia", data = c(502, 635, 809, 947, 1402, 3634, 5268)) %>%
    hc_add_series(name = "Africa", data = c(106, 107, 111, 133, 221, 767, 1766)) %>%
    hc_add_series(name = "Europe", data = c(163, 203, 276, 408, 547, 729, 628)) %>%
    hc_add_series(name = "America", data = c(18, 31, 54, 156, 339, 818, 1201)) %>%
    hc_add_series(name = "Oceania", data = c(2, 2, 2, 6, 13, 30, 46))


# Testando um tema --------------------------------------------------------
pokemon%>%
    count(type_1)%>%
    arrange(n)%>%
    hchart(type = "bar", hcaes(x = type_1, y = n, color = type_1))%>%
    hc_exporting(enabled = TRUE)%>%
    hc_add_theme(hc_theme_chalk())

# fonte para mais temas: https://jkunst.com/highcharter/articles/themes.html
