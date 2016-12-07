FROM frolvlad/alpine-glibc
RUN  apk add --update ruby ruby-io-console ruby-bundler ruby-dev ruby-json ca-certificates openssl-dev gcc libc-dev make
RUN  gem install --no-ri --no-rdoc sinatra puma
RUN  apk del ruby-dev openssl-dev gcc libc-dev make
RUN  apk add --update coreutils && cp /usr/bin/paste /tmp && apk del coreutils && mv /tmp/paste /usr/bin/paste
RUN  rm -rf /var/cache/apk/*

ENV  RACK_ENV production
ENV  MOUNTS /var/lib/docker-volume-plugin-shell

ADD  driver /driver
RUN  mv /driver/docker-entrypoint.sh /bin/docker-volume-plugin-shell
ENTRYPOINT ["docker-volume-plugin-shell"]