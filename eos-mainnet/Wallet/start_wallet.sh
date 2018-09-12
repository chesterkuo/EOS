#!/bin/bash

################################################################################
#
# Scrip Created by http://CryptoLions.io
# For EOS mainnet
#
# https://github.com/CryptoLions/EOS-MainNet
#
###############################################################################

DATADIR="/opt/eos-mainnet/EOS-MainNet"
NODEOSBINDIR="/opt/eos-jungle-testnet/eos-source-v1.2.3/eos/build/programs"

WALLET_HOST="127.0.0.1"
WALLET_POSRT="3000"


$DATADIR/stop_wallet.sh
$NODEOSBINDIR/keosd/keosd --config-dir $DATADIR --wallet-dir $DATADIR --http-server-address $WALLET_HOST:$WALLET_POSRT $@ & echo $! > $DATADIR/wallet.pid
