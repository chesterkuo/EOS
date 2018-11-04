
## Generating a snapshot. 

The `snapshot_generator.py` script generates an airdrop snapshot from the EOS genesis snapshot. If you wish to use some other base snapshot than the EOS genesis snapshot, swap out the `eos_snapshot.csv` file with your custom snapshot. 

The script requires Pandas, so install that with:

```py
pip install pandas
```

There are a couple configs you will have to modify before running the script. Open the script, at the top you will see the following:

```py
DECIMAL_PRECISION=3
EOS_SNAPSHOT_FILE='eos_snapshot.csv'
TOKEN_MULTIPLIER=5.1 # How many airdropped tokens to send per EOS
OUTPUT_FILE='iq_snapshot.csv'
USE_BLACKLIST=True
```

The default settings are the settings for the IQ airdrop. You will likely have to modify the `TOKEN_MULTIPLIER` and `OUTPUT_FILE` at minimum. 

The blacklist contains a series of exchange addresses that specifically have not announced support for the Everipedia IQ airdrop. The addresses are contained in `blacklist.txt`. You can modify that file to use your own blacklist or set `USE_BLACKLIST=False`.

The whitelist (`whitelist.txt`) is a separate list that contains a series of exchange addresses that have announced support for the IQ airdrop. The only purpose of the whitelist is to verify that none of the whitelisted addresses are in the blacklist. If there are, the script will throw an error. 

To run the snapshot generator:

```py
python snapshot_generator.py
```

The airdrop snapshot will be saved to `OUTPUT_FILE`

