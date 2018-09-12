FROM alpine:latest

MAINTAINER Joshua Knarr <josh.knarr@gmail.com>

LABEL Description="Provides openstack client tools" Version="0.1"

# Alpine-based installation
# #########################
RUN apk add --update \
  build-base \
  python-dev \
  py-pip \
  py-setuptools \
  ca-certificates \
  gcc \
  libffi-dev \
  openssl-dev \
  musl-dev \
  linux-headers \
  && pip install --upgrade --no-cache-dir pip setuptools 'python-neutronclient==6.7.0' 'python-openstackclient==3.12.0' \
  && apk del gcc musl-dev linux-headers libffi-dev build-base \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted 
# Ex. `docker run -v $PWD:/data jmcvea/openstack-client`
VOLUME ["/data"]

# Default is to start a shell.  A more common behavior would be to override
# the command when starting.
# Ex. `docker run -ti jmcvea/openstack-client openstack server list`
CMD ["/bin/sh"]

