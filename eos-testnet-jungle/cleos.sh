#!/bin/bash
################################################################################
#
# Scrip Created by http://CryptoLions.io
# For EOS Junlge testnet
#
# https://github.com/CryptoLions/
#
################################################################################

CLEOS=/usr/local/bin/cleos
$CLEOS -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:55553 "$@"
#$CLEOS -u https://127.0.0.1: --wallet-url http://127.0.0.1:55553 "$@"
