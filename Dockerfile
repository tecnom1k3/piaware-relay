FROM  debian:bullseye-slim as base

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y wget procps \
    && rm -rf /var/lib/apt/lists/*


FROM base as piaware

RUN wget -O /etc/apt/sources.list.d/abcd567a.list https://abcd567a.github.io/rpi/abcd567a.list \
    && wget -O /etc/apt/trusted.gpg.d/abcd567a-key.gpg https://abcd567a.github.io/rpi/KEY2.gpg

RUN apt-get update \
    && apt-get install -y piaware piaware-web \
    && rm -rf /var/lib/apt/lists/*
    
ARG ADSB_HOST
ARG FEEDER_ID

RUN piaware-config mlat-results-format "beast,connect,${ADSB_HOST}:30104 beast,listen,30105 ext_basestation,listen,30106" \
    && piaware-config receiver-host ${ADSB_HOST} \
    && piaware-config receiver-type other \
    && piaware-config allow-auto-updates yes \
    && piaware-config allow-manual-updates yes \
    && piaware-config allow-mlat yes \
    && piaware-config feeder-id ${FEEDER_ID}

EXPOSE 80

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
