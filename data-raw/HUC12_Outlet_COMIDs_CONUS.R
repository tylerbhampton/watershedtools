
# Tested February 27, 2020
## code to prepare `HUC12_Outlet_COMIDs_CONUS` dataset goes here

# download dataset at https://www.sciencebase.gov/catalog/item/57eaa10fe4b09082500db04e
unzip("data-raw/HUC12_Outlet_COMIDs_CONUS.zip",exdir="data-raw/HUC12_Outlet_COMIDs_CONUS")

HUC12_Outlet_COMIDs_CONUS=sf::st_read("data-raw/HUC12_Outlet_COMIDs_CONUS/HUC12_Outlet_COMIDs_CONUS.shp")

HUC12_Outlet_COMIDs_CONUS=subset(as.data.frame(HUC12_Outlet_COMIDs_CONUS),select=-geometry)

usethis::use_data(HUC12_Outlet_COMIDs_CONUS,compress = "xz")
