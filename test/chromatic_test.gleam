import gleeunit
import gleeunit/should
import chromatic

const ansi_escape = "\u{001b}["

const ansi_clear = "\u{001b}[0m"

pub fn main() {
  gleeunit.main()
}

pub fn ansi_decorate_test() {
  "Test"
  |> chromatic.bold
  |> should.equal(ansi_escape <> "1m" <> "Test" <> ansi_clear)
}

pub fn bleed_test() {
  "Test"
  |> chromatic.bold
  |> chromatic.bleed
  |> should.equal(ansi_escape <> "1m" <> "Test")
}

pub fn clear_test() {
  "Test"
  |> chromatic.bold
  |> chromatic.clear
  |> should.equal(ansi_clear <> ansi_escape <> "1m" <> "Test" <> ansi_clear)
}
