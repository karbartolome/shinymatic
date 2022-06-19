
# shinymatic <img src="man/figures/logo.png" width="175" height="200" align="right"/>

<!-- badges: start -->

![Progress](https://progress-bar.dev/30/)

<!-- badges: end -->

The goal of shinymatic is to automatically generate shiny inputs based
on a dataframe.

## Installation

You can install the development version of shinymatic from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("karbartolome/shinymatic")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(shiny)
library(shinymatic)
```

Data:

``` r
load('data/customers.rda')
```

Data structure:

    ## 'data.frame':    20 obs. of  7 variables:
    ##  $ birthdate : Date, format: "1999-07-28" "1976-06-26" ...
    ##  $ country   : Factor w/ 4 levels "Argentina","Brasil",..: 3 1 3 4 3 2 2 3 3 4 ...
    ##  $ category  : Factor w/ 3 levels "High","Low","Middle": 3 1 1 2 2 3 3 3 3 3 ...
    ##  $ amount_tot: num  7765 123 8766 2453 5450 ...
    ##  $ amount_avg: num  747 623 630 225 224 ...
    ##  $ first_date: Date, format: "2021-06-30" "2021-02-23" ...
    ##  $ last_date : Date, format: "2021-11-23" "2021-07-19" ...

User interface that includes

``` r
ui <- shiny::fluidPage(fluidRow(
  h1('   A shiny inputs example'),
  column(3,
    h3('Inputs based on df'),
    autoinput_numerical(.df = customers),
    autoinput_categorical(.df = customers),
    autoinput_date(.df = customers)
  ),
  column(3,
    h3('Outputs based on inputs'),
    verbatimTextOutput(outputId = 'values')
  )
))
```

Server that generates the reactive output based on each individual
input:

``` r
server <- function(input, output) {
  output$values <- reactive({
    paste0(sapply(
      names(customers),
      FUN = function(i)
        paste(i, "=", input[[i]])
    ),
    collapse = '\n')
  })
}
```

Shiny app is generated based on the ui and server:

``` r
shiny::shinyApp(ui = ui, server = server)
```

<img src="man/figures/shiny_example.png" width="70%" style="display: block; margin: auto;" />

# Autoinputs for multiple data types all at once

All the inputs can be generated with a single function:
shinymatic::autoinputs()

``` r
ui <- shiny::fluidPage(fluidRow(
 column(3,
        h3('Inputs based on df'),
        autoinputs(.df=customers)
 ),
 column(3,
        h3('Outputs based on inputs'),
        verbatimTextOutput(outputId = 'values')
 )
))

server <- function(input, output) {
 output$values <- reactive({
   paste0(sapply(
     names(customers),
     FUN = function(i) paste(i, "=", input[[i]])),
     collapse = '\n')
 })
}

shiny::shinyApp(ui = ui, server = server)
```
