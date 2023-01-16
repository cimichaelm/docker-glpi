#!/bin/sh
defaults()
{
    tmpdir=/var/tmp
    logdir=$tmpdir
    logfile=$logdir/glpi-cron.log
    jobuser=www-data
}

batchjob()
{
    sudo -E -u $jobuser /usr/bin/php /var/www/html/glpi/front/cron.php 2>&1 > $logfile
}

defaults

batchjob

