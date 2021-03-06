
## Install OSGeo4W

### Steps

*from
\<<https://github.com/APIS-Luftbildarchiv/APIS/wiki/How-To:-Installation-and-Setup-of-QGIS->*
*with-OSGeo4W-(to-use-the-APIS-QGIS-Plugin)\>*

1.  Download OSGeo4W from
    <https://www.qgis.org/en/site/forusers/download.html>

![Download QGIS](OSGEOinstall/Capture1.png)

2.  Choose OSGeo4W Network Installer (64 bit) (or 32 bit if you have a
    32 bit Windows)
3.  run/open osgeo4w-setup-x86\_64.exe
4.  Advanced Install \> Next
5.  Install from Internet \> Next
6.  Select Root Install Directory \> no changes \> Next
7.  Select Local Package Directory \> no changes \> Next
8.  Direct Connection \> Next
9.  Choose Download Site (select the only available one,
    <http://download.osgeo.org>) \> Next
10. From the **Select Packages** screen, select the following for
    installation: *To do so: use the Search Field (example for Desktop
    -\> qgis: QGIS Desktop):*

<!-- end list -->

  - Click on ‘Skip’ and use the newest available version of the package

  - Do the Same for Libs -\> qt4-devel, Libs -\> setuptools, Libs -\>
    gdal-mrsid, Libs-\> pyexiv2

  - Desktop -\> qgis-ltr: QGIS Desktop (long term release)

  - Desktop -\> grass: GRASS GIS

  - Desktop -\> grass6: GRASS GIS - old stable release

  - Desktop -\> saga-lty: SAGA (System for Automated Geographical
    Analyses; long-term release)

  - Commandline\_Utilities, Libs -\> gdal: The GDAL/ORG library

  - Commandline\_Utilities, Libs -\> shell: OSGeo4W Command Shell

  - Libs -\> geos: The GEOS geometry library

  - Libs -\> qgis-ltr-grass-plugin-common

  - Libs -\> qgis-ltr-grass-plugin7 \> Next

![Select Packages](OSGEOinstall/Capture8.png)

11. The installer suggests additional packages (dependencies). Accept
    them (CheckBox lower left) and continue the install with Next.
12. Accept Licence Agreements \> Next
13. Finish
