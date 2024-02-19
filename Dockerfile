FROM debian:stable-slim

RUN apt-get update && apt-get install -y calibre xvfb imagemagick

RUN mkdir /srv/calibre

RUN groupadd -r calibre
RUN useradd  --home /srv/calibre -g calibre -r calibre
RUN chown calibre:calibre /srv/calibre
RUN chmod 700 /srv/calibre

COPY scripts/calibre-server.sh /usr/local/bin/calibre-server.sh
ADD files/library /usr/local/share/calibre/library
RUN chmod a+x /usr/local/bin/calibre-server.sh

USER calibre
RUN mkdir /srv/calibre/logs

# define entrypoint
ENTRYPOINT /usr/local/bin/calibre-server.sh

# run sleep infinity
CMD [ "/usr/bin/sleep", "infinity" ]

ARG CALIBRE_LIBRARY_PATH="/srv/calibre/library"
ARG CALIBRE_OPTIONS=""
