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
    filesdir="${webdir}/files"
    pluginsdir="${webdir}/plugins"
    subdirlist="_cache _cron _dumps _graphs _lock _pictures _plugins _rss _sessions _tmp _uploads"
    
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
    cd $tmpdir
    wget https://github.com/glpi-project/glpi-inventory-plugin/releases/download/1.0.6/glpi-glpiinventory-1.0.6.tar.bz2
    bunzip2 glpi-glpiinventory-1.0.6.tar.bz2
    cd $pluginsdir
    tar xvf $tmpdir/glpi-glpiinventory-1.0.6.tar
}

defaults

setup

phpconfig

exit 0
