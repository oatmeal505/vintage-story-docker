# 
getent passwd ubuntu:1000
userdel --force Ubuntu

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
chown -R ${USERNAME}:${GROUPNAME} server

su -E ${USERNAME} "./entrypoint.sh"