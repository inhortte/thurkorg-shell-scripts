#!/usr/bin/env zsh

cert_path=/etc/nginx/certs
declare -A certs
certs=(
  "thurk.org" "thurk.crt"
  "funkwhale.thurk.org" "funkwhale.crt"
  "kvaseni.thurk.org" "kvaseni.crt"
  "mrak.thurk.org" "mrak.crt"
  "sordid.thurk.org" "sordid.crt"
  "vrasek.thurk.org" "vrasek.crt"
  "zirejnasondu.thurk.org" "zirejnasondu.crt"
  "beaver.thurk.org" "beaver.crt"
)

for key value in ${(kv)certs}; do
  echo "checking $key"
  pustule=$(ssl-cert-check -c $cert_path/$value)
  bull=$(echo $pustule | grep FILE | tr -s " " | cut -d " " -f 6)
  if [[ $bull < 0 ]]
  then
    echo "renewing $key"
    $(certbot certonly --nginx -d $key > /dev/null)
    sleep 30
  fi
done
