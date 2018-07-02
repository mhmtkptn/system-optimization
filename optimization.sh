#!/bin/bash
#==============================================================================

#TITLE:            optimization.sh
#DESCRIPTION:      Ubuntu tabanlı sistemler için temel optimizasyon işlemlerini yapar
#AUTHOR:           kaptan
#CRON:             0 2 * * * /bin/bash /scriptin-bulundugu-dizin/optimization.sh >/dev/null 2>&1

#==============================================================================


function checkPrivilage() {

    if [ "$USER" != 'root' ]; then
        echo Lutfen root olarak scripti çalıştırın !!!
    fi

    changeAptSettingsAndSourceList
}

function changeAptSettingsAndSourceList() {

	echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4 \
	\
    && echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

    updateProcess
}

function updateProcess() {

    apt-get update &&
    apt-get -y upgrade &&
    apt-get -y dist-upgrade &&

    cleanProcess
}

function cleanProcess() {

    apt-get -y purge unity-lens-shopping
    apt-get -y purge unity-webapps-common
    apt-get -y purge zeitgeist
    apt-get -y purge zeitgeist-datahub
    apt-get -y purge zeitgeist-core
    apt-get -y purge zeitgeist-extension-fts
    apt-get -y purge apturl

    apt-get clean
    apt-get -y autoclean &&
    apt-get -y autoremove

    dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n "/$(uname -r)/q;p" | xargs  apt-get -y purge


    sync; echo 3 > /proc/sys/vm/drop_caches

    /sbin/fstrim --all || true
}

checkPrivilage