FROM ubuntu AS packages

RUN apt-get update && \
apt-get install dotnet-runtime-10.0 -y && \
apt-get install procps screen -y && \
apt-get install wget -y && \
apt-get install jq -y && \
apt-get install python3 -y && \
apt-get -y install sudo && \
apt-get install python3-pip -y

RUN pip install deepdiff --break-system-packages

FROM packages AS container

ENV VERSION=1.22.7
ENV WHITELIST=true
ENV PORT=42420

ENV USERNAME=vintagestory

ENV SCREENNAME='vintagestory_server'
ENV SERVICE="VintagestoryServer.dll"
ENV OPTIONS=""

ENV UPDATE_VERSION="false"

WORKDIR /home

EXPOSE ${PORT}/tcp
EXPOSE ${PORT}/udp

COPY run.sh run.sh
COPY server.sh server.sh
COPY config_manipulator.py config_manipulator.py 

CMD ./run.sh ; sleep infinity