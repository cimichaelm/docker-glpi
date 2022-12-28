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
    if [ -d ${filesdir} ]; then
	chown -R ${appuser}:${appgroup} ${filesdir}
    fi
}

phpconfig()
{
    echo "session.cookie_httponly=on" > /etc/php/7.4/apache2/conf.d/local.ini
}

defaults

setup

phpconfig

exit 0
