
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
