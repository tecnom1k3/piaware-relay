FROM  debian:bullseye-slim as base

RUN apt-get update && apt-get upgrade -y \
    && apt-get install wget -y \
    && rm -rf /var/lib/apt/lists/*


FROM base as piaware

ARG IP=192.168.188.151
ARG PORT=30005
ARG PORT2=30104
ARG PORT3=30105
ARG PORT4=30106

RUN wget -O /etc/apt/sources.list.d/abcd567a.list https://abcd567a.github.io/rpi/abcd567a.list \
    && wget -O /etc/apt/trusted.gpg.d/abcd567a-key.gpg https://abcd567a.github.io/rpi/KEY2.gpg

RUN apt-get update \
    && apt-get install -y piaware \
    && rm -rf /var/lib/apt/lists/*

RUN piaware-config receiver-type other \
    && piaware-config receiver-host ${IP} \
    && piaware-config receiver-port ${PORT} \
    && piaware-config mlat-results-format "beast,connect,${IP}:${PORT2} beast,listen,${PORT3} ext_basestation,listen,${PORT4}"

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
