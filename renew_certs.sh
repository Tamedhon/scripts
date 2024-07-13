#!/bin/bash

output=$(certbot renew)
RENEW_STATUS=$?

if [[ $RENEW_STATUS -eq 0 && $output == *"Congratulations"* ]]; then
  rm /home/mud/tls/tamedhon.crt
  rm /home/mud/tls/tamedhon.issuer.crt
  rm /home/mud/tls/tamedhon.key
  cp /etc/letsencrypt/live/mud.tamedhon.de/fullchain.pem /home/mud/tls/tamedhon.crt
  cp /etc/letsencrypt/live/mud.tamedhon.de/chain.pem /home/mud/tls/tamedhon.issuer.crt
  cp /etc/letsencrypt/live/mud.tamedhon.de/privkey.pem /home/mud/tls/tamedhon.key
  chown mud: /home/mud/tls/*
  systemctl restart proftpd.service
  killall -SIGUSR2 ldmud
fi
