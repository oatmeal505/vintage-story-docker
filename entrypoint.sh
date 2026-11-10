#!/bin/bash

if [ -e "server/VintagestoryServer.dll" ]; then
    if [ -e "data/serverconfig.json" ]; then
        python3 config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            echo "updating server..."

            rm -r server 
            mkdir server

            wget -P server/ https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf server/vs_server_linux-x64_${VERSION}.tar.gz 
            rm server/vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    else 

    echo "serverconfig.json not found"
    dotnet server/VintagestoryServer.dll --dataPath /home/vintagestory/data &
    sleep 18
    kill %%
    sleep 3



    python3 config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            rm -r server 
            mkdir server

            wget -P server/ https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf server/vs_server_linux-x64_${VERSION}.tar.gz 
            rm server/vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    fi
else    

echo "vintage story binary not found!"
wget -P server/ https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
tar -C server -xzf server/vs_server_linux-x64_${VERSION}.tar.gz 
rm server/vs_server_linux-x64_${VERSION}.tar.gz

    if [ -e "data/serverconfig.json" ]; then
        python3 config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            rm -r server 
            mkdir server

            wget -P server/ https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf server/vs_server_linux-x64_${VERSION}.tar.gz 
            rm server/vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    else 

    echo "serverconfig.json not found"
    dotnet server/VintagestoryServer.dll --dataPath /home/vintagestory/data &
    sleep 18
    kill %%
    sleep 3


    python3 config_manipulator.py

        if [[ ${UPDATE_VERSION} == "true" ]]; then
            rm -r server 
            mkdir server

            wget -P server/ https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf server/vs_server_linux-x64_${VERSION}.tar.gz 
            rm server/vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    fi
fi

dotnet server/VintagestoryServer.dll --dataPath /home/vintagestory/data

