#!/bin/bash

ReleaseID=$(lsb_release -i | awk '{print $3}')
Supported=false

[[ "${ReleaseID}" == "Ubuntu"  ]] && Supported=true
[[ "${ReleaseID}" == "Debian"  ]] && Supported=true

[[ "${Supported}" == "false" ]] && echo "This distribution version is not supported. Aborting" && exit

if [[ ${ReleaseID} == "Debian" ]] || [[ ${ReleaseID} == "Ubuntu" ]]; then
    echo "Detected ${ReleaseID}..."
    echo "Running install-debian.sh"
    echo ""
    sleep 2
    bash install-debian.sh
fi

