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

list_enabled_services(){
	printf '\n\n\nEnabled Services: \n\n'
	
	enabled_services=$(systemctl list-unit-files --type=service --state=running --no-legend --no-pager | awk '{print "\t- " $1}')
	
	if [ -z "$enabled_services" ]; then
		printf '\tNone detected\n'
		return 0
	else
		echo "$enabled_services"
	fi
}


list_listening_ports(){

	printf '\n\n\nListening Ports\n'

	listening_ports=$(ss -Htuln | awk '{print "\t- "$1 " " $5}')

	if [ -z "$listening_ports" ]; then
		printf '\tNone detected \n'
	else
		echo "$listening_ports"
	fi

}

detect_public_listeners() {
    printf '\n\nPublic Exposure:\n\n'

    
    listeners=$(ss -Hln)

    
    public=$(printf '%s\n' "$listeners" \
        | awk '{print $1, $4}' \
        | awk '$2 ~ /^0\.0\.0\.0:/ || $2 ~ /^\[::\]:/ || $2 ~ /^:::/ {print}')

    if [ -z "$public" ]; then
        printf '\tNone detected\n'
        return 0
    fi

    printf '%s\n' "$public" | awk '{printf "\tWARN: %s %s\n", $1, $2}'
}


list_active_services
list_enabled_services
list_listening_ports
detect_public_listeners
