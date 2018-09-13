#!/bin/bash
ACCOUNT="eoscityioeos"
PUBKEY="EOS5MM1wJP3cz3dkDKPXoiHzBMCwauDkcnRTjjkzFZEd9snMYDei2"
URL="http://cryptolions.io"

./cleos.sh system regproducer $ACCOUNT $PUBKEY "$URL" -p $ACCOUNT
