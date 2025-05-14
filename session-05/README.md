# 📘 Move Programming Lesson Review  
## Topic: Conditionals, Loops, and Functions (Public, Private, Friend, Entry, View)

---

## 🧠 Learning Objectives
By the end of this module, you should be able to:
- Understand how conditional logic works in Move
- Use different kinds of loops: `while`, `loop`, and `for`
- Differentiate between public, private, and friend functions
- Use entry and view functions correctly
- Initialize and manipulate Move resources

---

## 🔹 1. Conditional Statements in Move

**Purpose:** Control the flow of logic based on conditions.

### ✅ Syntax

```move
if (condition) {
    // do something
} else if (another_condition) {
    // do something else
} else {
    // default action
}
```

### ✅ Example:

```move
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
```

**💡 Notes:**
- Move supports inline `if` expressions for conditional assignments.
- Always use `utf8(b"...")` to convert byte arrays to strings for printing.

---

## 🔁 2. Loops in Move

Move provides **three kinds of loops**:

### 🔸 a. While Loop

```move
let x = 0;
while (x < 10) {
    x = x + 1;
}
```

### 🔸 b. Infinite Loop + Break

```move
let y = 0;
loop {
    y = y + 1;
    if (y == 5) break;
}
```

### 🔸 c. For Loop with Range

```move
for (i in 1..5) {
    print(&i);
}
```

### ✅ Example in `simple_function_3`

```move
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
        if (b == 31) break;
    };

    for (i in 1..101) {
        print(&i);
    };
}
```

---

## 🔧 3. Functions: Public, Private, Friend

### 🔸 Private Functions
- Default visibility.
- Cannot be called from outside the module.

### 🔸 Public Functions
- Can be called from outside the module.

```move
public fun add(a: u64, b: u64): u64 {
    a + b
}
```

### 🔸 Friend Functions
- Visible only to *specific* modules declared using `friend`.

```move
friend fun difference(a: u64, b: u64): u64 {
    a - b
}
```

### ✅ Usage Example from `sample_function_4`

```move
fun sample_function_4() {
    let a = 30;
    let b = 20;

    let sum = demo_public::add(a, b);         // public
    let diff = demo_public::difference(a, b); // friend
    print(&sum);
    print(&diff);
}
```

---

## 📦 4. Struct Initialization and Entry Functions

### 🔸 Resource Struct with `has key`

```move
struct WhiteListed has key {
    whitelisted: vector<address>
}
```

### 🔸 Initializing the Resource with `move_to`

```move
fun init_module(user: &signer) acquires WhiteListed {
    let whitelisted = vector::empty<address>();
    move_to(user, WhiteListed { whitelisted });

    let whitelisted = borrow_global_mut<WhiteListed>(@data_struct_addr);
    vector::push_back(&mut whitelisted.whitelisted, signer::address_of(user));
}
```

### 🔸 Entry Function
Used to expose functionality that modifies state.

```move
public entry fun add_address(addr: address) acquires WhiteListed {
    let whitelisted = borrow_global_mut<WhiteListed>(@data_struct_addr);
    vector::push_back(&mut whitelisted.whitelisted, addr);
}
```

**💡 Notes:**
- `entry` functions can only be called by transactions.
- `acquires` is required when modifying resources.

---

## 👀 5. View Functions

### 🔸 Purpose
Read-only access to data without modifying state.

### ✅ Syntax with `#[view]`

```move
#[view]
public fun view_whitelisted(): vector<address> acquires WhiteListed {
    let whitelisted = borrow_global<WhiteListed>(@data_struct_addr);
    whitelisted.whitelisted
}
```

**💡 Notes:**
- `#[view]` is important for use in frontend integrations (e.g., Aptos UI).
- Cannot use mutable functions or `move_to` in view functions.

---

## 🧪 6. Test Function

### ✅ Combine All Concepts for Practice

```move
#[test]
fun test_data_structure(user: signer) {
    simple_function_2();     // Conditionals
    simple_function_3();     // Loops
    sample_function_4();     // Function calls
}
```

---

## 📦 Supporting Module: `demo_public.move`

This module provides **shared utility functions** that demonstrate visibility types: `public` and `friend`.

```move
module data_struct_addr::demo_public {
    friend data_struct_addr::data_struct;

    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    friend fun difference(a: u64, b: u64): u64 {
        a - b
    }
}
```

### 🔍 Explanation

| Function Name | Modifier | Who Can Call It?                     | Description                                   |
|---------------|----------|--------------------------------------|-----------------------------------------------|
| `add`         | `public` | Any module                           | Adds two `u64` numbers                        |
| `difference`  | `friend` | Only `data_struct_addr::data_struct` | Subtracts two `u64` numbers, restricted access |

---

## 📝 Summary Table

| Concept            | Description                                 |
|--------------------|---------------------------------------------|
| `if/else`          | Conditional branching                       |
| `while`, `loop`, `for` | Repeating logic                       |
| `fun`              | Function declaration                        |
| `public`           | Callable from outside the module           |
| `friend`           | Callable by specific friend module         |
| `entry`            | Callable via transactions, modifies state  |
| `#[view]`          | Read-only function                          |
| `move_to`          | Save a resource under an account            |
| `borrow_global`    | Read or mutate saved resources              |

---

> ✅ Review and practice each block by modifying and running the functions. Try changing values, loop ranges, and logic to see how Move handles control flow and modular design.
```
