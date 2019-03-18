#!/bin/bash
#zde se zada IP tunelu na strane serveru
TUN=$1
IPVPN=$2

#######################################################
while true ; do

 if ! ping -c 2 -w 10 -q $IPVPN > /dev/null ; then
  echo restart tunelu
  logger restart tunelu
  PID=`ps ax |grep $TUN|grep -v grep|grep -v check`
  kill -9 $PID
  sleep 2
 fi
 sleep 10

done
