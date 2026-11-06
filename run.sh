#!/bin/bash

export ME=$(whoami)
echo $ME

if [ -d "${USERNAME}/data" ]; then 
    mkdir data && touch ${USERNAME}/data/*
else
    touch ${USERNAME}/data/*
    chown -R ${USERNAME}:${USERNAME} data
fi
if [ -d "${USERNAME}/server" ]; then 
    mkdir server && touch ${USERNAME}/server/*
else 
    touch ${USERNAME}/server/*
    chown -R ${USERNAME}:${USERNAME} server
fi

echo $USERNAME

sudo su - $USERNAME
sudo su - ${USERNAME}

export VSPATH='/home/${USERNAME}}/server'
export DATAPATH='/home/${USERNAME}}/data'
export SaveFileLocation="/home/${USERNAME}/data/Saves/default.vcdbs"
export instdir="/home/${USERNAME}/server"


cp config_manipulator.py ${USERNAME}/config_manipulator.py

if [ -e "${USERNAME}/server/server.sh" ]; then
    if [ -e "${USERNAME}/data/serverconfig.json" ]; then
        python3 ${USERNAME}/config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C ${USERNAME}/server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

            cp server.sh ${USERNAME}/server/server.sh
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    else 
    echo "serverconfig.json not found"
    ${USERNAME}/server/server.sh start
    ${USERNAME}/server/server.sh stop

    python3 ${USERNAME}/config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C ${USERNAME}/server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

            cp server.sh ${USERNAME}/server/server.sh
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    fi
else    
echo "server.sh not found"
wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
tar -C ${USERNAME}/server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

cp server.sh ${USERNAME}/server/server.sh
rm vs_server_linux-x64_${VERSION}.tar.gz

    if [ -e "${USERNAME}/data/serverconfig.json" ]; then
        python3 ${USERNAME}/config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C ${USERNAME}/server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

            cp server.sh ${USERNAME}/server/server.sh
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    else 
    echo "serverconfig.json not found"
        ${USERNAME}/server/server.sh start
        ${USERNAME}/server/server.sh stop

        python3 ${USERNAME}/config_manipulator.py

        if [[ ${UPDATE_VERSION} == "true" ]]; then
            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C ${USERNAME}/server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

            cp server.sh ${USERNAME}/server/server.sh
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    fi
fi 

${USERNAME}/server/server.sh start

tail -f ${USERNAME}/data/Logs/server-main.log