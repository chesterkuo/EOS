#eosio-cpp -o hi.wasm hi.cpp --abigen

#deploy
#/opt/now/Node-Manual-Installation/cleos-jungle.sh set contract hellohello22 . hi.wasm hi.abi -p hellohello22@active



# delete per
# /opt/now/Node-Manual-Installation/cleos-jungle.sh set account permission hellohello22 newperm null active

# permission
#/opt/now/Node-Manual-Installation/cleos-jungle.sh set account permission hellohello22 active --add-code

#Test
echo "hellohello22 with hito"
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohello22 hito '[]' -p hellohello22@active
echo "hellohello22 with hello"
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohello22 hello '[]' -p hellohello22@active

echo "hellohellohi with hito"
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohello22 hito '[]' -p hellohellohi@active
echo "hellohellohi with hello"
/opt/now/Node-Manual-Installation/cleos-jungle.sh push action hellohello22 hello '[]' -p hellohellohi@active
