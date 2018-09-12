#!/bin/bash
################################################################################
#
# Scrip Created by http://CryptoLions.io
# For EOS Junlge testnet
#
# https://github.com/CryptoLions/
#
################################################################################

DATADIR=/opt/eos-jungle-testnet/wallet
$DATADIR/stop.sh
/usr/local/bin/keosd --wallet-dir $DATADIR --data-dir $DATADIR --http-server-address 127.0.0.1:55553 "$@" > /opt/eos-jungle-testnet/wallet/stdout.txt 2> /opt/eos-jungle-testnet/wallet/stderr.txt  & echo $! > $DATADIR/wallet.pid
echo "Wallet started"
