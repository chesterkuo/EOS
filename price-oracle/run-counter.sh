

#eoscityiocnt
# pubkey EOS7YTjejVNCd5VfKPHVXbZ7FUSq1sT2nixTFdnWiRzeixkTZ2o66
# private 5JB4zn6HsNbBEieBQVw6gZFHhaA9TaTuYSWFLP4283gRDvoHWqL 
# /opt/eos-jungle-testnet/cleos.sh set account permission eoscityiocnt active '{"threshold": 1,"keys": [{"key": "EOS7YTjejVNCd5VfKPHVXbZ7FUSq1sT2nixTFdnWiRzeixkTZ2o66","weight# ": 1}], "accounts": [# {"permission":{"actor":"eoscityiocnt","permission":"eosio.code"},"weight":1}]}' -p eoscityiocnt@owner

eosio-cpp -abigen price_counter.cpp -o price_counter.wasm
/opt/eos-jungle-testnet/cleos.sh set contract eoscityiocnt . price_counter.wasm price_counter.abi
/opt/eos-jungle-testnet/cleos.sh get table eoscityiocnt eoscityiocnt counts

# /opt/eos-jungle-testnet/cleos.sh push action eoscityiocnt keydelete '["eosioalice22"]' -p eoscityiobak@owner
