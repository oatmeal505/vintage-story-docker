FROM ubuntu AS packages

# installs required packages 
RUN apt-get update && \
apt-get install dotnet-runtime-10.0 -y && \
apt-get install procps screen -y && \
apt-get install wget -y && \
apt-get install jq -y && \
apt-get install python3 -y && \
apt-get install python3-pip -y

# installs required pip extensions
RUN pip install deepdiff --break-system-packages

FROM packages AS container

# base server configurations
ENV VERSION=1.22.7
ENV WHITELIST=true
ENV PORT=42420
ENV UPDATE_VERSION="false"

# Default user configuration
ENV USERNAME=ubuntu
ENV GROUPNAME=ubuntu
ENV USER_ID=1001
ENV GROUP_ID=1001

WORKDIR /app

# default network ports
EXPOSE ${PORT}/tcp
EXPOSE ${PORT}/udp

# copy scripts 
COPY entrypoint.sh entrypoint.sh
COPY user-configuration.sh user-configuration.sh
COPY config_manipulator.py config_manipulator.py 

# set entry point
CMD ./user-configuration.sh entrypoint.sh