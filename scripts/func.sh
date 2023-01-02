#!/bin/sh
# file: func.sh
#

#
# create_directory if not existing
#
create_directory()
{
    Ldir=$1
    if [ ! -d ${Ldir} ]; then
        mkdir -p ${Ldir}
    fi
}

#
# set permissions on files
#
set_permissions()
{
    Ldir=$1
    if [ -d ${Ldir} ]; then
	chown -R ${appuser}:${appgroup} ${Ldir}
    fi
}

#
# add config for php
#
phpconfig()
{
    echo "session.cookie_httponly=on" > /etc/php/7.4/apache2/conf.d/local.ini
}

get_plugins()
{
    download_assets
    install_plugins
}

#
# extract and install plugin in plugins directory
#
install_plugins()
{
    pluginname=glpiinventory
    if [ -d "${pluginsdir}" ]; then
	if [ ! -d "${pluginsdir}/${pluginname}" ]; then
	    cd $pluginsdir
	    bzcat $pkgdir/glpi-glpiinventory-1.0.6.tar.bz2 | tar xf -
	fi
    fi

    set_permissions ${pluginsdir}    
}


#
# get dl url for app
#
get_appdlurl()
{
    VERSION_GLPI=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/latest | grep tag_name | cut -d '"' -f 4)
    SRC_GLPI=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/tags/${VERSION_GLPI} | jq .assets[0].browser_download_url | tr -d \")
    downloadlist="${downloadlist} $SRC_GLPI"
}

#
# download and save in package directory
#
download_assets()
{
    pluginname=glpiinventory
    cd $pkgdir
    download_list ${downloadlist}    
    download_list ${pluginlist}
}

download_list()
{
    Lurllist=$*
    for Lurl in ${Lurllist}; do
	wget $wgetoptions $Lurl
    done
}
