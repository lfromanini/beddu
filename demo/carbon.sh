#!/usr/bin/env bash

. beddu.sh

line
pen purple "Hello, I'm your IP helper, here to help you will all your IP needs."
line

choose action "What would you like to do?" "Get my IP" "Get my location"

case "$action" in
    "Get my IP")
        run --out ip curl ipinfo.io/ip
        line; pen "Your IP is $ip"
        ;;
    "Get my location")
        run --out location curl -s ipinfo.io/loc
        line; pen "Your coordinates are $location"
        ;;
esac

