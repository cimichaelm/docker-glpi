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
# extract plugin. does not check for prior version. will overwrite.
#
extract_plugin()
{
    Lfilename=$1
    Lcompress=$2
    
    if [ -d "${pluginsdir}" ]; then
	cd "${pluginsdir}"
	if [ -f "${Lfilename}" ]; then
	    "${extractprog}" "${Lfilename}" | tar xf -
	fi
    fi
}

#
# extract and install plugin in plugins directory
#
install_plugins()
{
    pluginname=glpiinventory
    if [ -d "${pluginsdir}" ]; then
	cd $pluginsdir
	if [ ! -d "${pluginsdir}/${pluginname}" ]; then
	    bzcat $pkgdir/glpi-glpiinventory-1.2.3.tar.bz2 | tar xf -
	fi
	extractprog=bzcat
	for pi in ${pluginsbzinst}; do
	    extract_plugin "${pkgdir}/${pi}"
	done
	extractprog=zcat	
	for pi in ${pluginsgzinst}; do
	    extract_plugin "${pkgdir}/${pi}"
	done
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
# get dl url for app
#
get_github_dlurl()
{
    Lrepo=$1
    Lversion=$2
    Lurl=$(curl -s https://api.github.com/repos/${Lrepo}/releases/tags/${Lversion} | jq .assets[0].browser_download_url | tr -d \")
    downloadlist="${downloadlist} $Lurl"
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
	echo "Downloading: ${Lurl}"
	wget $wgetoptions "${Lurl}"
    done
}
