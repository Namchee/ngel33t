use anyhow::*;
use std::collections::HashMap;
use std::fs::File;
use std::io::{BufRead, BufReader};
use code_timing_macros::time_snippet;
use const_format::concatcp;
use adv_code_2024::*;

const DAY: &str = "01"; // TODO: Fill the day
const INPUT_FILE: &str = concatcp!("input/", DAY, ".txt");

const TEST: &str = "\
3   4
4   3
2   5
1   3
3   9
3   3
";

fn main() -> Result<()> {
    start_day(DAY);

    //region Part 1
    println!("=== Part 1 ===");

    fn part1<R: BufRead>(reader: R) -> Result<i32> {
        let mut arr1: Vec<i32> = vec![];
        let mut arr2: Vec<i32> = vec![];

        for line in reader.lines() {
            let nums: Vec<i32> = line?.split_whitespace().filter_map(|c| c.parse().ok()).collect();
            arr1.push(nums[0]);
            arr2.push(nums[1]);
        }

        arr1.sort();
        arr2.sort();

        let mut diff = 0;
        for i in 0..arr1.len() {
            diff += (arr1[i] - arr2[i]).abs();
        }

        Ok(diff)
    }

    assert_eq!(11, part1(BufReader::new(TEST.as_bytes()))?);

    let input_file = BufReader::new(File::open(INPUT_FILE)?);
    let result = time_snippet!(part1(input_file)?);
    println!("Result = {}", result);
    //endregion

    println!("\n=== Part 2 ===");
    
    fn part2<R: BufRead>(reader: R) -> Result<u32> {
        let mut arr: Vec<u32> = vec![];
        let mut map: HashMap<u32, u32> = HashMap::new();

        for line in reader.lines() {
            let nums: Vec<u32> = line?.split_whitespace().filter_map(|c| c.parse().ok()).collect();
            arr.push(nums[0]);

            let entry = map.entry(nums[1]).or_insert(0);
            *entry += 1;
        }

        let result: u32 = arr.iter().fold(0, |a, &c| {
            a + c * map.get(&c).unwrap_or(&0)
        });

        Ok(result)
    }
    
    assert_eq!(31, part2(BufReader::new(TEST.as_bytes()))?);
    
    let input_file = BufReader::new(File::open(INPUT_FILE)?);
    let result = time_snippet!(part2(input_file)?);
    println!("Result = {}", result);

    Ok(())
}
