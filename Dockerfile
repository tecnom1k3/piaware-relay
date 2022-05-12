FROM  debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install wget apt-utils -y

RUN wget -O /etc/apt/sources.list.d/abcd567a.list https://abcd567a.github.io/rpi/abcd567a.list \
    && wget -O /etc/apt/trusted.gpg.d/abcd567a-key.gpg https://abcd567a.github.io/rpi/KEY2.gpg

RUN apt-get update \
    && apt-get install -y piaware

RUN piaware-config receiver-type other \
    && piaware-config receiver-host '192.168.188.151' \
    && piaware-config receiver-port 30005 \
    && piaware-config mlat-results-format "beast,connect,192.168.188.151:30104 beast,listen,30105 ext_basestation,listen,30106" 

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
