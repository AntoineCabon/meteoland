\encoding{UTF-8}
\name{extractpointdates}
\alias{extractpointdates}
\alias{extractgridpoints}
\title{
   Extracts meteorological data
}
\description{
Extracts meteorological data from an object.
}
\usage{
extractpointdates(points, dates = NULL, verbose=FALSE)
extractgridpoints(griddata, points)
}
\arguments{
  \item{points}{
For function \code{extractpointdates()}, an object of class \code{\link{SpatialPointsMeteorology}}. Alternatively, an object of class \code{\link{SpatialPointsDataFrame-class}} containing the meta data (columns \code{dir}, \code{filename} and possibly \code{format}) of meteorological files that will be sequentially read from the disk. For function \code{extractgridpoints()}, an object of class \code{\link{SpatialPoints}}.
}
  \item{dates}{A vector of \code{\link{Date}} with a (subset) of dates to be extracted. If \code{NULL} all dates will be returned. }
  \item{griddata}{An object of class \code{\link{SpatialGridMeteorology-class}} or \code{\link{SpatialPixelsMeteorology-class}} with the meteorological data for a full grid or a subset of grid cells, respectively. Alternatively, a \code{\link{data.frame}} containing the meta data (columns \code{dir} and \code{filename}) of grid/pixels meteorological files that will be sequentially read from the disk.}
  \item{verbose}{Boolean flag to print process information.}
}
\details{
Function \code{extractpoints} is deprecated, because its functionality can be achieved using subsetting of spatial classes \code{\link{SpatialGridMeteorology}} and \code{\link{SpatialPixelsMeteorology}}.
}
\value{
Function \code{extractpointdates()}, returns a \code{list} with the same length as \code{dates}. Each element of the list is an object of class \code{\link{SpatialPointsDataFrame}} with the meteorological data for all the points (in rows) and variables (in columns). Function \code{extractgridpoints()} returns an object of class \code{\link{SpatialPointsMeteorology}}.
}
\author{
Miquel De \enc{Cáceres}{Caceres} Ainsa, Centre Tecnologic Forestal de Catalunya
}

