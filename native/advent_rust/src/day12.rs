use crate::utils::*;
use pathfinding::matrix::Matrix as Graph;
use pathfinding::prelude::bfs;
// use pathfinding::prelude::bfs;
type start = (usize, usize);
type end = (usize, usize);
type duple = (usize, usize);
// Determine if you can climb from a to b.
fn climbable(a: &char, b: &char) -> bool {
    return (*b as i32 - *a as i32) <= 1;
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
    map[start] = 'a';
    map[end] = 'z';
    return (start, end, map);
}
fn get_instance(kind: Instance) -> String {
    use std::fs;
    match kind {
        Instance::Test => {
            let path = fs::canonicalize("./src/day12_test.txt").unwrap();
            return fs::read_to_string(path).unwrap();
        }
        Instance::Full => {
            let path = fs::canonicalize("./src/day12_full.txt").unwrap();
            return fs::read_to_string(path).unwrap();
        }
    }
}
fn solve_part_1(kind: Instance) -> usize {
    let input = get_instance(kind);
    let (start, end, ref graph) = graph_from_input(input);
    let path_from_s_to_e = bfs(
        &start,
        |&point| {
            graph
                .neighbours(point, false)
                .filter(move |&neighbour| climbable(&graph[point], &graph[neighbour]))
                .collect::<Vec<_>>()
        },
        |&p| p == end,
    )
    .unwrap();
    return path_from_s_to_e.len() - 1;
}

fn solve_part_2(kind: Instance) -> usize {
    let input = get_instance(kind);
    let (_, end, ref graph) = graph_from_input(input);
    let mut iter = graph.keys();
    let mut shortest_path = std::usize::MAX;
    while let Some(starting_point) = iter.find(|&x| graph[x] == 'a') {
        let path_from_a_to_e = bfs(
            &starting_point,
            |&point| {
                graph
                    .neighbours(point, false)
                    .filter(move |&neighbour| climbable(&graph[point], &graph[neighbour]))
                    .collect::<Vec<_>>()
            },
            |&p| p == end,
        );
        match path_from_a_to_e {
            None => {}
            Some(path) => {
                shortest_path = std::cmp::min(shortest_path, path.len() - 1);
            }
        }
    }
    return shortest_path;
}

#[cfg(test)]
mod test {
    use super::*;
    #[test]
    fn solve_test_instance_1() -> () {
        let test = solve_part_1(Instance::Test);
        assert_eq!(test, 31);
    }
    #[test]
    fn solve_full_instance_1() -> () {
        let answer = solve_part_1(Instance::Full);
        assert_eq!(answer, 456);
    }
    #[test]
    fn solve_test_instance_2() -> () {
        let answer = solve_part_2(Instance::Test);
        assert_eq!(answer, 29);
    }
    #[test]
    fn solve_test_instance() -> () {
        let answer = solve_part_2(Instance::Full);
        assert_eq!(answer, 454);
    }
}
