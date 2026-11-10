# 
if id $GROUPNAME >/dev/null 2>&GROUPNAME; then
    echo "group exists"
else 
    groupadd ${GROUPNAME}
fi 

if id $USERNAME >/dev/null 2>&USERNAME; then
    echo "group exists"
else 
    useradd -u ${USER_ID} -g ${GROUPNAME} ${USERNAME} 
fi 

id ${USERNAME} 

if ! [ -d /app/data ]; then 
    mkdir data
    echo "data folder created" 
else 
    chown -R --silent ${USERNAME}:${GROUPNAME} data
fi
if ! [ -d /app/server ]; then 
    mkdir server
    echo "server folder created" 
else 
    chown -R --silent ${USERNAME}:${GROUPNAME} server
fi

su - ${USERNAME} "./entrypoint.sh"