#!/bin/bash

MUD_ROOT=/home/mud

TLS_KEY="$MUD_ROOT/tls/tamedhon.key"
TLS_CERT="$MUD_ROOT/tls/tamedhon.crt"
TLS_ISSUER="$MUD_ROOT/tls/tamedhon.issuer.crt"

$MUD_ROOT/bin/ldmud \
  --tls-key="${TLS_KEY}" \
  --tls-cert="${TLS_CERT}" \
  --tls-trustfile="${TLS_ISSUER}"
