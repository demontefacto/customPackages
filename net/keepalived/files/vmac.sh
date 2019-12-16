#!/bin/bash

PATH=$PATH:/usr/local/sbin:/sbin:/bin

ROZHRANI=$1

echo 0 > /proc/sys/net/ipv4/conf/$ROZHRANI/arp_filter
