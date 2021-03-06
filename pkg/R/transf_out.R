#' Tranform the output of the fortran 3PG to the long format
#'
#' @param model a list as an output of `run_3PG`
#'
#' @details This is transforming the model output to long format
#'
#' @example inst/examples/run_3PGHelp.R
#' @export
#'
transf_out <- function( model ){

  # simulations
  out <- model[['sim']]
  site <- model[['site']]

  # internal variables
  n_ob = dim(out)[1]
  n_sp = dim(out)[2]

  out <- as.data.frame.table( out, stringsAsFactors = F, responseName = 'value')

  out$date <- seq( as.Date( paste(site$iYear, site$iMonth+1, 01, sep = '-') ), by = "month", length.out = n_ob) - 1
  out$species <- rep( paste0('sp_', 1:n_sp), each = n_ob)
  out$group <- rep( unique(r3pg_info$variable_group), each = n_ob * n_sp)
  out$variable <- rep( r3pg_info$variable_name[order(r3pg_info$variable_id)], each = n_ob * n_sp)

  out <- out[!out$value %in% -9999,]

  out <- out[,c('date', 'species', 'group', 'variable', 'value')]

  return(out)

}
