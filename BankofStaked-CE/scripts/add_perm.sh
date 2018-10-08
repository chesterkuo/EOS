#!/bin/bash

ACCOUNT=$1
PKEY=${2:-EOS5DyqsEjZeukx5xJdcdowP77YuwAZ5hZ1pDs6TzPymDzYcZV31b}
PERM_ACCOUNT=${3:-eoscityioeos}
PERMISSION=${4:-eosio.code}
API=${5:-http://localhost:8888}
CLEOS=/opt/eos-jungle-testnet/JungleTestnet-eoscityio123/cleos.sh

$CLEOS set account permission $ACCOUNT creditorperm '{"threshold": 1,"keys": [{"key": "'$PKEY'","weight": 1}],"accounts": [{"permission":{"actor":"'$PERM_ACCOUNT'","permission":"'$PERMISSION'"},"weight":1}]}'  "active" -p $ACCOUNT@active
$CLEOS set action permission $ACCOUNT eosio delegatebw creditorperm -p $ACCOUNT@active
$CLEOS set action permission $ACCOUNT eosio undelegatebw creditorperm -p $ACCOUNT@active
