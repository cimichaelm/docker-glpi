#!/bin/sh
# file: install-app.sh
#
defaults()
{
    # environment variables
    # GLPI_VAR_DIR
    # GLPI_CONFIG_DIR
    tmpdir=/var/tmp
    logdir=/var/tmp/log
    logfile="${logdir}/init.log"

    basedir="/opt/glpi"

    webdir=/var/www/html
    appuser=www-data
    appgroup=www-data
    glpidir="${webdir}/glpi"
    filesdir="${webdir}/files"
    pluginsdir="${glpidir}/plugins"
    subdirlist="_cache _cron _dumps _graphs _lock _pictures _plugins _rss _sessions _tmp _uploads"
    pkgdir=${tmpdir}/pkg

}

init()
{
    if [ -f ${basedir}/func.sh ]; then
	. ${basedir}/func.sh
    fi
    if [ -f ${basedir}/site.sh ]; then
	. ${basedir}/site.sh
    fi
    siteconfig
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


defaults

init

setup

install_plugins

exit 0
