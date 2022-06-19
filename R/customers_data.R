#' @title customers_data
#' @description Generate N samples of random customer data
#' @param .N_customers Number of random observations to generate
#' @return A dataframe with .N_customers observations and 7 variables 
#' @export customers_data
#' @examples
#' customers_data(.N_customers=1000)
customers_data <- function(.N_customers) {
  base::set.seed(42)
  customers <- base::data.frame(
    birthdate = base::sample(base::seq(
      base::as.Date('1970-01-01'),
      base::as.Date('2001-01-01'), by = "day"
    ), .N_customers),
    country = base::factor(base::sample(
      c('Argentina', 'Chile', 'Brasil', 'Uruguay'),
      size = .N_customers,
      replace = TRUE
    )),
    category = base::factor(base::sample(
      c('Low', 'Middle', 'High'),
      size = .N_customers,
      replace = TRUE
    )),
    amount_tot = round(stats::runif(.N_customers, min = 100, max = 15000),2),
    amount_avg = round(stats::runif(.N_customers, min = 10, max = 1000),2),
    first_date = base::sample(base::seq(
      base::as.Date('2021-01-01'),
      base::as.Date('2022-02-01'), by = 'day'
    ), .N_customers, replace=TRUE)
  )
  customers$last_date = customers$first_date + stats::runif(1, 0, 200)
  return(customers)
}
