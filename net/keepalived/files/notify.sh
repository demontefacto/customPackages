#!/bin/bash

PATH=$PATH:/usr/local/sbin:/sbin:/bin

ROZHRANI=$1
TYPE=$2
NAME=$3
STATE=$4
H=$(hostname)
case $STATE in
        "MASTER") birdc enable master_k
                  logger "enable $STATE"
                  lynx -source -auth=alarm:46s54 "http://is.ha-vel.cz/servis/alarm/info-odstran.php?subid=4&host=$H&info=Nastaveni VRRP na $H"
                  echo 0 > /proc/sys/net/ipv4/conf/$ROZHRANI/arp_filter
                  exit 0
                  ;;
        "BACKUP") birdc disable master_k
                  logger "disable $STATE"
                  lynx -source -auth=alarm:46s54 "http://is.ha-vel.cz/servis/alarm/info.php?subid=4&host=$H&info=Zruseni VRRP na $H"
#                 lynx -source -auth=alarm:46s54 "http://is.ha-vel.cz/servis/alarm/mail.php?prijemce=it.ul@zuusti.cz&predmet=Pripojeni+UL,+,Na+Kabate+-+Doslo+k+vypadku+primarniho+okruhu,+prepnuti+na+zalozni+okruh" &
                  exit 0
                  ;;
        "FAULT")  birdc disable master_k
                  logger "disable $STATE"
                  lynx -source -auth=alarm:46s54 "http://is.ha-vel.cz/servis/alarm/info.php?subid=4&host=$H&info=Zruseni VRRP na $H"
#                  lynx -source -auth=alarm:46s54 "http://is.ha-vel.cz/servis/alarm/mail.php?prijemce=it.ul@zuusti.cz&predmet=Pripojeni+UL,+,Na+Kabate+-+Doslo+k+LINK+DOWN+na+firewall+klienta,+prepnuti+na+zalozni+okruh" &
                  exit 0
                  ;;
        *)        echo "unknown state"
                  exit 1
                  ;;
esac
