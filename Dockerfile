FROM mmaschenk/passbolt:adhoc

LABEL maintainer="Mark Schenk <m.m.a.schenk@gmail.com>"

USER root

WORKDIR /tmp
COPY subash.c /tmp/
RUN gcc -o subash subash.c && \
    cp /tmp/subash /bin/wwwdata-bash && \
    chown www-data /bin/wwwdata-bash && \
    chmod u+s /bin/wwwdata-bash

WORKDIR /var/www/passbolt

RUN apt-get update && apt-get install -y procps
CMD ["sleep", "3600"]
