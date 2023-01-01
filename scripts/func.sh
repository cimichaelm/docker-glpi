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
# download and save in package directory
#
download_assets()
{
    pluginname=glpiinventory
    cd $pkgdir
    for plugin in ${pluginlist}; do
	wget $wgetoptions $plugin
    done
}
