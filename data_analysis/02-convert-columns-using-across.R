
#' Ler e ajustar um DBF
#'
#' @param file_path Caminho do arquivo a ser importado
#'
#' @return Uma tibble
#' @export
#'
#' @examples
ler_e_ajustar_dbf <- function(file_path){
    
    # abrir arquivo
    dbf <- 
        foreign::read.dbf(file_path) |> 
        janitor::clean_names()
    
    # ajustar tipo das colunas
    dbf_ajust <- dbf |> 
        dplyr::mutate(
            dplyr::across(
                .cols = where(is.factor),
                ~as.character(.x)
            )
        ) |> 
        tibble::as_tibble()
    
    # saída
    return(dbf_ajust)
    
}
