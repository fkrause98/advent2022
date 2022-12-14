use std::fs;
pub fn get_file(path: &str) -> String {
    let full_path = fs::canonicalize(path).unwrap();
    let contents = fs::read_to_string(full_path).unwrap();
    return contents;
}
pub enum Instance {
    Test,
    Full,
}
