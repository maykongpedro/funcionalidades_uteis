

# Gerar um vetor com as configurações gerais do plot ----------------------
# Como: cores, background, família textutal, títulos e outros

# definindo itens
config_plot <-
    c(
        "eucalipto" = "#35B779",
        "pinus" = "#ED7953",
        "outros" = "#31688E",
        "background" = "#F5F5F2",
        "text" = "#22211D",
        "text_fam" = "Crimson",
        "eixo_x_title" = "Ano-base",
        "eixo_y_title" = "\u00C1rea (Milh\u00F5es de hectares)",
        "title" = " - Hist\u00F3rico de \u00C1rea plantada por g\u00EAnero, considerando informa\u00E7\u00F5es do IB\u00C1",
        "caption" = "**@Dataviz:** *Pacote R - maykongpedro/plantiosflorestais*"
    )

# chamando no plot

ggplot2::scale_fill_manual(
    breaks = c("Outros",
               "Pinus",
               "Eucalyptus"),
    
    values = c(config_plot[["outros"]],
               config_plot[["pinus"]],
               config_plot[["eucalipto"]]),
    guide = ggplot2::guide_legend(reverse = TRUE)
)