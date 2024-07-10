#!/bin/bash

MUD_ROOT=/home/mud
TELNET_PORT=4711

TLS_PORT=4712
TLS_KEY="$MUD_ROOT/tls/tamedhon.key"
TLS_CERT="$MUD_ROOT/tls/tamedhon.crt"
TLS_ISSUER="$MUD_ROOT/tls/tamedhon.issuer.crt"

$MUD_ROOT/bin/ldmud \
  -D"TLS_PORT=$TLS_PORT" \
  --tls-key="${TLS_KEY}" \
  --tls-cert="${TLS_CERT}" \
  --tls-trustfile="${TLS_ISSUER}" \
  $TELNET_PORT \
  $TLS_PORT
