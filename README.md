# Chromatic

Beautiful, expressive and composable color and text formatting for CLI in Gleam.

[![Package Version](https://img.shields.io/hexpm/v/chromatic)](https://hex.pm/packages/chromatic)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/chromatic/)

## Usage
```sh
gleam add chromatic
```
The best way to use this is through Gleam's pipelines.

Check it out!

```gleam
import chromatic.{bold, italic, magenta, rainbow}

pub fn main() {
 io.println(
    "Hello "
    <> "Gleam"
    |> magenta
    |> italic
    |> bold
    <> ", this is "
    <> "Chromatic"
    |> rainbow
    |> bold,
  )
}
```

Further documentation can be found at <https://hexdocs.pm/chromatic>.

A whole bunch of new features are coming soon!

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam shell # Run an Erlang shell
```
