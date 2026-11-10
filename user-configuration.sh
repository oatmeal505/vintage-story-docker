# 
groupmod --gid ${GROUP_ID} -n ${GROUPNAME} ubuntu
useradd -g ${GROUPNAME} ${USERNAME} 
usermod -u ${USER_ID} -g ${GROUPNAME} -o ${USERNAME} 

if ! [ -d /home/vintagestory/data ]; then 
    mkdir data
    echo "data folder created" 
fi
if ! [ -d /home/vintagestory/server ]; then 
    mkdir server
    echo "server folder created" 
fi

chown -R ${USERNAME}:${GROUPNAME} data
chown -R ${USERNAME}:${GROUPNAME} server
chown -R ${USERNAME}:${GROUPNAME} entrypoint.sh
chown -R ${USERNAME}:${GROUPNAME} config_manipulator.py

su -T -c "./entrypoint.sh" ${USERNAME} 