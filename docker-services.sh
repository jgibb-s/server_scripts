#!/bin/bash

# @author   https://www.reddit.com/user/LookAtMyKeyboard
# @author   https://github.com/darookee/

# Declare array of services and pretty human readable names
declare -a services=(
"glances"
"heimdall"
"jellyfin"
"jellyseerr"
"jupyter_notebook"
"lidarr"
"mealie"
"nextcloud"
"photoprism"
"pihole"
"portainer"
"prowlarr"
"radarr"
"readarr"
"sonarr"
"stirling-pdf"
"transmission"
#"vaultwarden"
"watchtower"
"wireguard"
"ytdl"
)

declare -a serviceName=(
"Glances"
"Heimdall"
"Jellyfin"
"Jellyseerr"
"Jupyter"
"Lidarr"
"Mealie"
"Nextcloud"
"PhotoPrism"
"Pihole"
"Portainer"
"Prowlarr"
"Radarr"
"Readarr"
"Sonarr"
"Stirling-PDF"
#"Transmission-vpn"
"Transmission"
#"Vaultwarden"
"Watchtower"
"Wireguard"
"youtube-dl"
)
declare -a serviceStatus=()

# Get status of all my services
for service in "${services[@]}"
do
    serviceStatus+=($(docker inspect -f {{.State.Running}} "${service}"))
done

# Maximum column width
width=$((75))

# Current line and line length
line="  "
lineLen=0

printf "Containers running:\n"

for i in ${!serviceStatus[@]}
do
    # Next line and next line length
    next=" ${serviceName[$i]}: \e[5m${serviceStatus[$i]}"
    nextLen=$((1+${#next}))

    # If the current line will exceed the max column with then echo the current line and start a new line
    if [[ $((lineLen+nextLen)) -gt width ]]; then
    printf "$line\n"
    lineLen=0
    line="  "
    fi

    lineLen=$((lineLen+nextLen))

    # Color the next line green if it's active, else red
    if [[ "${serviceStatus[$i]}" == "true" ]]; then
    line+="\e[32m\e[0m${serviceName[$i]}: \e[32m● ${serviceStatus[$i]}\e[0m "
    else
    line+="${serviceName[$i]}: \e[31m▲ ${serviceStatus[$i]}\e[0m "
    fi
done

# echo what is left
printf "$line\n"
