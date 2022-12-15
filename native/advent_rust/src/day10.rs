use crate::instruction::Instruction;
use crate::instruction::Instruction::{Addx, Noop};
use std::collections::VecDeque;
use std::str::FromStr;
fn execute(mut commands: VecDeque<Instruction>, cycles: u64) -> i64 {
    let mut i = 1;
    let mut reg_x = 1;
    while i < cycles {
        let next = commands.pop_front().unwrap();
        i += 1;
        match next {
            Addx(to_add) if i < cycles => {
                reg_x += to_add;
                i += 1;
            }
            _ => {}
        }
    }
    return reg_x;
}
fn strings_to_instructions(input: Vec<String>) -> Vec<Instruction> {
    return input
        .iter()
        .map(|instruction| Instruction::from_str(instruction).unwrap())
        .collect::<Vec<Instruction>>();
}
#[rustler::nif]
pub fn advent_day_10(input: Vec<String>, cycles: u64) -> i64 {
    let parsed = strings_to_instructions(input);
    let instructions = VecDeque::from(parsed);
    let reg_x = execute(instructions, cycles);
    return reg_x;
}

#[cfg(test)]
mod test {
    // const test_instructions: i64 = return 1;
    use super::*;
    use std::fs;
    fn read_test_instructions() -> String {
        let path = fs::canonicalize("./src/instructions_test.txt").unwrap();
        let contents = fs::read_to_string(path).unwrap();
        return contents;
    }
    #[test]
    fn simple_test() -> () {
        let vec = vec![Noop, Addx(3), Addx(-5)];
        let queue = VecDeque::from(vec);
        assert_eq!(4, execute(queue, 5));
    }
    #[test]
    fn test_cycles() -> () {
        let strings = read_test_instructions()
            .trim()
            .split("\n")
            .map(|str| str.into())
            .collect::<Vec<String>>();
        let queue = VecDeque::from(strings_to_instructions(strings));
        let expected_and_cycles = vec![
            (21, 20),
            (19, 60),
            (18, 100),
            (21, 140),
            (16, 180),
            (18, 220),
        ];
        for (expected, cycles) in expected_and_cycles {
            assert_eq!(expected, execute(queue.clone(), cycles));
        }
    }
}
