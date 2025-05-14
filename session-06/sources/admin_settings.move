module admin_settings_addr::admin_settings {
    use std::string::{Self, String};
    use std::signer;
    use std::vector;

    struct Settings has key {
        admin: address,
        spill: String,
        users: vector<User>
    }

    struct User has store, drop {
        first_name: String,
        last_name: String,
    }

    const E_SIGNER_NOT_ADMIN: u64 = 1;

    fun init_module(deployer: &signer) {
        let admin_addr = signer::address_of(deployer);
        move_to(deployer, Settings {
            admin: admin_addr,
            spill: string::utf8(b"Hello World"),
            users: vector[]
        })
    }

    public entry fun set_spill(admin: &signer, spill: String) acquires Settings {
        let admin_addr = signer::address_of(admin);
        let settings = borrow_global_mut<Settings>(@admin_settings_addr);
        assert!(settings.admin == admin_addr, E_SIGNER_NOT_ADMIN);
        settings.spill = spill;
    }

    public entry fun push_user(admin: &signer, first_name: String, last_name: String) acquires Settings {
        let admin_addr = signer::address_of(admin);
        let settings = borrow_global_mut<Settings>(@admin_settings_addr);
        assert!(settings.admin == admin_addr, E_SIGNER_NOT_ADMIN);

        let user = User {
            first_name,
            last_name
        };

        vector::push_back(&mut settings.users, user);
    }

    public entry fun pop_user(admin: &signer) acquires Settings {
        let admin_addr = signer::address_of(admin);
        let settings = borrow_global_mut<Settings>(@admin_settings_addr);
        assert!(settings.admin == admin_addr, E_SIGNER_NOT_ADMIN);

        if(vector::length(&settings.users) != 0) {
            vector::pop_back(&mut settings.users);
        }

    }

    public entry fun set_admin(admin: &signer, new_admin: address) acquires Settings {
        let admin_addr = signer::address_of(admin);
        let settings = borrow_global_mut<Settings>(@admin_settings_addr);
        assert!(settings.admin == admin_addr, E_SIGNER_NOT_ADMIN);

        settings.admin = new_admin;

    }

    #[test(deployer = @admin_settings_addr)]
    fun test_function_init(deployer: signer) {
        init_module(&deployer);
    }

    #[test(deployer = @admin_settings_addr)]
    fun test_function_set_spill(deployer: signer) acquires Settings {
        init_module(&deployer);
        set_spill(&deployer, string::utf8(b"Test"));
    }

    #[test(deployer = @admin_settings_addr)]
    fun test_function_push_user(deployer: signer) acquires Settings {
        init_module(&deployer);
        push_user(&deployer, string::utf8(b"John"), string::utf8(b"Doe"));
    }

    #[test(deployer = @admin_settings_addr)]
    fun test_function_pop_user(deployer: signer) acquires Settings {
        init_module(&deployer);
        push_user(&deployer, string::utf8(b"John"), string::utf8(b"Doe"));
        pop_user(&deployer);
    }

    #[test(deployer = @admin_settings_addr, new_admin = @0x123)]
    fun test_function_set_admin(deployer: signer, new_admin: signer) acquires Settings {
        init_module(&deployer);
        push_user(&deployer, string::utf8(b"John"), string::utf8(b"Doe"));
        pop_user(&deployer);

        let new_admin_addr = signer::address_of(&new_admin);

        set_admin(&deployer, new_admin_addr);
        push_user(&new_admin, string::utf8(b"John"), string::utf8(b"Doe"));
        pop_user(&new_admin);
    }
}