FROM ubuntu:latest AS packages

RUN apt-get update && \
apt-get install dotnet-runtime-10.0 -y && \
apt-get install procps screen -y && \
apt-get install wget -y && \
apt-get install jq -y

FROM packages AS container

ENV VERSION=1.22.7
ENV WHITELIST=true
ENV USERNAME=vintagestory
ENV PORT=42420
ENV SERVERNAME="Vintage Story Server"
ENV PASSWORD=null

RUN useradd ${USERNAME} -m

USER $USERNAME
WORKDIR /home/${USERNAME}

EXPOSE ${PORT}/tcp
EXPOSE ${PORT}/udp

COPY run.sh run.sh
COPY server.sh server.sh

CMD ./run.sh ; sleep infinity