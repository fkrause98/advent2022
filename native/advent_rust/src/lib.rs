pub mod day10;
pub mod day2;
pub mod day8;
pub mod instruction;

rustler::init!(
    "Elixir.Advent2022.Native",
    [
        day2::advent_game,
        day2::advent_game_part_2,
        day8::advent_forest,
        day8::advent_forest_part_2,
        day10::advent_day_10
    ]
);
