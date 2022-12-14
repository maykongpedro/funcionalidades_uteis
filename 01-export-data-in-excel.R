
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








