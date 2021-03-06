% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{NHDWBDws}
\alias{NHDWBDws}
\title{NHDWBDws}
\usage{
NHDWBDws(
  method = "flowline",
  flowline = NULL,
  point = NULL,
  returnsingle = TRUE,
  WBDstagepath
)
}
\arguments{
\item{method}{one of "flowline" or "point"}

\item{flowline}{output of (getupstreamflowlines)}

\item{point}{vector of length two, with lon and lat for start point}

\item{returnsingle}{Boolean, if no upstream NHD lines, return single shape?}

\item{WBDstagepath}{file path to staged WBD data}
}
\value{
Pairs NHD and the WBD to compile a watershed out of HUC12 units
}
\description{
NHDWBDws
}
