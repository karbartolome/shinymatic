# shinymatic <img src="man/figures/logo.png" width = "175" height = "200" align="right" />

![Progress](https://progress-bar.dev/25/)

<!-- badges: start -->

<!-- badges: end -->

The goal of shinymatic is to automatically generate shiny inputs based on a dataframe.

## Installation

You can install the development version of shinymatic from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("karbartolome/shinymatic")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(shiny)
library(shinymatic)
df <- data.frame(Titanic)
str(df)

ui <- shiny::fluidPage(
  autoinput_numerical(.df=df),
  textOutput(outputId = 'num_values'),
  br(),
  autoinput_categorical(.df=df),
  textOutput(outputId = 'cat_values'),
)

server <- function(input, output) {
  output$num_values <- reactive({
    vars_num <- names(df)[sapply(df, is.numeric)]
    paste0(sapply(vars_num, 
                  FUN=function(i) paste(i,"=", input[[i]])), 
           collapse = ', ')
  })
  
  output$cat_values <- reactive({
    vars_cat <- names(df)[sapply(df, is.factor)]
    paste0(sapply(vars_cat,
                  FUN=function(i) paste(i,"=", input[[i]])),
           collapse = ', ')
  })
}

shiny::shinyApp(ui = ui, server = server)
```

![shiny_output](images/paste-452F4688.png)
