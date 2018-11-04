import pandas as pd

DECIMAL_PRECISION=3
EOS_SNAPSHOT_FILE='eos_snapshot.csv'
TOKEN_MULTIPLIER=5.1 # How many airdropped tokens to send per EOS
OUTPUT_FILE='test_snapshot.csv'
USE_BLACKLIST=True

df = pd.read_csv(EOS_SNAPSHOT_FILE, header=None)
df[4] = df[3] * TOKEN_MULTIPLIER

# Blacklist 
with open('blacklist.txt', 'r') as f:
    blacklist = f.read()
with open('whitelist.txt', 'r') as f:
    whitelist = f.read()
blacklist = [line.strip() for line in blacklist.split('\n') if line is not '' and line[0] is not '#']
whitelist = [line.strip() for line in whitelist.split('\n') if line is not '' and line[0] is not '#']
intersection = [pubkey for pubkey in whitelist if pubkey in blacklist]
assert len(intersection) == 0, "No keys in the whitelist should be in the blacklist: {0}".format(intersection)
df = df[~df[2].isin(blacklist)]

# Decimal precision
df[4] = df[4].map(lambda x: '{0:.3f}'.format(x))
df[3] = df[3].map(lambda x: '{0:.4f}'.format(x))

df.to_csv(OUTPUT_FILE, index=False, header=False)
