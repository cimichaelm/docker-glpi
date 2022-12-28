#!/bin/sh
# file: init-container.sh
#
defaults()
{
    # environment variables
    # GLPI_VAR_DIR
    # GLPI_CONFIG_DIR
    tmpdir=/var/tmp
    logdir=/var/tmp/log
    logfile="${logdir}/init.log"
    webdir=/var/www/html
    appuser=www-data
    appgroup=www-data
    glpidir="${webdir}/glpi"
    filesdir="${webdir}/files"
    pluginsdir="${glpi}/plugins"
    subdirlist="_cache _cron _dumps _graphs _lock _pictures _plugins _rss _sessions _tmp _uploads"
    pkgdir=${tmpdir}/pkg
    
}

# create_directory if not existing
create_directory()
{
    Ldir=$1
    if [ ! -d ${Ldir} ]; then
        mkdir -p ${Ldir}
    fi
}

set_permissions()
{
    Ldir=$1
    if [ -d ${Ldir} ]; then
	chown -R ${appuser}:${appgroup} ${Ldir}
    fi
}

# setup
setup()
{

    create_directory $logdir
    create_directory $pkgdir    

    # create subdirs
    for subdir in $subdirlist; do
	newdir="${filesdir}/$subdir"
	echo "Checking: ${newdir}"
	create_directory ${newdir}
    done

    # set permissions
    set_permissions ${filesdir}    
    set_permissions $GLPI_CONFIG_DIR
    set_permissions ${pluginsdir}
}

phpconfig()
{
    echo "session.cookie_httponly=on" > /etc/php/7.4/apache2/conf.d/local.ini
}

get_plugins()
{
    pluginname=glpiinventory
    cd $pkgdir
    if [ ! -d "${pluginsdir}/${pluginname}" ]; then
	wget https://github.com/glpi-project/glpi-inventory-plugin/releases/download/1.0.6/glpi-glpiinventory-1.0.6.tar.bz2
	cd $pluginsdir
	bzcat $pkgdir/glpi-glpiinventory-1.0.6.tar.bz2 | tar xf -
    fi

    set_permissions ${pluginsdir}    
}

defaults

setup

phpconfig

get_plugins

exit 0
