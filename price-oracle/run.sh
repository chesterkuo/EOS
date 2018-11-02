

#eoscityiobak
#eosio-cpp -abigen price_update.cpp -o price_update.wasm

#/opt/eos-jungle-testnet/cleos.sh set contract eoscityiobak . price_update.wasm price_update.abi

#/opt/eos-jungle-testnet/cleos.sh get table eoscityiobak eoscityiobak ticker

/opt/eos-jungle-testnet/cleos.sh push action eoscityiobak createticker '["eosusdt",["binance","bitfinex","huobi","okex"]]' -p eoscityiobak@active
#/opt/eos-jungle-testnet/cleos.sh push action eoscityiobak deleteticker '["eostest",["binance","bb"]]' -p eoscityiobak@active
