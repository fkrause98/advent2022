use std::str::FromStr;
#[derive(Debug, Clone)]
pub enum Instruction {
    Noop,
    Addx(i64),
}
impl FromStr for Instruction {
    type Err = String;
    fn from_str(instruction: &str) -> Result<Self, Self::Err> {
        let is_noop = instruction.contains("noop");
        if is_noop {
            return Ok(Self::Noop);
        } else {
            let splitted = instruction.trim().split("addx").collect::<Vec<_>>();
            let to_add = splitted[1].trim().parse::<i64>().unwrap();
            return Ok(Self::Addx(to_add));
        }
    }
}
