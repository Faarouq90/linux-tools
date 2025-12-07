#!/bin/bash
#Author: Faarouq Asaju
#Date: 04-12-2025
#Description: 




if [ $# -eq 0 ]; then
    printf "Usage: sysreport.sh [--disk | --memory | --all | --help]\n"
    exit 1
fi

case "$1" in
    --disk)
	    df -h
        ;;
    --memory)
	    free -h
        ;;
    --all)
	    df -h; free -h
        ;;
    --help)
        printf "Usage: sysreport.sh [--disk | --memory | --all | --help]\n"
        exit 0
        ;;
    *)
        printf "Invalid option: %s\n" "$1"
        printf "Usage: sysreport.sh [--disk | --memory | --all | --help]\n"
        exit 1
        ;;
esac
