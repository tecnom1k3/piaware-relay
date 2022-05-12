FROM  debian:bullseye

ENV IP=192.168.188.151
ENV PORT=30005
ENV PORT2=30104
ENV PORT3=30105
ENV PORT4=30106

RUN apt-get update && apt-get upgrade -y && apt-get install wget -y

RUN wget -O /etc/apt/sources.list.d/abcd567a.list https://abcd567a.github.io/rpi/abcd567a.list \
    && wget -O /etc/apt/trusted.gpg.d/abcd567a-key.gpg https://abcd567a.github.io/rpi/KEY2.gpg

RUN apt-get update \
    && apt-get install -y piaware

RUN piaware-config receiver-type other \
    && piaware-config receiver-host ${IP} \
    && piaware-config receiver-port ${PORT} \
    && piaware-config mlat-results-format "beast,connect,${IP}:${PORT2} beast,listen,${PORT3} ext_basestation,listen,${PORT4}"

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
