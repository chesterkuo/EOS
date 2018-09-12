#!/bin/bash
################################################################################
#
# Scrip Created by http://CryptoLions.io
# For EOS Junlge testnet
#
# https://github.com/CryptoLions/
#
################################################################################

./cleos.sh system delegatebw eoscityio123 eoscityio123 "1000.0000 EOS" "1000.0000 EOS" -p eoscityio123
#./cleos.sh push action eosio delegatebw '{"from":"eoscityio123", "receiver":"eoscityio123", "stake_net_quantity": "1000.0000 EOS", "stake_cpu_quantity": "1000.0000 EOS", "transfer": true}' -p eoscityio123
