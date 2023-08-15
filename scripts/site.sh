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

    pluginlist="https://github.com/pluginsGLPI/mreporting/releases/download/1.8.2/glpi-mreporting-1.8.2.tar.bz2 https://github.com/glpi-project/glpi-inventory-plugin/releases/download/1.2.3/glpi-glpiinventory-1.2.3.tar.bz2 https://github.com/yllen/reports/releases/download/v1.16.0/glpi-reports-1.16.0.tar.gz https://github.com/pluginsGLPI/datainjection/releases/download/2.13.2/glpi-datainjection-2.13.2.tar.bz2 https://github.com/yllen/pdf/releases/download/v3.0.0/glpi-pdf-3.0.0.tar.gz https://github.com/InfotelGLPI/mydashboard/releases/download/2.1.5/glpi-mydashboard-2.1.5.tar.bz2 https://github.com/pluginsGLPI/barcode/releases/download/2.7.1/glpi-barcode-2.7.1.tar.bz2 https://github.com/pluginsGLPI/genericobject/releases/download/2.14.4/glpi-genericobject-2.14.4.tar.bz2 https://github.com/cconard96/glpi-camerainput-plugin/releases/download/v2.1.0/glpi-camerainput-v2.1.0.tar.bz2 https://github.com/yllen/behaviors/releases/download/v2.7.2/glpi-behaviors-2.7.2.tar.gz https://github.com/pluginsGLPI/metabase/releases/download/1.3.3/glpi-metabase-1.3.3.tar.bz2 https://github.com/pluginsGLPI/fields/releases/download/1.21.0/glpi-fields-1.21.0.tar.bz2"
    downloadlist=""
    wgetoptions="--quiet"
    pluginsbzinst="glpi-barcode-2.7.1.tar.bz2 glpi-behaviors-2.7.2.tar.gz glpi-camerainput-v2.1.0.tar.bz2 glpi-datainjection-2.13.2.tar.bz2 glpi-genericobject-2.14.4.tar.bz2 glpi-mreporting-1.8.2.tar.bz2 glpi-mydashboard-2.1.5.tar.bz2 glpi-fields-1.21.0.tar.bz2"
    pluginsgzinst="glpi-pdf-3.0.0.tar.gz glpi-reports-1.16.0.tar.gz"
    extractprog=bzcat    
}

siteconfig
