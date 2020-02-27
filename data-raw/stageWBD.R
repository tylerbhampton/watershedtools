# Stage USGS Watershed Boundary Dataset

# Tested February 27, 2020
# 
# path="C:/Users/Tyler/Downloads"
# 
# nums=as.character(1:18)
# nums[nchar(nums)==1]=paste0("0",nums[nchar(nums)==1])
# 
# 
# sapply(nums,function(H){
#   print(H)
#   file=paste0("WBD_",H,"_HU2_Shape")
#   download.file(url=paste0("https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/WBD/HU2/Shape/WBD_",H,"_HU2_Shape.zip"),
#                 destfile = file.path(path,paste0(file,".zip")))
#   unzip(file.path(path,paste0(file,".zip")),exdir=file.path(path,file))
#   
# })
