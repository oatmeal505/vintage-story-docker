# 
getent passwd ubuntu
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