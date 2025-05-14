module data_struct_addr::demo_public {
    friend data_struct_addr::data_struct;

    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    friend fun difference(a: u64, b: u64): u64 {
        a - b
    }
}
