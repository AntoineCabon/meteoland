summarypoint<-function(x, var, fun="mean", freq=NULL, dates = NULL, months= NULL, ...) {
  if(!inherits(x,"data.frame")) stop("'x' has to be a data.frame.")
  VARS = c("MeanTemperature", "MinTemperature","MaxTemperature", "Precipitation",
           "MeanRelativeHumidity", "MinRelativeHumidity", "MaxRelativeHumidity",
           "Radiation", "WindSpeed", "WindDirection", "PET")
  var = match.arg(var, VARS)
  
  if(is.null(dates)) dates = as.Date(row.names(x))
  if(!is.null(months)) {
    m = as.numeric(format(dates,"%m"))
    dates = dates[m %in% months]
  }
  if(is.null(freq)) {
    df =  do.call(fun, args=list(x[as.character(dates),var],...))
  } else {
    date.factor = cut(dates, breaks=freq)
    df = tapply(x[as.character(dates),var],INDEX=date.factor, FUN=fun,...)
  }
  return(df)
}
summarypoints<-function(points, var, fun=mean, freq=NULL, dates = NULL, months = NULL, ...) {
  if(!inherits(points,"SpatialPointsMeteorology") && !inherits(points,"SpatialPointsDataFrame")) stop("'points' has to be of class 'SpatialPointsMeteorology' or 'SpatialPointsDataFrame'.")
  VARS = c("MeanTemperature", "MinTemperature","MaxTemperature", "Precipitation",
           "MeanRelativeHumidity", "MinRelativeHumidity", "MaxRelativeHumidity",
           "Radiation", "WindSpeed", "WindDirection", "PET")
  var = match.arg(var, VARS)
  
  npoints = length(points)
  
  cat(paste("  Summarizing ", var, " in ", npoints," points...\n", sep=""))
  
  dfvec = vector("list",npoints)
  if(inherits(points,"SpatialPointsMeteorology")) {
    if(!is.null(names(points@data))) ids = names(points@data)
    else ids = 1:npoints
  } else {
    if(!is.null(rownames(points@data))) ids = rownames(points@data)
    else ids = 1:npoints
  }
  
  pb = txtProgressBar(0, npoints, 0, style = 3)
  for(i in 1:npoints) {
    setTxtProgressBar(pb, i)
    if(inherits(points,"SpatialPointsMeteorology")) {
      obs = points@data[[i]]
    } else {
      f = paste(points@data$dir[i], points@data$filename[i],sep="/")
      if(!file.exists(f)) stop(paste("Observed file '", f,"' does not exist!", sep=""))
      if("format" %in% names(points@data)) { ##Format specified
        obs = readmeteorologypoint(f, format=points@data$format[i])
      } else {
        obs = readmeteorologypoint(f)
      }
    }
    dfvec[[i]] = summarypoint(obs,var,fun, freq, dates,months,...)
  }
  cat("\n")
  noutvars = length(dfvec[[1]])
  dfout = data.frame(matrix(NA,nrow=npoints, ncol=noutvars))
  rownames(dfout) = ids
  outvarnames = names(dfvec[[1]])
  if(!is.null(outvarnames)) names(dfout) = outvarnames
  cat(paste("  Arranging output...\n", sep=""))
  pb = txtProgressBar(0, npoints, 0, style = 3)
  for(i in 1:npoints) {
    setTxtProgressBar(pb, i)
    dfout[i,] = as.numeric(dfvec[[i]])
  }
  return(SpatialPointsDataFrame(as(points,"SpatialPoints"),dfout))
}