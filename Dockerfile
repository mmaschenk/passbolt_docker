FROM mmaschenk/passbolt:adhoc

LABEL maintainer="Mark Schenk <m.m.a.schenk@gmail.com>"

USER root

WORKDIR /tmp
COPY subash.c /tmp/
RUN gcc -o subash subash.c && \
    cp /tmp/subash /bin/wwwdata-bash && \
    chown www-data /bin/wwwdata-bash && \
    chmod u+s /bin/wwwdata-bash

COPY subash.c /tmp/
RUN gcc -o envsubash envsubash.c && \
    cp /tmp/envsubash /bin/wwwdata-bash-env && \
    chown www-data /bin/wwwdata-bash-env && \
    chmod u+s /bin/wwwdata-bash-env

WORKDIR /var/www/passbolt

COPY bin/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod 775 /etc/ssl/certs

RUN apt-get update && apt-get install -y procps
CMD ["sleep", "3600"]
