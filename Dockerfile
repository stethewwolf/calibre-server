FROM debian

RUN apt-get update && apt-get install -y calibre 

RUN mkdir /srv/calibre

RUN groupadd -r calibre
RUN useradd -r calibre

COPY calibre-server.service /etc/systemd/system/calibre-server.service
