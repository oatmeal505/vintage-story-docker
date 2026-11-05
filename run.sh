#!/bin/bash 
if [ -e server/server.sh]

then
    server/server.sh start
    tail -f /data/Logs/server-main.log

else
    wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
    mkdir server && tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 
    
    cp server.sh server/server.sh

    rm vs_server_linux-x64_${VERSION}.tar.gz
    rm server.sh

    server/server.sh start
    
    server/server.sh stop

    mv data/serverconfig.json tmp.$$.json

    jq '.Port = $VAL' --arg VAL ${PORT} tmp.$$.json > tmp.$$.json
    jq '.ServerName = $VAL' --arg VAL "${SERVERNAME}" tmp.$$.json > tmp.$$.json

    mv tmp.$$.json data/serverconfig.json

    server/server.sh start

    if [[ "$WHITELIST" == "false" ]];

    then
        server/server.sh command serverconfig whitelistmode off
        echo "whitelist disabled"
    else
        server/server.sh command serverconfig whitelistmode on
        echo "whitelist enabled"
    fi

    tail -f /data/Logs/server-main.log

fi
