#! /bin/bash

IP=$(dig -4 +short myip.opendns.com @resolver1.opendns.com)

echo $IP > ~/.ip
