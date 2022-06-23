#' @title autoinputs
#' @description Automatically genrates inputs for all variables in a dataframe.
#' @details Based on the columns on a dataframe, this function generates all the inputs. 
#' @param .df Dataframe with N variables (date, factor or numeric types are supported)
#' @param .dec_places Decimal places for the numerical sliders
#' @return Input buttons for all variables. 
#' @export autoinputs
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shinymatic)
#' load('data/customers.rda')
#' ui <- fluidPage(fluidRow(
#'   column(3,
#'          h3('Inputs based on df'),
#'          autoinputs(.df=customers)
#'   ),
#'   column(3,
#'          h3('Outputs based on inputs'),
#'          verbatimTextOutput(outputId = 'values')
#'   )
#' ))
#' server <- function(input, output) {
#'   output$values <- reactive({
#'     paste0(sapply(
#'       names(customers),
#'       FUN = function(i) paste(i, "=", input[[i]])),
#'       collapse = '\n')
#'   })
#' }
#' shinyApp(ui = ui, server = server)
#' }
autoinputs <- function(.df, .dec_places){
  vars_num <- names(.df)[sapply(.df, is.numeric)]
  vars_cat <- names(.df)[sapply(.df, is.factor)]
  vars_date <- names(.df)[sapply(.df, class) == "Date"]
  df_inputs <- c() 
  if (length(vars_num>0)){
    df_inputs = c(df_inputs, shinymatic::autoinput_numerical(
      .df=.df, .dec_places=.dec_places))
  }
  if (length(vars_cat>0)){
    df_inputs = c(df_inputs, shinymatic::autoinput_categorical(.df=.df))
  }
  if (length(vars_date>0)){
    df_inputs = c(df_inputs, shinymatic::autoinput_date(.df=.df))
  }
  return(df_inputs)
}
