FROM ubuntu AS packages

RUN apt-get update && \
apt-get install dotnet-runtime-10.0 -y && \
apt-get install procps screen -y && \
apt-get install wget -y && \
apt-get install jq -y && \
apt-get install python3 -y

FROM packages AS container

ENV VERSION=1.22.7
ENV WHITELIST=true
ENV PORT=42420

RUN useradd vintagestory -m

USER vintagestory
WORKDIR /home/vintagestory

EXPOSE ${PORT}/tcp
EXPOSE ${PORT}/udp

COPY run.sh run.sh
COPY server.sh server.sh
COPY config_manipulator.py config_manipulator.py 

CMD ./run.sh ; sleep infinity