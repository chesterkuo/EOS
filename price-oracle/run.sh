

#eoscityiobak
eosio-cpp -abigen price_oracle.cpp -o price_oracle.wasm

# Due to security reasons, the release version of EOS now requires the eosio.code permission on the contract invoking an inline action.
# add permission in order to send inline action
# /opt/eos-jungle-testnet/cleos.sh set account permission eoscityiobak active '{"threshold": 1,"keys": [{"key": "EOS6QCc7maHCvmHcuv8dE159z8yttuTCcctVqZo7v
# q1LtJiyMELzH","weight": 1}], "accounts": [{"permission":{"actor":"eoscityiobak","permission":"eosio.code"},"weight":1}]}' -p eoscityiobak@owner

/opt/eos-jungle-testnet/cleos.sh set contract eoscityiobak . price_oracle.wasm price_oracle.abi
/opt/eos-jungle-testnet/cleos.sh get table eoscityiobak eoscityiobak ticker

# /opt/eos-jungle-testnet/cleos.sh push action eoscityiobak createticker '["eosioalice22", "eosusdt",["binance","bitfinex","huobi","okex"]]' -p eosioalice22@active
# /opt/eos-jungle-testnet/cleos.sh push action eoscityiobak deleteticker '{"ticker_name":"eosusdt"}' -p eoscityiobak@active
