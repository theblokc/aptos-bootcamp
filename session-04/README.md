# 📘 Move Language Module: Admin Settings

Welcome to this module on **Resource-Based Accounts in Move**!  
In this lesson, we explore how to use **resources**, **signers**, **conditionals**, and **string manipulation** to create and manage user profile data securely.

---

## ✅ Learning Objectives

- ✅ Resource definition with `has key`
- ✅ Conditional creation or update
- 🔍 Read functions (views)
- 🧪 Unit test with debug prints

---

## 🧱 Structs

```move
struct Account has key {
    first_name: String,
    last_name: String
}
```

- `Account` is stored under a user’s address and holds basic profile information.
- This resource allows `personal data binding` directly to user accounts.

## 🚀 Entry Functions

`set_account(user_signer: &signer, first_name: String, last_name: String)`

Creates or updates the Account resource at the caller's address:

- If the resource `exists`, it mutates the fields.
- If it `doesn't exist`, it initializes and stores it using `move_to`.

## 🔍 View Functions

```move
get_first_name(user_addr: address): String
get_last_name(user_addr: address): String

```

- These `#[view]` functions allow read-only access to the `Account` data.
- They do not require a signer and are safe to use from frontend UIs or explorers.

## 🧪 Testing the Module

To run all tests:
`aptos move test`

## 💡 Example Usage

```move
set_account(&signer, string::utf8(b"Renzo"), string::utf8(b"Cabarios"));
let fname = get_first_name(@0x123);
let lname = get_last_name(@0x123);
```

## 📚 Summary

**Structs**: `Account`

**Concepts**:

- Resource-based user data
- Conditional creation using `exists`
- Mutation using `borrow_global_mut`
- Read-only access via view functions

**Data Types Used**: `address`, `String`

**Testing**: Inline `#[test]` with debug printing

## 📖 Recommended Reading

- [Structs & Abilities](https://aptos.dev/en/build/smart-contracts/book/resources#abilities)

- [Signer & Access Control](https://aptos.dev/en/build/smart-contracts/book/signer/)

- [Vector Module](https://aptos.dev/en/build/smart-contracts/book/vector#operations)

- [References & Mutation](https://aptos.dev/en/build/smart-contracts/book/references)

- [Testing in Move](https://aptos.dev/en/build/move/move-cli/testing/)

- [Strings in Move](https://aptos.dev/en/build/smart-contracts/book/string/)
