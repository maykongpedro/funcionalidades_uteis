#' Author: Maykon Gabriel
#' Subject: 

# Fonte: https://github.com/adamribaudo/storytelling-with-data-ggplot/tree/master/data


# Import -----------------------------------------------------------------------

url_dados <- "https://raw.githubusercontent.com/adamribaudo/storytelling-with-data-ggplot/master/data/FIG0206-7.csv"
dados <- readr::read_csv(url_dados)


# Tidy -------------------------------------------------------------------------


# adjust data
dados_tidy <- dados |> 
    janitor::clean_names() |> 
    dplyr::mutate(
        cost_per_mile_num = readr::parse_number(cost_per_mile)
    )

# calculate median
media_y <- mean(dados_tidy$cost_per_mile_num)
media_x <- mean(dados_tidy$miles_driven)


# create auxiliary column to plot data
dados_tidy <- dados_tidy |> 
    dplyr::mutate(
        acima_abaixo = cost_per_mile_num > media_y
    )

# Visualize --------------------------------------------------------------------

dados_tidy |>
    ggplot2::ggplot() +
    ggplot2::aes(
        x = miles_driven,
        y = cost_per_mile_num
    ) +
    ggplot2::geom_point(
        ggplot2::aes(color = acima_abaixo),
        show.legend = FALSE,
        size = 3
    ) +
    ggplot2::geom_hline(
        yintercept = media_y,
        linetype = "longdash"
    ) +
    ggplot2::annotate(
        geom = "point",
        x = media_x,
        y = media_y,
        size = 4
    ) +
    ggplot2::annotate(
        geom = "label",
        x = media_x,
        y = media_y,
        label = "AVG",
        label.size = 0,
        size = 4,
        hjust = 1.5
    ) +
    ggplot2::scale_x_continuous(
        limits = c(0, 4000),
        labels = scales::comma
    ) +
    ggplot2::scale_y_continuous(
        limits = c(0, 3),
        breaks = seq(0, 3, .5),
        labels = scales::dollar
    ) +
    ggplot2::scale_colour_manual(
        values = c("lightgray", "orange")
    ) +
    ggplot2::labs(
        title = "Cost per mile by miles driven",
        x = "Miles driven per month",
        y = "Cost per mile"
    ) +
    ggplot2::theme_classic() +
    ggplot2::theme(
        
        title = ggplot2::element_text(
            color = "gray60"
        ),
        
        axis.title.x = ggplot2::element_text(
            hjust = 0,
            color = "gray60"
        ),
        
        axis.title.y = ggplot2::element_text(
            hjust = 1,
            color = "gray60"
        ),
        
        axis.line = ggplot2::element_line(color = "gray60"),
        
        axis.ticks = ggplot2::element_line(color = "gray60")
    )


# Model ------------------------------------------------------------------------


# Export -----------------------------------------------------------------------
ggplot2::ggsave(
    filename = "plot1.png",
    width = 5, 
    height = 4,
    dpi = 300
)

# readr::write_rds(d, "")
