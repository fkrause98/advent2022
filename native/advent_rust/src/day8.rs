use nalgebra::DMatrix;
use std::{collections::HashSet, convert::TryInto};
#[rustler::nif]
pub fn advent_forest(input: Vec<Vec<usize>>) -> usize {
    let n = input.len();
    let m = input[0].len();
    let flattened: Vec<usize> = input.into_iter().flatten().collect();
    let matrix = DMatrix::from_vec(n, m, flattened).transpose();
    let visible_trees = get_visible(matrix, n, m);
    return visible_trees.len();
}
fn get_visible(forest: DMatrix<usize>, rows: usize, columns: usize) -> HashSet<(usize, usize)> {
    let mut coords_vec = vec![];
    let mut visible_trees = HashSet::new();
    for row_indx in 0..rows {
        for col_indx in 0..columns {
            coords_vec.push((row_indx, col_indx))
        }
    }
    for (x, y) in coords_vec.iter() {
        let mut v_from_t = true;
        let mut v_from_b = true;
        let mut v_from_l = true;
        let mut v_from_r = true;
        let val = forest[(*x, *y)];
        let row = forest.row(*x);
        let col = forest.column(*y);
        for (indx, z) in row.iter().enumerate() {
            if y < &indx && z >= &val {
                v_from_r = false;
            }
            if y > &indx && z >= &val {
                v_from_l = false;
            }
        }
        for (indx, z) in col.iter().enumerate() {
            if x < &indx && z >= &val {
                v_from_t = false;
            }
            if x > &indx && z >= &val {
                v_from_b = false;
            }
        }

        let is_visible = v_from_t || v_from_b || v_from_l || v_from_r;
        if is_visible {
            visible_trees.insert((*x, *y));
        }
    }
    return visible_trees;
}

#[rustler::nif]
pub fn advent_forest_part_2(input: Vec<Vec<usize>>) -> usize {
    let n = input.len();
    let m = input[0].len();
    let flattened: Vec<usize> = input.into_iter().flatten().collect();
    let matrix = DMatrix::from_vec(n, m, flattened).transpose();
    let visible_trees = get_visible(matrix.clone(), n, m);
    let max_score = visible_trees
        .iter()
        .map(|pair| get_scenic_score(*pair, &matrix))
        .max()
        .unwrap();
    return max_score;
}

fn scan_top((x, y): (usize, usize), forest: &DMatrix<usize>) -> usize {
    let val = forest[(x, y)];
    let mut visibility = 0;
    let mut i: i64 = (x as i64) - 1;
    while i >= 0 && forest[(i as usize, y)] < val {
        visibility += 1;
        i -= 1;
    }
    if i >= 0 {
        visibility += 1;
    }
    return visibility;
}
fn scan_below((x, y): (usize, usize), forest: &DMatrix<usize>) -> usize {
    let val = forest[(x, y)];
    let mut visibility = 0;
    let mut i = x + 1;
    while i < forest.nrows() && forest[(i, y)] < val {
        visibility += 1;
        i += 1;
    }
    if i < forest.nrows() {
        visibility += 1;
    }
    return visibility;
}

fn scan_left((x, y): (usize, usize), forest: &DMatrix<usize>) -> usize {
    let val = forest[(x, y)];
    let mut visibility = 0;
    let mut i = (y as isize - 1);
    while i >= 0 && forest[(x, i as usize)] < val {
        visibility += 1;
        i -= 1;
    }
    if i >= 0 {
        visibility += 1;
    }
    return visibility;
}

fn scan_right((x, y): (usize, usize), forest: &DMatrix<usize>) -> usize {
    let val = forest[(x, y)];
    let mut visibility = 0;
    let mut i = (y as isize + 1);
    while i < forest.ncols().try_into().unwrap() && forest[(x, i as usize)] < val {
        visibility += 1;
        i += 1;
    }
    if i < forest.ncols().try_into().unwrap() {
        visibility += 1;
    }
    return visibility;
}
fn get_scenic_score(pair: (usize, usize), forest: &DMatrix<usize>) -> usize {
    let top = scan_top(pair, forest);
    let below = scan_below(pair, forest);
    let left = scan_left(pair, forest);
    let right = scan_right(pair, forest);
    return top*below*left*right;
}

#[cfg(test)]
mod test {
    use super::*;
    #[test]
    fn scan_top_test() -> () {
        let vec: Vec<usize> = vec![
            3, 0, 3, 7, 3, 2, 5, 5, 1, 2, 6, 5, 3, 3, 2, 3, 3, 5, 4, 9, 3, 5, 3, 9, 0,
        ];
        let matrix = DMatrix::from_vec(5, 5, vec).transpose();
        println!("{}", matrix);
        assert_eq!(scan_top((1, 2), &matrix), 1);
        assert_eq!(scan_top((2, 3), &matrix), 2);
        assert_eq!(scan_top((3, 2), &matrix), 2);
    }
    #[test]
    fn scan_below_test() -> () {
        let vec: Vec<usize> = vec![
            3, 0, 3, 7, 3, 2, 5, 5, 1, 2, 6, 5, 3, 3, 2, 3, 3, 5, 4, 9, 3, 5, 3, 9, 0,
        ];
        let matrix = DMatrix::from_vec(5, 5, vec).transpose();
        assert_eq!(scan_below((1, 2), &matrix), 2);
        assert_eq!(scan_below((2, 3), &matrix), 1);
        assert_eq!(scan_below((3, 2), &matrix), 1);
    }
    #[test]
    fn scan_left_test() -> () {
        let vec: Vec<usize> = vec![
            3, 0, 3, 7, 3, 2, 5, 5, 1, 2, 6, 5, 3, 3, 2, 3, 3, 5, 4, 9, 3, 5, 3, 9, 0,
        ];
        let matrix = DMatrix::from_vec(5, 5, vec).transpose();
        assert_eq!(scan_left((1, 2), &matrix), 1);
        assert_eq!(scan_left((2, 3), &matrix), 1);
        assert_eq!(scan_left((3, 2), &matrix), 2);
    }
    #[test]
    fn scan_right_test() -> () {
        let vec: Vec<usize> = vec![
            3, 0, 3, 7, 3, 2, 5, 5, 1, 2, 6, 5, 3, 3, 2, 3, 3, 5, 4, 9, 3, 5, 3, 9, 0,
        ];
        let matrix = DMatrix::from_vec(5, 5, vec).transpose();
        println!("{}", matrix);
        assert_eq!(scan_right((1, 2), &matrix), 2);
        assert_eq!(scan_right((2, 3), &matrix), 1);
        assert_eq!(scan_right((3, 2), &matrix), 2);
    }
    #[test]
    fn scenic_score_test() -> () {
        let vec: Vec<usize> = vec![
            3, 0, 3, 7, 3, 2, 5, 5, 1, 2, 6, 5, 3, 3, 2, 3, 3, 5, 4, 9, 3, 5, 3, 9, 0,
        ];
        let matrix = DMatrix::from_vec(5, 5, vec).transpose();
        println!("{}", matrix);
        assert_eq!(get_scenic_score((1, 2), &matrix), 4);
        assert_eq!(get_scenic_score((2, 3), &matrix), 2);
        assert_eq!(get_scenic_score((3, 2), &matrix), 8);
    }

}
