module resource_creator_addr::resource_creator {
    use std::signer;
    use std::string::{Self, String};

    struct Account has key {
        first_name: String,
        last_name: String
    }

    public entry fun set_account(user_signer: &signer, first_name: String, last_name: String) acquires Account {
        let wallet_address = signer::address_of(user_signer);
        if(exists<Account>(wallet_address)) {
            let account = borrow_global_mut<Account>(wallet_address);
            account.first_name = first_name;
            account.last_name = last_name;
        } else {

            let account = Account {
                first_name,
                last_name
            };
            move_to(user_signer, account);
        }
    }

    #[view]
    public fun get_first_name(user_addr: address): String acquires Account{
        borrow_global<Account>(user_addr).first_name
    }

    #[view]
    public fun get_last_name(user_addr: address): String acquires Account{
        borrow_global<Account>(user_addr).last_name
    }


    #[test_only]
    use std::debug;

    #[test(user=@0x123)]
    fun test_create_account(user: signer) acquires Account {
        set_account(&user, string::utf8(b"John"), string::utf8(b"Doe"));

        let user_addr = signer::address_of(&user);

        let first_name = get_first_name(user_addr);
        let last_name = get_last_name(user_addr);
        
        debug::print(&first_name);
        debug::print(&last_name);
    }
}