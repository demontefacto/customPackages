#!/bin/bash

PATH=$PATH:/usr/local/sbin:/usr/local/bin:/sbin:/bin

unset routy
PORT=2
ZALOHA=0
INTERFACE=eth2.6
TABULKA=10
ln -s /proc/self/fd /dev/fd
while IFS= read -r line; do routy+=( "$line" ); logger "nacitam $line"; done < <( ip ro l table 10 | grep -v bird )

while true ; do
	if [ $ZALOHA -eq 0 ] ; then
		if swconfig dev switch0 port $PORT get link |grep "link:down" || ! ip ro l table $TABULKA | grep def | grep -v $INTERFACE > /dev/null; then
#		if swconfig dev switch0 port $PORT get link |grep "link:down" || ! birdc4 show route 0.0.0.0/0 | grep -v $INTERFACE > /dev/null ; then
			ZALOHA=1
			ifconfig $INTERFACE down
			logger zruseni VRRP
			H=`hostname`
			lynx -source -auth=alarm:46s54 "http://is.ha-vel.cz/servis/alarm/info.php?subid=4&host=$H&info=Zruseni VRRP na $H"
		fi
		sleep 20
	else
		sleep 60
		if swconfig dev switch0 port $PORT get link |grep "link:up" && ip ro l table $TABULKA | grep def | grep -v $INTERFACE > /dev/null; then
#		if swconfig dev switch0 port $PORT get link |grep "link:up" > /dev/null && birdc4 show route 0.0.0.0/0 | grep -v $INTERFACE ; then
			ZALOHA=0
			ifconfig $INTERFACE up
			for i in "${routy[@]}" ; do logger "aplikuji $i"; ip ro add $i table $TABULKA ; done
			logger nastaveni VRRP
			H=`hostname`
			lynx -source -auth=alarm:46s54 "http://is.ha-vel.cz/servis/alarm/info-odstran.php?subid=4&host=$H&info=Nastaveni VRRP na $H"
		fi
	fi
done
