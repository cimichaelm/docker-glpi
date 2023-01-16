#!/bin/sh
# file: init-container.sh
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
    siteconfi
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

save_env()
{
    cat <<EOF > /opt/glpi/environment
GLPI_CONFIG_DIR=$GLPI_CONFIG_DIR
GLPI_LANG=$GLPI_LANG
GLPI_VAR_DIR=$GLPI_VAR_DIR
EOF
}

defaults

init

setup

save_env

phpconfig

exit 0
