#!/bin/bash 
if [ -e server/server.sh]

then
    server/server.sh start

else
    wget https://cdn.vintagestory.at/gamefiles/stable/vs_server_linux-x64_${VERSION}.tar.gz  
    mkdir server && tar -C server -xzf vs_server_linux-x64_${VERSION}.tar.gz 
    
    cp server.sh server/server.sh

    rm vs_server_linux-x64_${VERSION}.tar.gz
    rm server.sh

    server/server.sh start

    server/server.sh stop

    cp data/serverconfig.json tmp.$$.json

    if [[ "$WHITELIST" == "false" ]];

    then
        jq '.OnlyWhitelisteddata = $VAL' --arg VAL ${WHITELIST} tmp.$$.json > tmp.$$.json
        jq '.WhitelistMode = $VAL' --arg VAL 1 tmp.$$.json > tmp.$$.json
    else
        jq '.OnlyWhitelisteddata = $VAL' --arg VAL ${WHITELIST} tmp.$$.json > tmp.$$.json
        jq '.WhitelistMode = $VAL' --arg VAL 2 tmp.$$.json > tmp.$$.json
    fi
    
    jq '.Port = $VAL' --arg VAL ${PORT} tmp.$$.json > tmp.$$.json
    jq '.ServerName = $VAL' --arg VAL "${SERVERNAME}" tmp.$$.json > tmp.$$.json

    cp tmp.$$.json data/serverconfig.json

    server/server.sh start

fi
