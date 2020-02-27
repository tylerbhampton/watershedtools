
<!-- README.md is generated from README.Rmd. Please edit that file -->

# watershedtools

The goal of `watershedtools` is to delineate watersheds using packages
like nhdplusTools and others. Most methods will work best for the
continental U.S.

## Installation

You can install watershedtools from github using devtools:

``` r
devtools::install_github("tylerbhampton/watershedtools")
```

## Test Watershed Delineation

``` r
library(watershedtools)
library(ggplot2)
library(leaflet)
library(sf)

# Point for Harlan County Lake on the Republican River, Nebraska USA
p=c(-99.189990,40.071521)

wsshape=NHDWBDws(method = "point",point = p,
         WBDstagepath = "B:/MASTERDATA/data_Hydrology/hydrology_shapefiles/USA_WBD_WatershedBoundaryDataset")
#> Reading layer `WBDHU12' from data source `B:\MASTERDATA\data_Hydrology\hydrology_shapefiles\USA_WBD_WatershedBoundaryDataset\WBD_10_HU2_Shape\WBDHU12.shp' using driver `ESRI Shapefile'
#> Simple feature collection with 13725 features and 20 fields
#> geometry type:  POLYGON
#> dimension:      XY
#> bbox:           xmin: -113.9381 ymin: 37.0246 xmax: -90.11422 ymax: 49.73909
#> epsg (SRID):    4269
#> proj4string:    +proj=longlat +datum=NAD83 +no_defs


leaflet(data = wsshape) %>% leaflet::addPolygons() %>% leaflet::addProviderTiles("Esri.WorldImagery")
```

![](man/figures/README-unnamed-chunk-2-1.png)<!-- -->
