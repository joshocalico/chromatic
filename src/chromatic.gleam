//// # Chromatic
//// Composable text formatting for CLI in Gleam.
//// 
//// ## Usage
//// 
//// The best way to use this is through Gleam's pipelines.
//// 
//// Check it out!
//// 
//// ```gleam
//// import chromatic.{bold, italic, magenta, rainbow}
//// 
//// pub fn main() {
////  io.println(
////   "Hello "
////   <> "Gleam"
////   |> magenta
////   |> italic
////   |> bold
////   <> ", this is "
////   <> "Chromatic"
////   |> rainbow
////   |> bold,
////  )
//// }
////```
//// 

import gleam/string
import gleam/list

const ansi_escape = "\u{001b}["

const ansi_clear = "\u{001b}[0m"

/// ANSI escape helper, adds a ANSI code to the provided string.
/// Unlike the `decorate_ansi` function not terminate with the clear sequence.
pub fn decorate_ansi_raw(string: String, code: String) {
  ansi_escape <> code <> "m" <> string
}

/// ANSI escape helper, adds a ANSI code to the provided string.
/// This also terminates the string with the clear sequence so it doesn't affect
/// other strings.
pub fn decorate_ansi(string: String, code: String) {
  decorate_ansi_raw(string, code)
  |> auto_clear
}

fn auto_clear(string: String) {
  let result = case string.ends_with(string, ansi_clear) {
    True -> string
    False -> string <> ansi_clear
  }
  result
}

/// Set text color to black.
pub fn black(string: String) {
  decorate_ansi(string, "30")
}

/// Set text color to red.
pub fn red(string: String) {
  decorate_ansi(string, "31")
}

/// Set text color to green.
pub fn green(string: String) {
  decorate_ansi(string, "32")
}

/// Set text color to yellow.
pub fn yellow(string: String) {
  decorate_ansi(string, "33")
}

/// Set text color to blue.
pub fn blue(string: String) {
  decorate_ansi(string, "34")
}

/// Set text color to magenta.
pub fn magenta(string: String) {
  decorate_ansi(string, "35")
}

/// Set text color to cyan.
pub fn cyan(string: String) {
  decorate_ansi(string, "36")
}

/// Set text color to an off-white color,
/// for a lighter white try `bright_white`
pub fn white(string: String) {
  decorate_ansi(string, "37")
}

/// Set text color to gray.
pub fn gray(string: String) {
  decorate_ansi(string, "90")
}

/// Set text color to a lighter red.
pub fn bright_red(string: String) {
  decorate_ansi(string, "91")
}

/// Set text color to a lighter green.
pub fn bright_green(string: String) {
  decorate_ansi(string, "92")
}

/// Set text color to a lighter yellow.
pub fn bright_yellow(string: String) {
  decorate_ansi(string, "93")
}

/// Set text color to a lighter blue.
pub fn bright_blue(string: String) {
  decorate_ansi(string, "94")
}

/// Set text color to a lighter magenta.
pub fn bright_magenta(string: String) {
  decorate_ansi(string, "95")
}

/// Set text color to a lighter cyan.
pub fn bright_cyan(string: String) {
  decorate_ansi(string, "96")
}

/// Set text color to a bright white color
pub fn bright_white(string: String) {
  decorate_ansi(string, "97")
}

/// Set background color to black.
pub fn bg_black(string: String) {
  decorate_ansi(string, "40")
}

/// Set background color to red.
pub fn bg_red(string: String) {
  decorate_ansi(string, "41")
}

/// Set background color to green.
pub fn bg_green(string: String) {
  decorate_ansi(string, "42")
}

/// Set background color to yellow.
pub fn bg_yellow(string: String) {
  decorate_ansi(string, "43")
}

/// Set background color to blue.
pub fn bg_blue(string: String) {
  decorate_ansi(string, "44")
}

/// Set background color to magenta.
pub fn bg_magenta(string: String) {
  decorate_ansi(string, "45")
}

/// Set background color to cyan.
pub fn bg_cyan(string: String) {
  decorate_ansi(string, "46")
}

/// Set's background to an off-white color,
/// for a lighter white try `bg_bright_white`
pub fn bg_white(string: String) {
  decorate_ansi(string, "47")
}

/// Set background color to gray.
pub fn bg_gray(string: String) {
  decorate_ansi(string, "100")
}

/// Set background color to a lighter red.
pub fn bg_bright_red(string: String) {
  decorate_ansi(string, "101")
}

/// Set background color to a lighter green.
pub fn bg_bright_green(string: String) {
  decorate_ansi(string, "102")
}

/// Set background color to a lighter yellow.
pub fn bg_bright_yellow(string: String) {
  decorate_ansi(string, "103")
}

/// Set background color to a lighter blue.
pub fn bg_bright_blue(string: String) {
  decorate_ansi(string, "104")
}

/// Set background color to a lighter magenta.
pub fn bg_bright_magenta(string: String) {
  decorate_ansi(string, "105")
}

/// Set background color to a lighter cyan.
pub fn bg_bright_cyan(string: String) {
  decorate_ansi(string, "106")
}

/// Set background color to a bright white color
pub fn bg_bright_white(string: String) {
  decorate_ansi(string, "107")
}

/// Set text style to bold
pub fn bold(string: String) {
  decorate_ansi(string, "1")
}

/// Set text style to italic
pub fn italic(string: String) {
  decorate_ansi(string, "3")
}

/// Set text style to underlined
pub fn underline(string: String) {
  decorate_ansi(string, "4")
}

/// Propagate style from this string until next reset.
/// Must be the last function in the pipeline.
pub fn bleed(string: String) {
  let result = case string.ends_with(string, ansi_clear) {
    True -> string.drop_right(from: string, up_to: string.length(ansi_clear))
    False -> string
  }
  result
}

/// Print this to clear any styles that are bleeding through.
pub fn clear_str() {
  ansi_clear
}

/// Clears any previously added styles that would have bled into it.
/// 
/// Only necessary if you've used `bleed`.
/// 
/// Like `bleed` needs to be the last function in the pipeline
pub fn clear(string: String) {
  ansi_clear <> string
}

/// Rainbow text with an integer offset
pub fn offset_rainbow(string: String, offset: Int) {
  let #(str, _, _) =
    string.to_graphemes(string)
    |> list.fold(#("", False, offset), fn(acc, char) {
      let #(str, in, color) = acc

      let new_in = case in {
        True -> char != "m"
        False -> char == "\u{001b}"
      }

      let maybe_color = case in || new_in {
        True -> #(str <> char, new_in, color)
        False -> {
          let colored = case color % 6 {
            // Red
            0 -> decorate_ansi_raw(char, "31")
            // Yellow
            1 -> decorate_ansi_raw(char, "33")
            // Green
            2 -> decorate_ansi_raw(char, "32")
            // Cyan
            3 -> decorate_ansi_raw(char, "36")
            // Blue
            4 -> decorate_ansi_raw(char, "34")
            // Magenta
            5 -> decorate_ansi_raw(char, "35")
            _ -> ""
          }
          #(str <> colored, new_in, color + 1)
        }
      }
      maybe_color
    })
  str
}

// Rainbow text!
pub fn rainbow(string: String) {
  offset_rainbow(string, 0)
}
