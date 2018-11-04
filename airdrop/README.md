
## Deploying the Contract

Before running the airdrop, you must deploy the `eosio.token` contract to your account.


## Airdropping

The deployment script (`deploy-token.sh`) contains a couple settings that need to be modified.

```bash
SYMBOL="EOSTW"
ISSUER="eostw1eostw1"
SNAPSHOT_FILE="test_snapshot.csv"
```

The `SYMBOL` is the symbol of the asset that will be used on-chain. A `SYMBOL` can only be used once per contract, so if you want to re-use a symbol that you have already created, you will have to re-deploy the contract to a different account. 

The `ISSUER` should be the same as the `ISSUER` account you deployed the contract to. 

The `SNAPSHOT_FILE` should match the `OUTPUT_FILE` from `snapshot_generator.py`


```bash
./deploy-token.sh
```


The airdrop consumes the following EOS system resources. Make sure you have enough EOS staked for RAM, NET, and CPU before airdropping:

