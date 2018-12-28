/*
 * eosiolib/contract.hpp , define _code
*/

#include<eosiolib/eosio.hpp>
#include<eosiolib/dispatcher.hpp>

using namespace eosio;


class [[eosio::contract]] hello: eosio::contract {
public:
    using eosio::contract::contract;
    [[eosio::action]] void hi(){
        print(",  "); 
        print("_code id in hi:");
        print(_code);
        print(",  "); 
        print("_self id in hi:");
        print(_self);
        print("  ");
    }

    [[eosio::action]] void hito(){
        print(",  "); 
        print("_code id in hito:");
        print(_code);
        print(",  "); 
        print("_self id in hito:");
        print(_self);
        print("  ");
    }

};

extern "C" {

void apply(uint64_t receiver, uint64_t code, uint64_t action) {
    print("in apply,code is:");
    print(name{code});
    print("    ");
    print("in apply,receiver is:");
    print(name{receiver});

    if (code == receiver) {
        switch (action) {
            EOSIO_DISPATCH_HELPER(hello,(hi))
        }
    } else {
        if ( action == "hito"_n.value) {
            eosio::execute_action(eosio::name(receiver), eosio::name(code), &hello::hito);
            return;
        }
        eosio::execute_action(eosio::name(receiver), eosio::name(code), &hello::hi);
    }
    eosio_exit(0);
}
}
