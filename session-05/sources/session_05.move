module data_struct_addr::data_struct {
    use std::debug::print;
    use std::vector;
    use std::signer;
    use std::string::utf8;
    use data_struct_addr::demo_public;
    
    const MAX_SUPPLY: u64 = 5000;

    struct WhiteListed has key {
        whitelisted: vector<address>
    }


    fun simple_function_2() {
        let a = 102;
        let b = 200;

        if (a < 100) {
            print(&a);
        } else if (a > 100) {
            print(&b);
        } else {
            let done_message = utf8(b"done message");
            print(&done_message);

        };

        let c = if (a > 100) true else false;
        print(&c);
    }

    fun simple_function_3() {
        let a = 1;
        while (a < 30) {
            a += 1;
            print(&a);
        };

        let b = 1;
        loop {
            print(&b);
            b += 1;

            if (b == 31) {
                break;
            };
        };

        for (i in  1..101) {
            print(&i);
        };
    }

    fun sample_function_4(){
        let a = 30;
        let b = 20;
        let sum = demo_public::add(a,b);
        let diff = demo_public::difference(a,b);
        print(&sum);
        print(&diff);
    }

    fun init_module(user: &signer) acquires WhiteListed{
        let whitelisted = vector::empty<address>();

        move_to(user, WhiteListed {
            whitelisted: whitelisted,
        });

        let whitelisted = borrow_global_mut<WhiteListed>(@data_struct_addr);
        vector::push_back(&mut whitelisted.whitelisted, signer::address_of(user));
    }

    public entry fun add_address(addr: address)  acquires WhiteListed {
        let whitelisted = borrow_global_mut<WhiteListed>(@data_struct_addr);
        vector::push_back(&mut whitelisted.whitelisted, addr);
    }

    #[view]
    public fun view_whitelisted(): vector<address> acquires WhiteListed {
        let whitelisted = borrow_global<WhiteListed>(@data_struct_addr);
        whitelisted.whitelisted
    }

    #[test(user=@0x123)]
    fun test_data_structure(user: signer)  {
        // init_module(&user);
        simple_function_2();
        simple_function_3();
        sample_function_4();
    }

}
