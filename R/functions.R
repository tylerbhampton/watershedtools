# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


#' @title HUC12 and NHDPlus Version 2 COMID Associations
#' @return The dataset HUC12_COMID_PU_CONUS.dbf contains HUC12 associations 
#' for every NHDPlus Version 2 reach except for Coastlines.
#' @docType data
#' @md

"HUC12_Outlet_COMIDs_CONUS"

#' @title getupstreamflowlines
#' @return Retrieves upstream NHDplus flowlines
#' @param lon start point longitude
#' @param lat start point longitude
#' @param distkm distance upstream to retrieve flowlines
#' @md
#' @export

getupstreamflowlines=function(lon,lat,distkm){
  start_point <- sf::st_sfc(sf::st_point(c(lon,lat)), crs = 4326)
  start_comid <- nhdplusTools::discover_nhdplus_id(start_point) 
  flowline <- nhdplusTools::navigate_nldi(list(featureSource = "comid", 
                                 featureID = start_comid), 
                            mode = "upstreamTributaries",
                            distance_km = distkm
                            )
  return(flowline)
}


#' @title NHDWBDws
#' @return Pairs NHD and the WBD to compile a watershed out of HUC12 units
#' @param method one of "flowline" or "point"
#' @param flowline output of (getupstreamflowlines)
#' @param point vector of length two, with lon and lat for start point
#' @param returnsingle Boolean, if no upstream NHD lines, return single shape?
#' @param WBDstagepath file path to staged WBD data
#' @md
#' @export
#' @importFrom magrittr "%>%"

NHDWBDws=function(method="flowline",flowline=NULL,point=NULL,returnsingle=TRUE,
                  distkm=2000,
                  WBDstagepath){
  if(method=="point"){
    flowline=getupstreamflowlines(lon=point[1],lat=point[2],distkm)
  }
  upstreamHUC12s=subset(HUC12_Outlet_COMIDs_CONUS,COMID%in%flowline$UT_flowlines$nhdplus_comid)
  
  
  if(nrow(upstreamHUC12s)==0 & returnsingle){
    print("Proceed: No Upstream Flowlines")
    subset_gpkg <- nhdplusTools::subset_nhdplus(comids = flowline$UT_flowlines$nhdplus_comid, 
                                  output_file = tempfile(fileext = ".gpkg"), 
                                  flowline_only = FALSE,
                                  return_data = TRUE,
                                  status=FALSE,
                                  nhdplus_data = "download") 
    catchment = subset_gpkg$CatchmentSP
    catchmentW = catchment %>% sf::st_buffer(.,0) %>% sf::st_union() %>% sf::st_as_sf() %>% st_transform(.,4326)
    return(catchmentW)
  }
  if(nrow(upstreamHUC12s)==0 & !returnsingle){print("Error - No Upstream Flowlines")}
  if(nrow(upstreamHUC12s)>0){
    
    HUC02reg = as.character(unique(upstreamHUC12s$NHDPLUSREG))
    HUC02reg = as.vector(sapply(HUC02reg,function(hx){
      if(nchar(hx)==1){return(paste0("0",hx))}
      if(nchar(hx)>2){return(substr(hx,1,2))}
      if(nchar(hx)==2){return(hx)}
    }))
    
    
    nhd12shps = do.call("rbind",lapply(HUC02reg,function(hx){
      sf::st_read(file.path(WBDstagepath,paste0("WBD_",hx,"_HU2_Shape"),"Shape","WBDHU12.shp"),quiet = TRUE)
    }))
    
    upstreamHUC12shapes=subset(nhd12shps,HUC12%in%upstreamHUC12s$HUC_12)
    
    catchmentW = upstreamHUC12shapes %>% 
      sf::st_union() %>% 
      sf::st_as_sf() %>% 
      st_transform(.,4326) %>%
      nngeo::st_remove_holes()
    return(catchmentW)
  }
}

