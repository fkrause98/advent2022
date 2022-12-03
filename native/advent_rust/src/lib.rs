use itertools::Itertools;
use std::str::FromStr;
use strum_macros::EnumString;
#[derive(Debug, EnumString)]
enum ElfGame {
    A,
    B,
    C,
}
#[derive(Debug, EnumString)]
enum MyGame {
    X,
    Y,
    Z,
}

#[inline]
fn game_to_score(elf_game: ElfGame, my_game: MyGame) -> u64 {
    match (elf_game, my_game) {
        (ElfGame::A, MyGame::X) => 3 + 1,
        (ElfGame::A, MyGame::Y) => 6 + 2,
        (ElfGame::A, MyGame::Z) => 3 + 0,
        (ElfGame::B, MyGame::X) => 0 + 1,
        (ElfGame::B, MyGame::Y) => 3 + 2,
        (ElfGame::B, MyGame::Z) => 6 + 3,
        (ElfGame::C, MyGame::X) => 1 + 6,
        (ElfGame::C, MyGame::Y) => 0 + 2,
        (ElfGame::C, MyGame::Z) => 3 + 3,
    }
}
#[inline]
fn game_to_score_part_2(elf_game: ElfGame, my_game: MyGame) -> u64 {
    let new_mine =
        match (&elf_game, my_game) {
        (ElfGame::A, MyGame::X) => MyGame::Z,
        (ElfGame::A, MyGame::Y) => MyGame::X,
        (ElfGame::A, MyGame::Z) => MyGame::Y,
        (ElfGame::B, MyGame::X) => MyGame::X,
        (ElfGame::B, MyGame::Y) => MyGame::Y,
        (ElfGame::B, MyGame::Z) => MyGame::Z,
        (ElfGame::C, MyGame::X) => MyGame::Y,
        (ElfGame::C, MyGame::Y) => MyGame::Z,
        (ElfGame::C, MyGame::Z) => MyGame::X,
    };
    return game_to_score(elf_game, new_mine);
}
#[rustler::nif]
fn advent_game(input: Vec<String>) -> u64 {
    let parsed_input: Vec<Vec<&String>> = input
        .iter()
        .chunks(2)
        .into_iter()
        .map(|chunk| chunk.collect::<Vec<_>>())
        .collect::<Vec<_>>();
    let solution: u64 =
        parsed_input
        .into_iter()
        .map(|game| -> u64 {
            let score = game_to_score(
                ElfGame::from_str(game[0]).unwrap(),
                MyGame::from_str(game[1]).unwrap(),
            );
            return score;
        })
        .sum();
    return solution;
}

#[rustler::nif]
fn advent_game_part_2(input: Vec<String>) -> u64 {
    let parsed_input: Vec<Vec<&String>> = input
        .iter()
        .chunks(2)
        .into_iter()
        .map(|chunk| chunk.collect::<Vec<_>>())
        .collect::<Vec<_>>();
    let solution: u64 =
        parsed_input
        .into_iter()
        .map(|game| -> u64 {
            let score = game_to_score_part_2(
                ElfGame::from_str(game[0]).unwrap(),
                MyGame::from_str(game[1]).unwrap(),
            );
            return score;
        })
        .sum();
    return solution;
}

rustler::init!("Elixir.Advent2022.Day2", [advent_game, advent_game_part_2]);
