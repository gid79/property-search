#!/bin/bash
#########################################################################
## Process tested in Windows, using Cygwin                             ##
## other than the default of the instalation you will need to install: ##
## -> wget                                                             ##
## -> unzip                                                            ##
## -> database client MySQL                                            ##
## you can select by searching for them in the Cygwin packages during  ##
## the install.                                                        ##
#########################################################################

### Environment ###
STARTTIME=$(date +%s)
## for Linux: CHKSUM_CMD=md5sum
## cksum should be available in all Unix versions
CHKSUM_CMD=md5sum
## directory under HOME_DIR
FILES_DIR=data
## Import files ###
#####################################
# the list should match the tables ##
# created by create_ean.sql script ##
#####################################
#LANG=ja_JP
FILES=(
ActivePropertyList
AirportCoordinatesList
AliasRegionList
AreaAttractionsList
AttributeList
ChainList
CityCoordinatesList
CountryList
DiningDescriptionList
GDSAttributeList
GDSPropertyAttributeLink
HotelImageList
NeighborhoodCoordinatesList
ParentRegionList
PointsOfInterestCoordinatesList
PolicyDescriptionList
PropertyAttributeLink
PropertyDescriptionList
PropertyTypeList
RecreationDescriptionList
RegionCenterCoordinatesList
RegionEANHotelIDMapping
RoomTypeList
SpaDescriptionList
WhatToExpectList
#
# minorRev=25 added files
#
PropertyLocationList
PropertyAmenitiesList
PropertyRoomsList
PropertyBusinessAmenitiesList
PropertyNationalRatingsList
PropertyFeesList
PropertyMandatoryFeesList
PropertyRenovationsList
#
# To Add a language set
#
#ActivePropertyList_es_ES
#AliasRegionList_es_ES
#AreaAttractionsList_es_ES
#AttributeList_es_ES
#CountryList_es_ES
#DiningDescriptionList_es_ES
#PolicyDescriptionList_es_ES
#PropertyAttributeLink_es_ES
#PropertyDescriptionList_es_ES
#PropertyTypeList_es_ES
#RecreationDescriptionList_es_ES
#RegionList_es_ES
#RoomTypeList_es_ES
#SpaDescriptionList_es_ES
#WhatToExpectList_es_ES
#PropertyLocationList_es_ES
#PropertyAmenitiesList_es_ES
#PropertyRoomsList_es_ES
#PropertyBusinessAmenitiesList_es_ES
#PropertyNationalRatingsList_es_ES
#PropertyFeesList_es_ES
#PropertyMandatoryFeesList_es_ES
#PropertyRenovationsList_es_ES
)


echo "Starting at working directory..."
pwd
## create subdirectory if required
if [ ! -d ${FILES_DIR} ]; then
   echo "creating download files directory..."
   mkdir ${FILES_DIR}
fi

## all clear, move into the working directory
cd ${FILES_DIR}

echo "Downloading files using wget..."
for FILE in ${FILES[@]}
do
	### Download Data ###
    ## capture the current file checksum
	if [ -e ${FILE}.zip ]; then
		echo "File exist $FILE.zip..."
    	CHKSUM_PREV=`$CHKSUM_CMD $FILE.zip | cut -f1 -d' '`
    else
    	CHKSUM_PREV=0
	fi
    ## download the files via HTTP (no need for https), using time-stamping, -nd no host directories
    wget  -t 30 --no-verbose -r -N -nd http://www.ian.com/affiliatecenter/include/V2/$FILE.zip
done

