#! /bin/bash

device_mac="1c:87:2c:ae:60:17"
nmcli con up id Hotspot

ON=0

# check while device is down
while [ $ON -eq 0 ]; do
	if arp -an | grep -q $device_mac; then ON=1 ; fi
	sleep 10
done

# check while device is up
while [ $ON -eq 1 ]; do
	sleep 60
	if ! arp -an | grep -q $device_mac; then ON=0 ; fi
	if [ $ON -eq 0 ] ; then
		sleep 10
		if arp -an | grep -q $device_mac; then ON=1 ; fi
	fi
done

shutdown -P now
