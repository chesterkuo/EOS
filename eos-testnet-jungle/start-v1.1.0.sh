#!/bin/bash
################################################################################
#
# Scrip Created by http://CryptoLions.io
# For EOS Junlge testnet
#
# https://github.com/CryptoLions/
#
################################################################################

NODEOS=/opt/eos-jungle-testnet/eos-source-v1.1.0/eos/build/programs/nodeos/nodeos
DATADIR=/opt/eos-jungle-testnet/JungleTestnet-eoscityio123
$DATADIR/stop.sh
#$NODEOS --hard-replay --truncate-at-block 10421900 --data-dir $DATADIR --config-dir $DATADIR "$@" > $DATADIR/stdout.txt 2> $DATADIR/stderr.txt &  echo $! > $DATADIR/nodeos.pid
$NODEOS --delete-all-blocks --genesis-json genesis.json --data-dir $DATADIR --config-dir $DATADIR "$@" > $DATADIR/stdout.txt 2> $DATADIR/stderr.txt &  echo $! > $DATADIR/nodeos.pid
