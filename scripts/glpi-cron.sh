#!/bin/sh
defaults()
{
    tmpdir=/var/tmp
    logdir=$tmpdir
    logfile=$logdir/glpi-cron.log
    jobuser=www-data
    glpiopt=/opt/glpi
}

batchjob()
{
    if [ -f $glpiopt/environment ]; then
	. $glpiopt/environment
    fi
#    sudo -E -u $jobuser /usr/bin/php /var/www/html/glpi/front/cron.php 2>&1 > $logfile
    /usr/bin/php /var/www/html/glpi/front/cron.php 2>&1 > $logfile    
}

defaults

batchjob

