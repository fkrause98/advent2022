use crate::utils::*;
use pathfinding::matrix::Matrix as Graph;
use pathfinding::prelude::bfs;
// use pathfinding::prelude::bfs;
type start = (usize, usize);
type end = (usize, usize);
type duple = (usize, usize);
// Determine if you can climb from a to b.
fn climbable(a: &char, b: &char) -> bool {
    let is_start = (*a == 'S');
    let is_end = (*a == 'E');
    let a_ascii = a.to_digit(10).unwrap();
    let b_ascii = b.to_digit(10).unwrap();
    return (is_start && !(is_end)) && (b_ascii - a_ascii) <= 1;
}
fn graph_from_input(input: String) -> (start, end, Graph<char>) {
    let mut map = Graph::from_rows(input.trim().lines().map(|l| l.chars())).unwrap();
    let start = map
        .keys()
        .find(|vertex| map[*vertex] == (b'S' as char))
        .unwrap();
    let end = map
        .keys()
        .find(|vertex| map[*vertex] == (b'E' as char))
        .unwrap();
    return (start, end, map);
}
fn get_instance(kind: Instance) -> String {
    match kind {
        Test => get_file("day12_test.txt"),
        _ => panic!("WTF???"),
    }
}
fn solve_part_1(kind: Instance) -> usize {
    let input = get_instance(kind);
    let (start, end, graph) = graph_from_input(input);
    let path_from_S_to_E = bfs(
        &start,
        |&point|
            graph
                .neighbours(point, false)
                .filter(|&neighbour| climbable(&graph[point], &graph[neighbour]))
        ,
        |&p| p == end,
    ).unwrap();
    return path_from_S_to_E.len();
}
