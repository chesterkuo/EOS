#!/bin/bash
################################################################################
#
# Scrip Created by http://CryptoLions.io
# For EOS Junlge testnet
#
# https://github.com/CryptoLions/
#
################################################################################

DIR=/opt/eos-jungle-testnet/JungleTestnet-eoscityio123

    if [ -f $DIR"/nodeos.pid" ]; then
        pid=$(cat $DIR"/nodeos.pid")
        echo $pid
        kill $pid
        rm -r $DIR"/nodeos.pid"

        echo -ne "Stoping Nodeos"

        while true; do
            [ ! -d "/proc/$pid/fd" ] && break
            echo -ne "."
            sleep 1
        done
        echo -ne "\rNodeos stopped. \n"

    fi
    
