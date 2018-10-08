API=${1:-http://localhost:8888}
ACCOUNT=eoscityioeos
cleos -u $API push action $ACCOUNT setplan '{"price": "0.1000 EOS", "cpu": "0.5000 EOS", "net": "0.0000 EOS", "duration": 360, "is_free": true}' -p $ACCOUNT 
cleos -u $API push action $ACCOUNT setplan '{"price": "0.5000 EOS", "cpu": "50.0000 EOS", "net": "0.0000 EOS", "duration": 10080, "is_free": false}' -p $ACCOUNT 
cleos -u $API push action $ACCOUNT setplan '{"price": "1.0000 EOS", "cpu": "110.0000 EOS", "net": "0.0000 EOS", "duration": 10080, "is_free": false}' -p $ACCOUNT 
cleos -u $API push action $ACCOUNT setplan '{"price": "2.0000 EOS", "cpu": "240.0000 EOS", "net": "0.0000 EOS", "duration": 10080, "is_free": false}' -p $ACCOUNT 
cleos -u $API push action $ACCOUNT activateplan '{"price": "0.1000 EOS", "is_active": true}' -p $ACCOUNT 
cleos -u $API push action $ACCOUNT activateplan '{"price": "0.5000 EOS", "is_active": true}' -p $ACCOUNT 
cleos -u $API push action $ACCOUNT activateplan '{"price": "1.0000 EOS", "is_active": true}' -p $ACCOUNT 
cleos -u $API push action $ACCOUNT activateplan '{"price": "2.0000 EOS", "is_active": true}' -p $ACCOUNT 
