#' @title autoinput_numerical
#' 
#' @description Automatically genrates slider inputs for all numeric variables in a dataframe.
#'
#' @details Based on the numeric columns on a dataframe, this function generates all the slider inputs. 
#'          The min/max value on the dataframe is the min/max value on the slider. 
#'          
#' @param .df Dataframe with N variables (one or more should be numeric)
#'
#' @return SliderInputs for all the numeric variables. 
#' 
#' @import shiny
#' @export autoinput_numerical
#'
#' @examples
#' library(shiny)
#' library(shinydfinputs)
#' df <- data.frame(
#'   var_num_1 = c(1,2,3),
#'   var_num_2 = c(6,5,4),
#'   var_cat_1 = c('a','b','c'))
#' 
#' ui <- shiny::fluidPage(
#'   autoinput_numerical(.df=df),
#'   textOutput(outputId = 'values')
#' )
#' 
#' server <- function(input, output) {
#'   output$values <- reactive({
#'     vars_num <- names(df[,unlist(lapply(df, is.numeric))])
#'     paste0(sapply(vars_num, 
#'                   FUN=function(i) paste(i,"=", input[[i]])), 
#'            collapse = ', ')
#'   })
#' }
#' 
#' shiny::shinyApp(ui = ui, server = server)
autoinput_numerical <- function(.df) {
  vars_num <- names(.df[,unlist(lapply(.df, is.numeric))])
  
  shiny::tagList(shiny::fluidRow(
    shiny::column(
      width = 12,
      lapply(
        X = 1:length(vars_num),
        FUN = function(var) {
          shiny::sliderInput(
            inputId = vars_num[var],
            label = vars_num[var],
            min = min(.df[, var]),
            max = max(.df[, var]),
            step = 1,
            value = .df[1, var]
          )
        }
      )
    )))
}