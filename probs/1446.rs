use std::cmp;

impl Solution {
    pub fn max_power(s: String) -> i32 {
        let stri: Vec<char> = s.chars().collect();

        let mut curr = stri[0];
        let mut len = 1;

        let mut best: i32 = 1;

        for idx in 1..stri.len() {
            let c = stri[idx];

            if c != curr {
                best = cmp::max(best, len);
                len = 1;
                curr = c;
            } else {
                len += 1;
            }
        }

        cmp::max(best, len)
    }
}
