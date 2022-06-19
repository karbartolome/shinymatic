#' @title autoinput_numerical
#' @description Automatically genrates slider inputs for all numeric variables in a dataframe.
#' @details Based on the numeric columns on a dataframe, this function generates all the slider inputs. 
#'          The min/max value on the dataframe is the min/max value on the slider. 
#' @param .df Dataframe with N variables (one or more should be numeric)
#' @return SliderInputs for all the numeric variables. 
#' @export autoinput_numerical
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shinymatic)
#' load('data/customers.rda')
#' ui <- fluidPage(
#'   h3('UI (inputs)'),
#'   autoinput_numerical(.df = customers),
#'   h3('Server (output)'),
#'   verbatimTextOutput(outputId = 'values')
#' )
#' server <- function(input, output) {
#'   output$values <- reactive({
#'     vars_num <- names(customers)[sapply(customers, is.numeric)]
#'     paste0(sapply(
#'       vars_num,
#'       FUN = function(i)
#'         paste(i, "=", input[[i]])
#'     ),
#'     collapse = '\n')
#'   })
#' }
#' shinyApp(ui = ui, server = server)
#' }
autoinput_numerical <- function(.df) {
  vars_num <- names(.df)[sapply(.df, is.numeric)]
  
  if (length(vars_num)==0){
    message('There are no numeric columns in the dataframe')
  }
  
  shiny::tagList(shiny::fluidRow(
    shiny::column(
      width = 12,
      lapply(
        X = 1:length(vars_num),
        FUN = function(var) {
          shiny::sliderInput(
            inputId = vars_num[var],
            label = vars_num[var],
            min = min(.df[, vars_num[var]], na.rm=TRUE),
            max = max(.df[, vars_num[var]], na.rm=TRUE),
            step = 1, round=TRUE,
            value = round(mean(.df[, vars_num[var]], na.rm=TRUE),2)
          )
        }
      )
    )))
}
