
#include<eosiolib/eosio.hpp>
#include<eosiolib/action.hpp>

using namespace std;
using namespace eosio;


class [[eosio::contract]] hi: eosio::contract {
public:
    using eosio::contract::contract;
    [[eosio::action]] void hello(){
        action(
            permission_level(_self,"active"_n),
            "hellohellohi"_n,
            "hi"_n,
            std::make_tuple()
        ).send();
    }

    [[eosio::action]] void hito(){
        require_recipient("hellohellohi"_n);
    }
};

EOSIO_DISPATCH(hi,(hello)(hito))
