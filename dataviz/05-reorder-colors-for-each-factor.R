


# Transformar em fator ordenado -------------------------------------------
    

# com factor base
dplyr::mutate(
        genero = factor(
            genero,
            levels = c("Outros",
                       "Pinus",
                       "Eucalyptus"),
            ordered = TRUE
            
        )
    )

# com forcats
# https://livro.curso-r.com/7-6-forcats.html#forcats
dplyr::mutate(
    flag = forcats::lvls_revalue(
        flag,
        new_levels = c(input$pokemon, "Média da geração")
    )
) 

# organizando nome de mês na ordem correta
dplyr::mutate(mes_name = month.abb[mes],
                  mes_name = forcats::fct_relevel(mes_name, month.abb)) %>% 

# Usar scale manual pra definir a ordem -----------------------------------

ggplot2::scale_fill_manual(
    
    # quebras
    breaks = c("Outros",
               "Pinus",
               "Eucalyptus"),
    # cores
    values = c(config_plot[["outros"]],
               config_plot[["pinus"]],
               config_plot[["eucalipto"]]),
    guide = ggplot2::guide_legend(reverse = TRUE)
) +
    