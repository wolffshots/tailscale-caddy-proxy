# syntax=docker/dockerfile:1
# check=skip=SecretsUsedInArgOrEnv
ARG TAILSCALE_VERSION=v1.84.2

FROM tailscale/tailscale:$TAILSCALE_VERSION

LABEL maintainer="hollie@lika.be"

# Labels for Github container registry
LABEL org.opencontainers.image.source="https://github.com/wolffshots/tailscale-caddy-proxy" \
    org.opencontainers.image.documentation="https://github.com/wolffshots/tailscale-caddy-proxy/blob/$commit/README.md" \
    org.opencontainers.image.title="tailscale-caddy-proxy"

ENV CADDY_TARGET=
ENV CADDY_RESUME=false
ENV TS_TAILNET=
ENV TS_HOSTNAME=
ENV TS_EXTRA_FLAGS=
ENV TS_USERSPACE=true
ENV TS_STATE_DIR=/var/lib/tailscale/ 
ENV TS_AUTH_ONCE=true

RUN apk update && apk upgrade --no-cache && apk add --no-cache ca-certificates mailcap caddy
RUN caddy upgrade

# Ensure Caddy can access the tailscale socket, Caddy expects it to be under /var/run/tailscale so make a symlink
RUN mkdir --parents /var/run/tailscale && ln -s /tmp/tailscaled.sock /var/run/tailscale/tailscaled.sock

# Add the modified startup script
COPY start.sh /usr/bin/start.sh
RUN  chmod +x /usr/bin/start.sh

# And run it
CMD  [ "start.sh" ]


