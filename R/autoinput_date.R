#' @title autoinput_date
#' @description Automatically genrates date inputs for all date variables in a dataframe.
#' @details Based on the date columns on a dataframe, this function generates all the date inputs. 
#'          The min/max value on the dataframe is the min/max value on the date input.  
#' @param .df Dataframe with N variables (one or more should be date)
#' @return dateInput() for all the date variables. 
#' @export autoinput_date
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shinymatic)
#' ui <- fluidPage(
#'   h3('UI (inputs)'),
#'   autoinput_date(.df = customers),
#'   h3('Server (output)'),
#'   verbatimTextOutput(outputId = 'values')
#' )
#' server <- function(input, output) {
#'   output$values <- reactive({
#'     vars_num <- names(customers)[sapply(customers, class) == "Date"]
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
autoinput_date <- function(.df) {
  vars_date <- names(.df)[sapply(.df, class) == "Date"]
  
  if (length(vars_date)==0){
    message('There are no date columns in the dataframe')
  }
  
  shiny::tagList(shiny::fluidRow(
    shiny::column(
      width = 12,
      lapply(
        X = 1:length(vars_date),
        FUN = function(var) {
          shiny::dateInput(
            inputId = vars_date[var],
            label = vars_date[var],
            min = min(.df[, vars_date[var]], na.rm=TRUE),
            max = max(.df[, vars_date[var]], na.rm=TRUE),
            value = min(.df[, vars_date[var]], na.rm=TRUE)
          )
        }
      )
    )))
}
