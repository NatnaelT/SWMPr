% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/swmpr_analyze.R
\name{decomp}
\alias{decomp}
\alias{decomp.swmpr}
\title{Simple trend decomposition of swmpr data}
\usage{
decomp(swmpr_in, ...)

\method{decomp}{swmpr}(swmpr_in, param, type = "additive",
  frequency = "daily", start = NULL, ...)
}
\arguments{
\item{swmpr_in}{input swmpr object}

\item{...}{arguments passed to \code{decompose}, \code{ts}, and other methods}

\item{param}{chr string of swmpr parameter to decompose}

\item{type}{chr string of \code{'additive'} or \code{'multiplicative'} indicating the type of decomposition, default \code{'additive'}.}

\item{frequency}{chr string or numeric vector indicating the periodic component of the input parameter.  Only \code{'daily'} or \code{'annual'} are accepted as chr strings.  Otherwise a numeric vector specifies the number of observations required for a full cycle of the input parameter.  Defaults to \code{'daily'} for a diurnal parameter.}

\item{start}{numeric vector indicating the starting value for the time series given the frequency.  Only required if \code{frequency} is numeric. See \code{\link[stats]{ts}}.}
}
\value{
Returns a decomposed.ts object
}
\description{
Decompose swmpr data into trend, cyclical (e.g., daily, annual), and random components using \code{\link[stats]{decompose}} and \code{\link[stats]{ts}}
}
\details{
This function is a simple wrapper to the \code{\link[stats]{decompose}} function.  The \code{decompose} function separates a time series into additive or multiplicative components describing a trend, cyclical variation (e.g., daily or annual), and the remainder.  The additive decomposition assumes that the cyclical component of the time series is stationary (i.e., the variance is constant), whereas a multiplicative decomposition accounts for non-stationarity.  By default, a moving average with a symmetric window is used to filter the cyclical component.  Alternatively, a vector of filter coefficients in reverse time order can be supplied (see \code{\link[stats]{decompose}}).

The \code{decompose} function requires a ts object with a specified frequency.  The \code{decomp} function converts the input swmpr vector to a ts object prior to \code{decompose}.  This requires an explicit input defining the frequency in the time series required to complete a full period of the parameter.  For example, the frequency of a parameter with diurnal periodicity would be 96 if the time step is 15 minutes (4 * 24).  The frequency of a parameter with annual periodicity would be 35040 (4 * 24 * 365).  For simplicity, chr strings of \code{'daily'} or \code{'annual'} can be supplied in place of numeric values.  A starting value of the time series must be supplied in the latter case.  Use of the \code{\link{setstep}} function is required to standardize the time step prior to decomposition.

Note that the \code{decompose} function is a relatively simple approach and alternative methods should be investigated if a more sophisticated decomposition is desired.
}
\examples{
## get data
data(apadbwq)
swmp1 <- apadbwq

## subset for daily decomposition
dat <- subset(swmp1, subset = c('2013-07-01 00:00', '2013-07-31 00:00'))

## decomposition and plot
test <- decomp(dat, param = 'do_mgl', frequency = 'daily')
plot(test)

## dealing with missing values
dat <- subset(swmp1, subset = c('2013-06-01 00:00', '2013-07-31 00:00'))

## this returns an error
\dontrun{
test <- decomp(dat, param = 'do_mgl', frequency = 'daily')
}

## how many missing values?
sum(is.na(dat$do_mgl))

## use na.approx to interpolate missing data
dat <- na.approx(dat, params = 'do_mgl', maxgap = 10)

## decomposition and plot
test <- decomp(dat, param = 'do_mgl', frequency = 'daily')
plot(test)
}
\references{
M. Kendall and A. Stuart (1983) The Advanced Theory of Statistics, Vol. 3, Griffin. pp. 410-414.
}
\seealso{
\code{\link[stats]{decompose}}, \code{\link[stats]{ts}}, \code{\link[stats]{stl}}
}

