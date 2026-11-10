# 
if getent passwd $GROUPNAME; then
    echo "group exists"
else 
    groupadd ${GROUPNAME}
fi 
if getent passwd $USERNAME; then
    echo "group exists"
else 
    useradd -u ${USER_ID} -g ${GROUPNAME} -o ${USERNAME} 
fi 

id ${USERNAME} 

if ! [ -d /app/data ]; then 
    mkdir data
    echo "data folder created" 
fi
if ! [ -d /app/server ]; then 
    mkdir server
    echo "server folder created" 
fi

chown -R ${USERNAME}:${GROUPNAME} data
echo chown -R ${USERNAME}:${GROUPNAME} data
chown -R ${USERNAME}:${GROUPNAME} server
echo chown -R ${USERNAME}:${GROUPNAME} server

su -T -cs ${USERNAME} "./entrypoint.sh"