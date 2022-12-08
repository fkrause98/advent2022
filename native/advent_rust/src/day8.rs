use nalgebra::DMatrix;
#[rustler::nif]
pub fn advent_forest(input: Vec<Vec<usize>>) -> usize {
    let n = input.len();
    let m = input[0].len();
    let flattened: Vec<usize> = input.into_iter().flatten().collect();
    let matrix = DMatrix::from_vec(n, m, flattened).transpose();
    let visible_trees = get_visible(matrix, n, m);
    return visible_trees;
}
fn get_visible(forest: DMatrix<usize>, rows: usize, columns: usize) -> usize {
    let mut coords_vec = vec![];
    let mut visible_trees = 0;
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
            visible_trees += 1;
        }
    }
    return visible_trees;
}
