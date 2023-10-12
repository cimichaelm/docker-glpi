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

# check latest version
if [ $glpi_downloadlatest -eq 1 ]; then
    get_appdlurl "${glpi_repo}"
fi

# check if new version
if [ "${glpi_version}" != "${VERSION_GLPI}" ]; then
    get_github_dlurl "${glpi_repo}" "${glpi_version}"
fi

if [ $glpi_downloadassets -eq 1 ]; then
    download_assets
fi

exit 0
