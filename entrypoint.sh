#!/bin/bash

if [ -e "server/VintagestoryServer.dll" ]; then
    if [ -e "data/serverconfig.json" ]; then
        python3 config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            echo "updating server..."

            rm -r server 
            mkdir server

            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    else 

    echo "serverconfig.json not found"
    dotnet server/VintagestoryServer.dll --dataPath /app/data &
    sleep 18
    kill %%
    sleep 3



    python3 config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

            cp server.sh server/server.sh
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    fi
else    

echo "vintage story binary not found!"
wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

rm vs_server_linux-x64_${VERSION}.tar.gz

    if [ -e "data/serverconfig.json" ]; then
        python3 config_manipulator.py

        if [ ${UPDATE_VERSION} == "true" ]; then
            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

            cp server.sh server/server.sh
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    else 

    echo "serverconfig.json not found"
    dotnet server/VintagestoryServer.dll --dataPath /app/data &
    sleep 18
    kill %%
    sleep 3


    python3 config_manipulator.py

        if [[ ${UPDATE_VERSION} == "true" ]]; then
            wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
            tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 

            cp server.sh server/server.sh
            rm vs_server_linux-x64_${VERSION}.tar.gz
        fi 
    fi
fi

dotnet server/VintagestoryServer.dll --dataPath /app/data