#!/bin/ash
trap 'kill -TERM $PID' TERM INT

echo "This is Tailscale-Caddy-proxy version"
tailscale --version

if [ ! -z "$SKIP_CADDYFILE_GENERATION" ] ; then
   echo "Skipping Caddyfile generation as requested via environment"
else
   echo "Building Caddy configfile"

   echo $TS_HOSTNAME'.'$TS_TAILNET.'ts.net' > /etc/caddy/Caddyfile
   echo 'reverse_proxy' $CADDY_TARGET >> /etc/caddy/Caddyfile
fi

echo "Starting Caddy"
if [ "$CADDY_RESUME" = "true" ]; then
   echo "Starting Caddy with --resume flag"
   caddy start --resume
else
   echo "Starting Caddy with config file"
   caddy start --config /etc/caddy/Caddyfile
fi

echo "Starting Tailscale"

exec /usr/local/bin/containerboot
