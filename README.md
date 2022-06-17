
# shinymatic

<!-- badges: start -->
<!-- badges: end -->

The goal of shinydfinputs is to automatically generate shiny inputs based on a dataframe. 

## Installation

You can install the development version of shinydfinputs from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("karbartolome/shinymatic")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(shiny)
library(shinydfinputs)
df <- data.frame(
 var_num_1 = c(1,2,3),
 var_num_2 = c(6,5,4),
 var_cat_1 = c('a','b','c'))

ui <- shiny::fluidPage(
 shinydfinputs::slider_numeric(.df=df),
 shiny::textOutput(outputId = 'values')
)

server <- function(input, output) {
 output$values <- reactive({
   vars_num <- names(df[,unlist(lapply(df, is.numeric))])
   paste0(sapply(vars_num, 
                 FUN=function(i) paste(i,"=", input[[i]])), 
          collapse = ', ')
 })
}

shiny::shinyApp(ui = ui, server = server)
```
