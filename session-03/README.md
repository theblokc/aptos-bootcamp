# 📘 Move Language Module: Data Structures

Welcome to this module on **Data Structures in Move**! In this lesson, we will explore both **primitive** and **non-primitive** data types, how to declare them, and how they are used in practice with examples.

---

## Learning Objectives

By the end of this module, you should be able to:

- Understand and use primitive data types in Move
- Understand and use non-primitive data types like vectors and strings
- Write functions using `let` and `const`
- Apply type annotations explicitly
- Test your code using `#[test]` and the `aptos move test` command

---

## Variable Declaration

In Move, variables can be declared using:

```move
let variable_name = value;        // mutable by default
let variable_name: type = value;  // explicit type
const CONSTANT_NAME: type = value;
```

---

## Primitive Data Types

These are the most basic types in Move:

| Type         | Description                        |
|--------------|------------------------------------|
| `u8`, `u64`, `u...`  | Unsigned integers of different sizes |
| `bool`       | Boolean values: `true` or `false`  |
| `address`    | 16-byte account addresses          |
| `unit`       | Represents no value (like `()` in Rust) |
| `tuple`      | A group of multiple values         |

### Example Usage:

```move
let uint_example = 15;
let uint_example_2: u8 = 255;
let true_value: bool = true;
let address_example: address = @0x1234;
```

You can also **assign one variable to another** (by value). This is immutable and you can't change the uint_example through reference example:

```move
let reference_example = uint_example; // Copies value
```

---

## Non-Primitive Data Types

###  Vectors

Vectors are growable collections of the **same type**:

```move
let my_vector = vector::empty<u64>();
vector::push_back(&mut my_vector, 10);
vector::push_back(&mut my_vector, 20);
vector::push_back(&mut my_vector, 30);
```

> 🔹 Don't forget: You must import the `std::vector` module to use vectors.

###  Strings

Strings are handled using `utf8` from `std::string`:

```move
let nft_collection_name = utf8(b"Bored Ape");
```

> Note: `utf8` takes a **byte string** (`b""`) and converts it into a UTF-8 string.

---

##  Testing Your Module

Use the `#[test]` attribute to define test functions:

```move
#[test]
fun test_data_structure() {
    simple_function();
}
```

Then run your tests with:

```bash
aptos move test
```

---

## Full Example Code

```move
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

        let reference_example = uint_example;
        print(&reference_example);

        let my_vector = vector::empty<u64>();
        print(&my_vector);
        vector::push_back(&mut my_vector, 10);
        vector::push_back(&mut my_vector, 20);
        vector::push_back(&mut my_vector, 30);
        print(&my_vector);

        let nft_collection_name = utf8(b"Bored Ape");
        print(&nft_collection_name);
    }

    #[test]
    fun test_data_structure() {
        simple_function();
    }
}
```

---

## Summary

- **Primitive Types:** `u8`, `u64`, `bool`, `address`
- **Non-Primitive Types:** `vector`, `string`
- Used `let`, `const`, and type annotations
- Demonstrated how to write and test Move code

---

## Recommended Readings

To deepen your understanding, check out the official Move Book sections:

- [Integer Operations](https://aptos.dev/en/build/smart-contracts/book/integers#operations)
- [Boolean Operations](https://aptos.dev/en/build/smart-contracts/book/bool#operations)
- [Tuple Operations](https://aptos.dev/en/build/smart-contracts/book/tuples#operations)
- [Vector Operations](https://aptos.dev/en/build/smart-contracts/book/vector#operations)
- [Reading and Writing Through References](https://aptos.dev/en/build/smart-contracts/book/references#reading-and-writing-through-references)

---

Happy coding in Move! 

