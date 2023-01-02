#!/bin/sh
# file: install-app.sh
#
defaults()
{
    basedir="/opt/glpi"


}

init()
{
    if [ -f ${basedir}/func.sh ]; then
	. ${basedir}/func.sh
    fi
    if [ -f ${basedir}/site.sh ]; then
	. ${basedir}/site.sh
    fi
}


# setup
setup()
{

    create_directory $logdir
    create_directory $pkgdir    

}

defaults

init

setup

get_appdlurl

download_assets

exit 0
