#!/bin/bash
#Author: Faarouq Asaju
#Date: 24-12-2025
#Descr: lists running services and listening ports to identify potential system exposure.


list_active_services(){

	printf 'Active Services: \n\n'

	active_services=$(systemctl list-units --type=service --state=running --no-legend  | awk '{print "\t- " $1}')
	if [ -z "$active_services" ]; then
		printf 'None detected\n'
		return 0
	else
		echo "$active_services"
	fi
}

list_active_services
