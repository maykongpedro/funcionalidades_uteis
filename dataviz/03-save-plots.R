


# gráfico com tamanho diferente
ggplot2::ggsave(plot = plot_historico_percent_rating,
                path = "./outputs",
                filename = "historico_3.png",
                height = grid::unit(7, units = "cm"),
                width = grid::unit(11, units = "cm"))




# Salvar vários gráficos de uma vez ---------------------------------------

graficos_finais <- list(
    historico_1 = plot_historico_binary,
    historico_2 = plot_historico_rating,
    orcamento = plot_orcamento,
    notas = plot_notas
)

purrr::iwalk(graficos_finais, ~ggplot2::ggsave(paste0(.y, ".png"), .x, 
                                               path = "./outputs",
                                               height = grid::unit(5.5, units = "cm"),
                                               width = grid::unit(9.5, units = "cm")))








