
# Script 01 - Exportar dados em uma planilha excel customizada
# Fonte: https://twitter.com/neilgcurrie/status/1596186976717193216



# Get data ----------------------------------------------------------------

# criar dados de exemplo
diamond_xl <- ggplot2::diamonds |> 
    dplyr::group_by(cut) |> 
    dplyr::summarise(
        n = dplyr::n(),
        preco_medio = mean(price),
        preco_total = sum(price)
    )


# Create and save workbook ------------------------------------------------

# criar workbook
wb <- openxlsx::createWorkbook()

# criar planilhas
openxlsx::addWorksheet(wb, sheetName = "diamond_data")
openxlsx::addWorksheet(wb, sheetName = "starwars_data")

# caminho do arquivo
filename <- glue::glue("{here::here()}/others/openxlsx_workbook.xlsx")

# salvar workbook
openxlsx::saveWorkbook(wb, file = filename, overwrite = TRUE)



# Write data in the workbook ----------------------------------------------

# escrever dados na planilha - diamonds
openxlsx::writeData(
    wb = wb,
    sheet = "diamond_data",
    x = diamond_xl,
    startCol = 2,
    startRow = 1
)


# escrever dados na planilha - starwars
openxlsx::writeData(
    wb = wb,
    sheet = "starwars_data",
    x = dplyr::starwars,
    rowNames = TRUE
)

# adicionar cabeçalhos
openxlsx::writeData(
    wb = wb,
    sheet = "diamond_data",
    x = "Preço Alvo",
    startCol = 7
)

# adicionar cabeçalhos
openxlsx::writeData(
    wb = wb,
    sheet = "diamond_data",
    x = "Diferença de Preço",
    startCol = 8
)

# adicionar uma fórmula para calcular a diferença
dif_preco <- glue::glue("G{2:6}-E{2:6}")
dif_preco

openxlsx::writeFormula(
    wb = wb,
    sheet = "diamond_data",
    x = dif_preco,
    startCol = 8 ,
    startRow = 2
)

# salvar workbook
openxlsx::saveWorkbook(wb, file = filename, overwrite = TRUE)



# Formatting cells --------------------------------------------------------

# criar estilos
estilo_cabecalho <- openxlsx::createStyle(
    fontSize = 13,
    fontColour = "#2C0E72",
    border = "bottom",
    wrapText = FALSE # quebrar texto
)

estilo_currency <- openxlsx::createStyle(numFmt = "CURRENCY")
estilo_input_usuario <- openxlsx::createStyle(fgFill = "#FFF078")

# aplicar estilo ao cabeçalho
openxlsx::addStyle(
    wb = wb,
    sheet = "diamond_data",
    style = estilo_cabecalho,
    rows = 1,
    cols = 2:8,
    gridExpand = TRUE
)


# aplicar estilo aos números
openxlsx::addStyle(
    wb = wb,
    sheet = "diamond_data",
    style = estilo_currency,
    rows = 2:6,
    cols = 4:5,
    gridExpand = TRUE
)


# aplicar estilo à coluna de input do usuário
openxlsx::addStyle(
    wb = wb,
    sheet = "diamond_data",
    style = estilo_input_usuario,
    rows = 2:6,
    cols = 7,
    gridExpand = TRUE
)

# salvar workbook
openxlsx::saveWorkbook(wb, file = filename, overwrite = TRUE)


# Formatting the spreadsheet ----------------------------------------------

# formatar largura das colunas 1 e 6
openxlsx::setColWidths(
    wb = wb,
    sheet = "diamond_data",
    cols = c(1, 6),
    widths = 3
)

# formatar a largura das restantes
openxlsx::setColWidths(
    wb = wb,
    sheet = "diamond_data",
    cols = c(2:5, 7:8),
    widths = "auto"
)

# caso seja necessário formatar o tamanho da linha
# openxlsx::setRowHeights(wb = wb, sheet = "diamond_data", rows = 1, heights = 40)

# congelar painel superior e coluna inicial
openxlsx::freezePane(
    wb = wb,
    sheet = "diamond_data",
    firstActiveRow = 2,
    firstActiveCol = 3
)

# salvar workbook
openxlsx::saveWorkbook(wb, file = filename, overwrite = TRUE)
