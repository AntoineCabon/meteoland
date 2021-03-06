\encoding{UTF-8}
\name{interpolationpoints}
\alias{interpolationpoints}
\alias{interpolationpixels}
\alias{interpolationgrid}

\title{
Interpolates daily meteorology over a landscape
}
\description{
Interpolates meteorological data on spatial points/pixels/grid using an object of class \code{\link{MeteorologyInterpolationData-class}}.
}
\usage{
interpolationpoints(object, points, dates = NULL, export = FALSE,
                    exportDir = getwd(), exportFormat = "meteoland/txt",
                    metadatafile = "MP.txt", verbose=TRUE)
interpolationpixels(object, pixels, dates, export = FALSE,
                  exportDir=getwd(), exportFormat = "netCDF",
                  metadatafile = "MG.txt", verbose=TRUE)
interpolationgrid(object, grid, dates, export = FALSE,
                  exportDir=getwd(), exportFormat = "netCDF",
                  metadatafile = "MG.txt", verbose=TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{An object of class \code{\link{MeteorologyInterpolationData-class}}.}
  \item{points}{An object of class \code{\link{SpatialPointsTopography-class}}.}
  \item{pixels}{An object of class \code{\link{SpatialPixelsTopography-class}} representing the target landscape.}
  \item{grid}{An object of class \code{\link{SpatialGridTopography-class}} representing the target landscape.}
  \item{dates}{An object of class \code{\link{Date}}. If this is \code{NULL} then all dates in \code{object} are processed.}
  \item{export}{
    If \code{export = FALSE} the result of interpolation is stored in memory. Otherwise the result is written in the disk (using the format specified in \code{exportFormat}).
  }
  \item{exportDir}{Output directory for interpolated meteorology data.}
  \item{exportFormat}{Export format for meteorological data (see \code{\link{writemeteorologypoint}}).}
  \item{metadatafile}{The name of the ascii text file that will store the meta data describing all written files.}
  \item{verbose}{Boolean flag to print process information.}
}
\value{
If \code{export = FALSE}, function \code{interpolationpoints} returns an object of \code{\link{SpatialPointsMeteorology-class}}. If \code{export = TRUE}, the function returns an object of class \code{\link{SpatialPointsDataFrame-class}} containing the meta data of the files written in the disk.

If \code{export = FALSE}, function \code{interpolationpixels} returns an object of \code{\link{SpatialPixelsMeteorology-class}}. If \code{export = TRUE}, the function writes the results in files and a \code{data.frame} with columns 'dir' and 'filename' is returned.

If \code{export = FALSE}, function \code{interpolationgrid} returns an object of \code{\link{SpatialGridMeteorology-class}}. If \code{export = TRUE}, the function writes the results in files and a \code{data.frame} with columns 'dir' and 'filename' is returned.
}
\details{
If CRS projection is different between \code{object} and \code{points}/\code{pixels}/\code{grid}, the function transforms the coordinates of \code{points}/\code{pixels}/\code{grid} to adapt them to the CRS of \code{object}.
}
\references{
Thornton, P.E., Running, S.W., White, M. A., 1997. Generating surfaces of daily meteorological variables over large regions of complex terrain. J. Hydrol. 190, 214–251. doi:10.1016/S0022-1694(96)03128-9.

De Caceres M, Martin-StPaul N, Turco M, Cabon A, Granda V (2018) Estimating daily meteorological data and downscaling climate models over landscapes. Environmental Modelling and Software 108: 186-196.
}
\author{
Miquel De \enc{Cáceres}{Caceres} Ainsa,  CTFC
}
\seealso{\code{\link{penman}}, \code{\link{SpatialPointsTopography-class}}, \code{\link{SpatialGridTopography}}, \code{\link{SpatialPixelsTopography}}, \code{\link{MeteorologyInterpolationData}}}

\examples{
data(examplegridtopography)
data(exampleinterpolationdata)

####### INTERPOLATION on particular POINTS 

#Creates spatial topography points from the grid
p = 1:2
spt = as(examplegridtopography, "SpatialPointsTopography")[p]

#Interpolation of two points for the whole time period (2000-2003)
mp = interpolationpoints(exampleinterpolationdata, spt)

#Plot interpolated meteorological series
meteoplot(mp,1, ylab="Mean temperature")

####### INTERPOLATION on PIXELS 
# Creates spatial topography pixels as a subset of grid pixels
# and select pixels at maximum distance of 2km from center
spt = as(examplegridtopography,"SpatialPointsTopography")
cc = spt@coords
center = 5160
d = sqrt((cc[,1]-cc[center,1])^2+(cc[,2]-cc[center,2])^2)
spxt = as(spt[which(d<2000)], "SpatialPixelsTopography") 

# Interpolation of meteorology over pixels for two days
ml = interpolationpixels(exampleinterpolationdata, spxt,
                       as.Date(c("2001-02-03", "2001-06-03")))
                       
#Plot PET corresponding to 2001-06-03
spplot(ml,2,"PET")

####### INTERPOLATION over a complete GRID 
#Interpolation of meteorology over a grid for two days
ml = interpolationgrid(exampleinterpolationdata, examplegridtopography,
                       as.Date(c("2001-02-03", "2001-06-03")))
#Plot PET corresponding to 2001-06-03
spplot(ml,2,"PET")
}
