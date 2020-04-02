#[macro_use]
extern crate prettytable;
use std::fmt::Write;
//use std::fs;
use prettytable::Table;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

#[macro_use]
extern crate lazy_static;
extern crate regex;

use regex::Regex;
// TODO(hmble): add proper option to include vim file specified by argument or by global vim
// location such as $HOME/.vimrc or $XDG_CONFIG_DIR/nvim/init.vim
static VIMCONFIG: &str = "/home/hmblesam/.config/nvim/init.vim";
fn main() {
    // File hosts must exist in current path before this produces output

    let mut table = Table::new();
    table.add_row(row!["Start", "Mid", "End"]);
    if let Ok(lines) = read_lines(VIMCONFIG) {
        // Consumes the iterator, returns an (Optional) String
        for line in lines {
            if let Ok(text) = line {
                printmap(text.as_str(), &mut table);
            }
        }
    }

    table.printstd();
}

fn printmap(line: &str, table: &mut Table) {
    lazy_static! {
        static ref RE: Regex = Regex::new(r"^*map\s").unwrap();
    }
    if RE.is_match(line) {
        if &line[0..1] == "\"" {
            return;
        } else {
            let split: Vec<&str> = line.split(" ").collect();

            let mut start = String::new();
            let mut mid = String::new();
            let mut end = String::new();
            if split.len() == 3 {
                start.push_str(split[0]);
                mid.push_str(split[1]);
                end.push_str(split[2]);
            } else {
                for (i, val) in split.iter().enumerate() {
                    match i {
                        0 => start.push_str(val),
                        1 | 2 => write!(&mut mid, "{} ", val).unwrap(),
                        _ => end.push_str(val),
                    }
                }
            }

            //println!("{:10}  | {}  | {}", start, mid, end);
            table.add_row(row![start, mid, end]);
        }
    }
}

// The output is wrapped in a Result to allow matching on errors
// Returns an Iterator to the Reader of the lines of the file.
fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where
    P: AsRef<Path>,
{
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}
