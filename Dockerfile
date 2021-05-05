FROM  telegraf:1.18.1

RUN   set -x \
      && \
      apt-get -qq update && apt-get -qq upgrade \
      && \
      apt-get -qq install \
      debian-archive-keyring \
      curl \
      gnupg \
      apt-transport-https \
      && \
      curl -Ss -L https://packagecloud.io/varnishcache/varnish60lts/gpgkey | apt-key add - \
      && \
      printf "%s\n%s" \
      "deb https://packagecloud.io/varnishcache/varnish60lts/debian/ buster main" \
      "deb-src https://packagecloud.io/varnishcache/varnish60lts/debian/ buster main" \
      > "/etc/apt/sources.list.d/varnishcache_varnish60lts.list" \
      && \
      apt-get -qq update && apt-get -qq install varnish=6.0.7-1~buster \
      && \
      apt-get -qq purge curl gnupg apt-transport-https && \
      apt-get -qq autoremove && apt-get -qq autoclean && \
      rm -rf /var/cache/*

CMD  ["telegraf"]
