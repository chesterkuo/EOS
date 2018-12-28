#eosio-cpp -o hi.wasm hi.cpp --abigen

#deploy
#/opt/now/Node-Manual-Installation/cleos-jungle.sh set contract hellohello22 . hi.wasm hi.abi -p hellohello22@active

#/opt/now/Node-Manual-Installation/cleos-jungle.sh set account permission hellohello22 active EOS6s7oyeSNxUcWLysZQUEh7uKQPKyUwoJBN9bTfPZa9zGB9wJr8W owner -p hellohello22@owner
# permission
#/opt/now/Node-Manual-Installation/cleos-jungle.sh set account permission hellohello22 newperm '{"threshold":1,"keys":[{"keys":"EOS6s7oyeSNxUcWLysZQUEh7uKQPKyUwoJBN9bTfPZa9zGB9wJr8W","weight":1}],"accounts":[{"permission":{"actor":"hellohello22","permission":"eosio.code"},"weight":1}]}' active -p hellohello22@active

#Test
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohello22 hito '[]' -p hellohello22@owner
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohello22 hito '[]' -p hellohellohi@active
