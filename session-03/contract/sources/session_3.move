module data_struct_addr::data_struct {
    use std::debug::print;
    use std::vector;
    use std::string::utf8;

    const MAX_SUPPLY: u64 = 5000;


    fun simple_function() {
        let uint_example = 15;
        print(&uint_example);

        let uint_example_2: u8 = 255;
        print(&uint_example_2);

        let true_value: bool = true;
        let false_value: bool = false;

        print(&true_value);
        print(&false_value);

        let address_example: address = @0x1234;
        print(&address_example);

        // printing reference_example will display 15
        let reference_example = uint_example;
        print(&reference_example);

        // vectors, homogenous collection of data
        let my_vector = vector::empty<u64>();
        print(&my_vector);
        vector::push_back(&mut my_vector, 10);
        vector::push_back(&mut my_vector, 20);
        vector::push_back(&mut my_vector, 30);
        print(&my_vector);

        let nft_collection_name = utf8(b"Bored Ape");
        print(&nft_collection_name);

        // let string_example_2: vector<u8> = utf8(b"Bored Ape 2");
        // print(&string_example_2);
    }

    #[test]
    fun test_data_structure() {
        simple_function();
    }

}