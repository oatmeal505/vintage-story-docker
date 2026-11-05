#!/bin/bash

wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
mkdir server && tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 
    
cp server.sh server/server.sh

rm vs_server_linux-x64_${VERSION}.tar.gz

server/server.sh start

if [[ "$WHITELIST" == "false" ]];

then
    server/server.sh command serverconfig whitelistmode off
    echo "whitelist disabled"
else
    server/server.sh command serverconfig whitelistmode on
    echo "whitelist enabled"
fi

server/server.sh stop

python3 config_manipulator.py

server/server.sh start

tail -f data/Logs/server-main.log

