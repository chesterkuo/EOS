## based on idea https://github.com/eosrio/eos-price-oracle

$ /opt/eos-jungle-testnet/cleos.sh get table eoscityiobak eoscityiobak ticker
{
  "rows": [{
      "ticker_name": "eosusdt",
      "exchanges": [{
          "exchange_name": "binance",
          "exchange_price": "5.32350000000000012"
        },{
          "exchange_name": "bitfinex",
          "exchange_price": "5.31890000000000018"
        },{
          "exchange_name": "huobi",
          "exchange_price": "5.32559999999999967"
        },{
          "exchange_name": "okex",
          "exchange_price": "5.32680000000000042"
        }
      ],
      "avg_price": "5.32370000000000054",
      "timestamp": "Fri, 02 Nov 2018 07:42:46 GMT"
    }
  ],
  "more": false
}
