#!/usr/bin/env bash

. beddu.sh

pen purple "Hello, I'm your IP helper, here for all your IP needs!"

choose ACTION "What would you like to do?" "Get my IP" "Get my location"

case "$ACTION" in
    "Get my IP")
        run --out IP curl ipinfo.io/ip
        pen "Your IP is $IP"
        ;;
    "Get my LOCATION")
        run --out LOCATION curl -s ipinfo.io/loc
        pen "Your coordinates are $LOCATION"
        ;;
esac
