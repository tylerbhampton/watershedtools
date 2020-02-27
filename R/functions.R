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
#' @md
#' @export

getupstreamflowlines=function(lon,lat){
  start_point <- sf::st_sfc(sf::st_point(c(lon,lat)), crs = 4326)
  start_comid <- nhdplusTools::discover_nhdplus_id(start_point) 
  flowline <- nhdplusTools::navigate_nldi(list(featureSource = "comid", 
                                 featureID = start_comid), 
                            mode = "upstreamTributaries", 
                            data_source = "")
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
                  WBDstagepath){
  if(method=="point"){
    flowline=getupstreamflowlines(lon=p[1],lat=p[2])
  }
  upstreamHUC12s=subset(HUC12_Outlet_COMIDs_CONUS,COMID%in%flowline$nhdplus_comid)
  
  
  if(nrow(upstreamHUC12s)==0 & returnsingle){
    print("Proceed: No Upstream Flowlines")
    subset_gpkg <- nhdplusTools::subset_nhdplus(comids = flowline$nhdplus_comid, 
                                  output_file = tempfile(fileext = ".gpkg"), 
                                  nhdplus_data = "download") 
    flowline = sf::read_sf(subset_gpkg, "NHDFlowline_Network") 
    catchment = sf::read_sf(subset_gpkg, "CatchmentSP") 
    catchmentW = catchment %>% sf::st_buffer(.,0) %>% sf::st_union() %>% sf::st_as_sf() 
    #create a shape file from the plot in the specified location with the file name as the lake name
    return(catchmentW)
  }
  if(nrow(upstreamHUC12s)==0 & !returnsingle){print("Error - No Upstream Flowlines")}
  if(nrow(upstreamHUC12s)>0){
    
    HUC02reg=as.character(unique(upstreamHUC12s$NHDPLUSREG))
    if(nchar(HUC02reg)==1){HUC02reg=paste0("0",HUC02reg)}
    if(nchar(HUC02reg)>2){HUC02reg=substr(HUC02reg,1,2)}
    
    
    nhd12shps=sf::st_read(file.path(WBDstagepath,paste0("WBD_",HUC02reg,"_HU2_Shape"),"WBDHU12.shp"))
    
    upstreamHUC12shapes=subset(nhd12shps,HUC12%in%upstreamHUC12s$HUC_12)
    
    watershedW = upstreamHUC12shapes %>% sf::st_union() %>% sf::st_as_sf() 
    return(watershedW)
  }
}

