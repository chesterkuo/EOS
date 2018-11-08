#include <eosiolib/eosio.hpp>
#include <eosiolib/name.hpp>
#include <eosiolib/transaction.hpp>
#include <eosiolib/print.hpp>
#include <vector>

using namespace eosio;
using namespace std;

CONTRACT price_oracle : public eosio::contract {
    public:
        using contract::contract;
        price_oracle(name self, name code, datastream<const char*> ds) : contract(self, code, ds) {}
        
        [[eosio::action]]
        void createticker(name user, name ticker_name, vector<string> exchanges) {
            require_auth(user);

            ticker_index tickers(_self, _self.value);
            uint64_t ticker_name_index = ticker_name.value;
            auto itr = tickers.find(ticker_name_index);

            eosio_assert(itr == tickers.end(), "Ticker already exists!");

            tickers.emplace(_self, [&](auto& t) {
                //t.id = tickers.available_primary_key();
                t.ticker_name = ticker_name;

                for (int i = 0; i < exchanges.size(); ++i) {
                    exchange ex {exchanges[i], 0.0};
                    t.exchanges.push_back(ex);
                }

                t.avg_price = 0.0;
                t.timestamp = "";
            });
            send_log(user, " Add new ticker successfully");
            send_out(user, " Send log to external contract");
        }

        /*
        [[eosio::action]]
        void updateticker(name ticker_name, vector<string> exchanges) {
            require_auth(_self);

            ticker_index tickers(_self, _self.value);
            uint64_t ticker_name_index = ticker_name.value;
            auto itr = tickers.find(ticker_name_index);

            eosio_assert(itr != tickers.end(), "Ticker not found!");

            tickers.modify(itr, _self, [&](auto& t) {
                t.exchanges.clear();

                for (int i = 0; i < exchanges.size(); ++i) {
                    exchange ex {exchanges[i], 0.0};
                    t.exchanges.push_back(ex);
                }
            });

        }
        */

        [[eosio::action]]
        void deleteticker(name ticker_name ) {
            require_auth(_self);

            ticker_index tickers(_self, _self.value);

            uint64_t ticker_name_index = ticker_name.value;
            auto itr = tickers.find(ticker_name_index);
            eosio_assert(itr != tickers.end(), "Ticker not found!");
            tickers.erase(itr);

            send_log(get_self(), " Delete ticker successfully");
            //send_deferred(user, "Deferred delete message", 1);
        }

        [[eosio::action]]
        void update(name ticker_name, vector<double> prices, double avg_price, string timestamp) {
            require_auth(_self);

            ticker_index tickers(_self, _self.value);
            uint64_t ticker_name_index = ticker_name.value;
            auto itr = tickers.find(ticker_name_index);
            eosio_assert(itr != tickers.end(), "Ticker not found!");

            eosio_assert(prices.size() <= itr->exchanges.size(), "Wrong values size");

            tickers.modify(itr, _self, [&](auto& p) {
                for (int i = 0; i < prices.size(); ++i) {
                    p.exchanges[i].exchange_price = prices[i];
                }

                p.avg_price = avg_price;
                p.timestamp = timestamp;
            });
        }

        [[eosio::action]]
        void notify(name user, std::string message) {
            print( "Notify....", name{user} );
            require_auth(get_self());
            require_recipient(user);
        }
       
    private:
        struct exchange {
            string exchange_name;
            double exchange_price;
        };

        TABLE ticker {
            name ticker_name;
            vector<exchange> exchanges;
            double avg_price;
            string timestamp;

            uint64_t primary_key() const {return ticker_name.value;}
            //uint64_t get_ticker() const { return ticker_name.value;}
        };

        typedef multi_index<"ticker"_n, ticker> ticker_index;
        //typedef multi_index<"tickerid"_n, ticker, indexed_by<"ticker"_n, const_mem_fun<ticker, uint64_t, &ticker::get_ticker>>> ticker_2_index;

        // Execute inline action
        // action({permission_level}, {contract_deployer}, {contract_action}, {data_to_pass}).send();
        void send_log(name user, std::string log) {
            action(
              permission_level{get_self(),"active"_n},
              get_self(),
              "notify"_n,
              std::make_tuple(user, name{user}.to_string() + log)
            ).send();
        };
        
        // Execute inline action from other contract
        void send_out(name user, std::string log) {
           action(
              permission_level{get_self(),"active"_n},
              "eoscityiocnt"_n,
              "count"_n,
              std::make_tuple(user, log)
            ).send();
        }
        
        // Execute deferred transaction
        void send_deferred(name user, std::string msg, uint64_t index) {
           eosio::transaction tx;
           tx.actions.emplace_back(
              permission_level{get_self(),"active"_n},
              get_self(),
              "notify"_n,
              std::make_tuple(user, name{user}.to_string() + msg)
           );
           tx.delay_sec = 5;
           tx.send(index, "eoscityiobak"_n );
        }

};

EOSIO_DISPATCH(price_oracle, (createticker)(deleteticker)(update)(notify))
