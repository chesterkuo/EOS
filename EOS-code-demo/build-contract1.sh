eosio-cpp -o hello.wasm hello.cpp --abigen

#deploy
/opt/now/Node-Manual-Installation/cleos-jungle.sh set contract hellohellohi . hello.wasm hello.abi -p hellohellohi@active

#Test
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohellohi hi '[]' -p hellohellohi@active
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohellohi hi '[]' -p eoscityio123@active
