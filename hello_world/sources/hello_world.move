/// Module: hello_world
module hello_world::hello_world {
    use std::string;

    // Returns the "Hello, World!" as a `String`.
    public fun hello_world(): string::String {
        string::utf8(b"Hello, World!")
    }
}



// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


