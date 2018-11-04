#!/bin/bash

SYMBOL="EOSTW"
SNAPSHOT_FILE="test_snapshot.csv"
TOKENWAS=/opt/eos-1.4.1-src/eos/build/contracts/eosio.token
ISSUER="eostw1eostw1"
#Public key	EOS5H1XELrBebS1S3nEVS27WdGCr4LbCDgFFxXVF22HrNZSFJJsk5	
#Private key	5Hxoa6zoWNXPHrR6tw5cH41h7ypyvdY2hr3JtR6gdcHRZkbSrhs
MYCLEOS="cleos -u http://127.0.0.1:8888 --wallet-url http://127.0.0.1:55553"


# 1) make sure the wallet was unlock
# 2) 200kbytes ram need for eosio.token contract
#    /opt/eos-jungle-testnet/cleos.sh system buyram eostw1eostw1 eostw1eostw1 --kbytes 200

echo "Deploy Token contract"
DEPLOY=`$MYCLEOS  set contract $ISSUER $TOKENWAS`
RST=$?
echo "return $RST"
if [[ $RST == 0 ]]; then
    echo "Success"
else
    echo "Failure"
    exit
fi


echo "Creating token..."
CREATED=`$MYCLEOS get table $ISSUER $SYMBOL stat | grep $SYMBOL`
if [[ -z $CREATED ]]; then
    echo "Creating Token now..."
    $MYCLEOS push action $ISSUER create "[\"$ISSUER\", \"100000000000.000 $SYMBOL\"]" -p $ISSUER@active
else
    echo "Token exists. Skipping create"
fi

ISSUANCE=`$MYCLEOS get table $ISSUER $ISSUER accounts | grep $SYMBOL`
if [[ -z $ISSUANCE ]]; then
    echo "Issuing..."
    $MYCLEOS push action $ISSUER issue "[\"$ISSUER\", \"10000000000.000 $SYMBOL\", \"initial supply\"]" -p $ISSUER@active
else
    echo "Token already issued. Skipping issue"
fi

for line in $(cat $SNAPSHOT_FILE); do
    ACCOUNT=$(echo $line | tr "," "\n" | head -2 | tail -1)
    AMOUNT=$(echo $line | tr "," "\n" | tail -1)
    CURRENT_BALANCE=$(cleos get table $ISSUER $ACCOUNT accounts | grep $SYMBOL) 
    if [[ -z $CURRENT_BALANCE ]]; then
        echo "Airdropping $AMOUNT $SYMBOL to $ACCOUNT"
        $MYCLEOS push action $ISSUER transfer "[\"$ISSUER\", \"$ACCOUNT\", \"$AMOUNT $SYMBOL\", \"airdrop\"]" -p $ISSUER@active
    else
        echo "Skipping $ACCOUNT"
    fi 
done

