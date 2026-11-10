# 
groupadd -g ${GROUP_ID} ${GROUPNAME}
useradd -u ${USER_ID} -g ${GROUPNAME} ${USERNAME} 

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