#' @title autoinput_categorical
#' 
#' @description Automatically genrates select inputs for all factor columns in a dataframe.
#'
#' @details Based on the factor columns on a dataframe, this function generates all the select inputs. 
#'          The possible values correspond to the levels in each factor column. 
#'          
#' @param .df Dataframe with N variables (one or more should be factor)
#'
#' @return Select input for categorical variables 
#' 
#' @import shiny
#' @export autoinput_categorical
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shinymatic)
#' df <- data.frame(
#'   var_num_1 = c(1, 2, 3),
#'   var_num_2 = c(6, 5, 4),
#'   var_cat_1 = factor(c('a', 'b', 'c'))
#' )
#' ui <- shiny::fluidPage(
#'   h3('UI (inputs)'),
#'   autoinput_categorical(.df = df),
#'   h3('Server (output)'),
#'   verbatimTextOutput(outputId = 'values')
#' )
#' server <- function(input, output) {
#'   output$values <- reactive({
#'     vars_cat <- names(df)[sapply(df, is.factor)]
#'     paste0(sapply(
#'       vars_cat,
#'       FUN = function(i)
#'         paste(i, "=", input[[i]])
#'     ),
#'     collapse = '\n')
#'   })
#' }
#' shiny::shinyApp(ui = ui, server = server)
#' }
autoinput_categorical <- function(.df) {
  vars_cat <- names(.df)[sapply(.df, is.factor)]
  
  if (length(vars_cat)==0){
    message('There are no factor columns in the dataframe')
  }
  
  shiny::tagList(shiny::fluidRow(shiny::column(
    width = 12,
    lapply(
      X = 1:length(vars_cat),
      FUN = function(var) {
        shiny::selectInput(
          inputId = vars_cat[var],
          label = vars_cat[var],
          choices = levels(.df[, vars_cat[var]]),
          selected = .df[1, vars_cat[var]]
        )
      }
    )
  )))
}
