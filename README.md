
![](swmpr_logo.png)

#### *Marcus W. Beck, beck.marcus@epa.gov*

Linux: [![Travis-CI Build Status](https://travis-ci.org/fawda123/SWMPr.png?branch=master)](https://travis-ci.org/fawda123/SWMPr)

Windows: [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/fawda123/SWMPr?branch=master)](https://ci.appveyor.com/project/fawda123/SWMPr)

[![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/grand-total/SWMPr)](http://cran.rstudio.com/package=SWMPr)

#Overview 

The System Wide Monitoring Program ([SWMP](http://nerrs.noaa.gov/RCDefault.aspx?ID=18)) was implemented by the National Estuarine Research Reserve System ([NERRS](http://nerrs.noaa.gov/)) in 1995 to provide continuous monitoring data at over 300 continuous monitoring stations in 28 estuaries across the United States.  SWMPr (pronounced "swamper") is an R package for retrieving, organizing, and analyzing estuary monitoring data from SWMP. Please cite the package as follows:

*Beck MW. 2015. SWMPr: An R package for the National Estuarine Research Reserve System.  Version 2.0.1. https://github.com/fawda123/SWMPr*

#Installing the package

Install the package from CRAN as follows:


```r
install.packages('SWMPr')
library(SWMPr)
```

The development (unstable) version of this package can be installed from Github:


```r
install.packages('devtools')
library(devtools)
install_github('fawda123/SWMPr')
library(SWMPr)
```

#Using the package

Please see the [sister repository](https://github.com/fawda123/swmpr_manu) for a [draft manuscript](https://github.com/fawda123/swmpr_manu/blob/master/swmpr_manu.pdf) that describes package use in detail.  A brief description of the available functions is provided below. See help documentation for more details on each function (e.g., `?all_params`).

<h3>Retrieve</h3>
<table>
<tr><td><code>all_params</code></td><td>Retrieve up to 100 records starting with the most recent at a given station, all parameters. Wrapper to <code>exportAllParamsXMLNew</code> function on web services.</td></tr>
<tr><td><code>all_params_dtrng</code></td><td> Retrieve records of all parameters within a given date range for a station. Optional argument for a single parameter. Maximum of 1000 records. Wrapper to <code>exportAllParamsDateRangeXMLNew</code>.</td></tr>
<tr><td><code>import_local</code></td><td> Import files from a local path. The files must be in a specific format, specifically those returned from the CDMO using the <a href="http://cdmo.baruch.sc.edu/aqs/zips.cfm">zip downloads</a> option for a reserve.</td></tr>
<tr><td><code>import_remote</code></td><td> Import SWMP site data from a remote independent server. These files have been downloaded from CDMO, processed using functions in this package, and uploaded to an Amazon server for quicker import into R.</td></tr>
<tr><td><code>single_param</code></td><td> Retrieve up to 100 records for a single parameter starting with the most recent at a given station. Wrapper to <code>exportSingleParamXMLNew</code> function on web services.</td></tr>
</table>
<h3>Organize</h3>
<table>
<tr><td><code>comb.swmpr</code></td><td> Combines swmpr objects to a common time series using setstep, such as combining the weather, nutrients, and water quality data for a single station. Only different data types can be combined.</td></tr>
<tr><td><code>qaqc.swmpr</code></td><td> Remove QAQC columns and remove data based on QAQC flag values for a swmpr object. Only applies if QAQC columns are present.</td></tr>
<tr><td><code>qaqcchk.swmpr</code></td><td> View a summary of the number of observations in a swmpr object that are assigned to different QAQC flags used by CDMO. The output is used to inform further processing but is not used explicitly.</td></tr>
<tr><td><code>rem_reps.swmpr</code></td><td> Remove replicate nutrient data that occur on the same day. The default is to average replicates.</td></tr>
<tr><td><code>setstep.swmpr</code></td><td> Format data from a swmpr object to a continuous time series at a given timestep. The function is used in <code>comb.swmpr</code> and can also be used with individual stations.</td></tr>
<tr><td><code>subset.swmpr</code></td><td> Subset by dates and/or columns for a swmpr object. This is a method passed to the generic `subset’ function provided in the base package.</td></tr>
</table>
<h3>Analyze</h3>
<table>
<tr><td><code>aggreswmp.swmpr</code></td><td> Aggregate swmpr objects for different time periods - years, quarters, months, weeks, days, or hours. Aggregation function is user-supplied but defaults to mean.</td></tr>
<tr><td><code>aggremetab.swmpr</code></td><td> Aggregate metabolism data from a swmpr object. This is primarily used within <code>plot_metab</code> but may be useful for simple summaries of raw daily data.</td></tr>
<tr><td><code>ecometab.swmpr</code></td><td> Estimate ecosystem metabolism for a combined water quality and weather dataset using the open-water method.</td></tr>
<tr><td><code>decomp.swmpr</code></td><td> Decompose a swmpr time series into trend, seasonal, and residual components. This is a simple wrapper to <code>decompose</code>. Decomposition of monthly or daily trends is possible.</td></tr>
<tr><td><code>decomp_cj.swmpr</code></td><td> Decompose a swmpr time series into grandmean, annual, seasonal, and events components. This is a simple wrapper to <code>decompTs</code> in the wq package. Only monthly decomposition is possible.</td></tr>
<tr><td><code>hist.swmpr</code></td><td> Plot a histogram for a swmpr object.</td></tr>
<tr><td><code>lines.swmpr</code></td><td> Add lines to an existing swmpr plot.</td></tr>
<tr><td><code>na.approx.swmpr</code></td><td> Linearly interpolate missing data (<code>NA</code> values) in a swmpr object. The maximum gap size that is interpolated is defined as a maximum number of records with missing data.</td></tr>
<tr><td><code>plot.swmpr</code></td><td> Plot a univariate time series for a swmpr object. The parameter name must be specified.</td></tr>
<tr><td><code>plot_metab</code></td><td> Plot ecosystem metabolism estimates after running <code>ecometab</code> on a swmpr object.</td></tr>
<tr><td><code>plot_summary</code></td><td> Create summary plots of seasonal/annual trends and anomalies for a water quality or weather parameter.</td></tr>
<tr><td><code>smoother.swmpr</code></td><td> Smooth swmpr objects with a moving window average. Window size and sides can be specified, passed to <code>filter</code>.</td></tr>
</table>
<h3>Miscellaneous</h3>
<table>
<tr><td><code>calcKL</code></td><td> Estimate the reaeration coefficient for air-sea gas exchange. This is only used within the <code>ecometab</code> function.</td></tr>
<tr><td><code>map_reserve</code></td><td> Create a map of all stations in a reserve using the ggmap package.</td></tr>
<tr><td><code>metab_day</code></td><td> Identify the metabolic day for each approximate 24 period in an hourly time series. This is only used within the <code>ecometab</code> function.</td></tr>
<tr><td><code>param_names</code></td><td> Returns column names as a list for the parameter type(s) (nutrients, weather, or water quality). Includes QAQC columns with ‘f_’ prefix. Used internally in other functions.</td></tr>
<tr><td><code>parser</code></td><td> Parses html returned from CDMO web services, used internally in retrieval functions.</td></tr>
<tr><td><code>site_codes</code></td><td> Metadata for all stations, wrapper to <code>exportStationCodesXMLNew</code> function on web services.</td></tr>
<tr><td><code>site_codes_ind</code></td><td> Metadata for all stations at a single site, wrapper to <code>NERRFilterStationCodesXMLNew</code> function on web services.</td></tr>
<tr><td><code>swmpr</code></td><td> Creates object of swmpr class, used internally in retrieval functions.</td></tr>
<tr><td><code>time_vec</code></td><td> Converts time vectors to POSIX objects with correct time zone for a site/station, used internally in retrieval functions.</td></tr>
</table>
