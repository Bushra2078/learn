Unit and documentation tests provide concise and specific tests. But it's also a good idea to test our crate as a whole. Then we can confirm that our crate's various code parts function together as expected.

To test your crate as a whole, you can use *integration tests*. The Rust test suite supports this type of test, which only calls functions that your library's public API contains. You can use integration tests to check how your code works when others use it.

What's unique about these tests is that they exist in a separate directory and file, so they can externally test the library code. Cargo looks for integration tests in the *tests* directory (next to the *src* directory) and will run each source file in it.

Let's write some integration tests by creating a new small project. Run the following commands in your terminal:

```sh
$ cargo new --lib rusty_pizza
$ cd rusty_pizza
```

For this example, we'll use a simple `Pizza` struct with private and public methods.

```rust
pub struct Pizza {
    pub topping: String,
    pub inches: u8,
}

impl Pizza {
    pub fn pepperoni(inches: u8) -> Self {
        Pizza::bake("pepperoni", inches)
    }

    pub fn mozzarella(inches: u8) -> Self {
        Pizza::bake("mozzarella", inches)
    }

    fn bake(topping: &str, inches: u8) -> Self {
        Pizza {
            topping: String::from(topping),
            inches,
        }
    }
}
```

The preceding snippet features a `Pizza` struct with two public methods, `Pizza::pepperoni` and `Pizza::mozzarella`, that rely on the private method `Pizza::bake` to prepare our pizzas.

Create a new directory named `tests` alongside the `src` directory. Place a new file named `pizzas.rs` in it with the following contents:

```rust
use rusty_pizza::Pizza;

#[test]
fn can_make_pepperoni_pizza() {
    let pizza = Pizza::pepperoni(12);
    assert_eq!(pizza.topping, "pepperoni");
    assert_eq!(pizza.inches, 12);
}

#[test]
fn can_make_mozzarella_pizza() {
    let pizza = Pizza::mozzarella(16);
    assert_eq!(pizza.topping, "mozzarella");
    assert_eq!(pizza.inches, 16);
}
```

Now that our integration tests setup is done, we can execute the `cargo test` command to see the results:

```output
running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

     Running target/debug/deps/pizzas-1996564f80b33a1e

running 2 tests
test can_make_mozzarella_pizza ... ok
test can_make_pepperoni_pizza ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests rusty_pizza

running 0 tests

 test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

Inspecting the output reveals that Rust places each kind of test in a different section: unit tests, integration tests, and documentation tests.

In the integration tests section, we can see that our two tests inside the `tests/pizzas.rs` file were collected and executed by the test suite.

Only library crates can be tested via integration tests because binary crates don't expose any functionality that other crates can use. But, many Rust crates that provide a binary have a succinct `src/main.rs` file that calls logic that lives in a `src/lib.rs` file. Using that structure, integration tests can test the important parts of the code.
