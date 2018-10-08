#!/bin/bash

ACCOUNT=$1
PKEY=${2:-EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV}
PERM_ACCOUNT=${3:-eoscityioeos}
PERMISSION=${4:-eosio.code}
API=${5:-http://localhost:8888}

CLEOS=/opt/eos-jungle-testnet/JungleTestnet-eoscityio123/cleos.sh

$CLEOS set account permission $ACCOUNT bankperm '{"threshold": 1,"keys": [{"key": "'$PKEY'","weight": 1}],"accounts": [{"permission":{"actor":"'$PERM_ACCOUNT'","permission":"'$PERMISSION'"},"weight":1}]}'  "active" -p $ACCOUNT@active
$CLEOS set action permission $ACCOUNT eosio.token transfer bankperm -p $ACCOUNT@active
$CLEOS set action permission $ACCOUNT eosio delegatebw bankperm -p $ACCOUNT@active
$CLEOS set action permission $ACCOUNT eosio undelegatebw bankperm -p $ACCOUNT@active
$CLEOS set action permission $ACCOUNT eoscityioeos expireorder bankperm -p $ACCOUNT@active
$CLEOS set action permission $ACCOUNT eoscityioeos check bankperm -p $ACCOUNT@active
