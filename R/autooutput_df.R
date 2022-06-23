#' Title autooutput_df
#' @description Based on the values of the inputs selected on the UI, 
#'              a reactive dataframe is generated
#' @details This df could be used as the input parameters for a machine learning
#'          model, where another output is the predicted value based on the 
#'          dataframe. 
#'          
#' @param .df The original dataframe
#' @param .inputs Input from the ui
#' @param .output_format 'df' or 'transposed_df'
#'
#' @return A dataframe based on the input values generated with 
#'         shinymatic::autoinputs()
#' @export autooutput_df
#'
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' library(shiny)
#' library(shinymatic)
#' ui <- fluidPage(
#'   column(3,  h3('Inputs based on df'),
#'          autoinputs(.df=customers)),
#'   column(6, h3('Outputs based on inputs'),
#'          tableOutput(outputId = 'data_test'))
#' )
#' server <- function(input, output) {
#'   data_preds <- reactive({
#'     autooutput_df(.df=customers, .inputs=input)
#'   })
#'   output$data_test <- renderTable ({
#'     data_preds()
#'   })
#' }
#' 
#' shinyApp(ui = ui, server = server)
#' }
autooutput_df <- function(.df, .inputs, 
                          .dates_as_str=FALSE) {
  vars_tot <- names(.df)
  
  
  data_output <- lapply(
    X = vars_tot,
    FUN = function(var) {
      .inputs[[var]]
    }
  )
  
  df = data.frame(data_output)
  names(df) = names(.df)
  
  if(.dates_as_str==TRUE){
     dates <- sapply(.df, FUN = function(x){class(x) == "Date"})
     df[,dates] <- lapply(df[,dates], function(x) as.character(x))
  }

  return(df)
}
