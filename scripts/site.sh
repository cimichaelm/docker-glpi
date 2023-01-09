#!/bin/sh
# file: site.sh
#
# site config values
#
siteconfig()
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
    pkgdir=${tmpdir}/pkg
    glpidir="${webdir}/glpi"
    filesdir="${webdir}/files"
    pluginsdir="${glpidir}/plugins"
    subdirlist="_cache _cron _dumps _graphs _lock _pictures _plugins _rss _sessions _tmp _uploads"

    pluginlist="https://github.com/pluginsGLPI/mreporting/releases/download/1.8.2/glpi-mreporting-1.8.2.tar.bz2 https://github.com/glpi-project/glpi-inventory-plugin/releases/download/1.0.6/glpi-glpiinventory-1.0.6.tar.bz2 https://github.com/yllen/reports/releases/download/v1.16.0/glpi-reports-1.16.0.tar.gz https://github.com/pluginsGLPI/datainjection/releases/download/2.12.0/glpi-datainjection-2.12.0.tar.bz2 https://github.com/yllen/pdf/releases/download/v3.0.0/glpi-pdf-3.0.0.tar.gz https://github.com/InfotelGLPI/mydashboard/releases/download/2.1.4/glpi-mydashboard-2.1.4.tar.bz2 https://github.com/pluginsGLPI/barcode/releases/download/2.7.1/glpi-barcode-2.7.1.tar.bz2 https://github.com/pluginsGLPI/genericobject/releases/download/2.14.1/glpi-genericobject-2.14.1.tar.bz2 https://github.com/cconard96/glpi-camerainput-plugin/releases/download/v2.0.2/glpi-camerainput-v2.0.2.tar.bz2"
    downloadlist=""
    wgetoptions="--quiet"
    
}

siteconfig
