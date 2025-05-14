# 📘 Move Language Module: Admin Settings

Welcome to this module on **Admin Settings in Move**!  
In this lesson, we explore how to use **resources**, **vectors**, **strings**, and **signer-based access control** to manage settings in a secure and structured way.

---

## ✅ Learning Objectives

- Understand how to define structs with `store`, `key`, `drop` abilities
- Use `signer` for admin-only access control
- Work with `vector` and `string` modules
- Mutate global state using `borrow_global_mut`
- Write and run tests using `#[test]` and `aptos move test`

---

## 🧱 Structs

```move
struct Settings has key {
    admin: address,
    spill: String,
    users: vector<User>
}

struct User has store, drop {
    first_name: String,
    last_name: String,
}
```

- Settings stores the admin address, a text message (spill), and a list of Users.
- User holds individual names.

## ⚠️ Error Codes

`const E_SIGNER_NOT_ADMIN: u64 = 1;`

Used to restrict non-admin actions:

## 🚀 Entry Functions

`set_spill(admin: &signer, spill: String)`

Sets a new spill message (admin-only).

`push_user(admin: &signer, first_name: String, last_name: String)`

Adds a new user to the list.

`pop_user(admin: &signer)`

Removes the last user if the list is not empty.

`set_admin(admin: &signer, new_admin: address)`

Transfers admin privileges to a new address.

## 🧪 Testing the Module

`Use` the #[test] attribute and a hardcoded deployer address.`

To run all tests:
`aptos move test`

## 💡 Example Usage

```move
push_user(&admin_signer, string::utf8(b"Alice"), string::utf8(b"Smith"));
pop_user(&admin_signer);
set_spill(&admin_signer, string::utf8(b"Updated!"));
```

## 📚 Summary

**Structs**: `Settings`, `User`

**Concepts**: signer-based access control, mutation with `borrow_global_mut`, error handling with assert!

**Data Types Used**: `address`, `String`, `vector<T>`

**Testing**: Inline unit tests using `#[test]`

## 📖 Recommended Reading

- [Structs & Abilities](https://aptos.dev/en/build/smart-contracts/book/resources#abilities)
- [Signer & Access Control](https://aptos.dev/en/build/smart-contracts/book/signer/)
- [Vector Module](https://aptos.dev/en/build/smart-contracts/book/vector#operations)
- [References & Mutation](https://aptos.dev/en/build/smart-contracts/book/references)
- [Testing in Move](https://aptos.dev/en/build/move/move-cli/testing/)
