#include <eosiolib/print.hpp>
#include <eosiolib/eosio.hpp>

using namespace eosio;

class [[eosio::contract]] price_counter : public eosio::contract {
  public:
    using contract::contract;

    price_counter(name receiver, name code,  datastream<const char*> ds): contract(receiver, code, ds) {}

    [[eosio::action]]
    void keydelete(name user) {
       require_auth( name ("eoscityiobak"));
       count_index counts(_self, _self.value);
       auto itr = counts.find(user.value);
       eosio_assert(itr != counts.end(), "key not found!");
       counts.erase(itr);
    }

    [[eosio::action]]
    void count(name user, std::string type) {
      require_auth( name("eoscityiobak"));
      count_index counts(name(_code), _code.value);
      auto iterator = counts.find(user.value);

      print( "Get info from ....", name{user});
      print( "Log :", type);
      
      if (iterator == counts.end()) {
        counts.emplace("eoscityiobak"_n, [&]( auto& row ) {
          row.key = user;
          row.emplaced = (type == "emplace") ? 1 : 0;
          row.modified = (type == "modify") ? 1 : 0;
          row.erased = (type == "erase") ? 1 : 0;
        });
      }
      else {
        counts.modify(iterator, "eoscityiobak"_n, [&]( auto& row ) {
          if(type == "emplace") { row.emplaced += 1; }
          if(type == "modify") { row.modified += 1; }
          if(type == "erase") { row.erased += 1; }
        });
      }
    }

  private:
    struct [[eosio::table]] counter {
      name key;
      uint64_t emplaced;
      uint64_t modified;
      uint64_t erased;
      uint64_t primary_key() const { return key.value; }
    };

    using count_index = eosio::multi_index<"counts"_n, counter>;
};

EOSIO_DISPATCH( price_counter, (count)(keydelete));

