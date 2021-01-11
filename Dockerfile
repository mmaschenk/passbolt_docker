FROM mmaschenk/passbolt:adhoc

LABEL maintainer="Mark Schenk <m.m.a.schenk@gmail.com>"

USER root

WORKDIR /var/www/passbolt

CMD ["sleep 3600"]
