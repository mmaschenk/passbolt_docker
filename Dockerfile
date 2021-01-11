FROM mmaschenk/passbolt:adhoc

LABEL maintainer="Mark Schenk <m.m.a.schenk@gmail.com>"

USER root

WORKDIR /var/www/passbolt

RUN apt-get update && apt-get install -y procps
CMD ["sleep", "3600"]
