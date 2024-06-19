use std::cmp;

impl Solution {
    pub fn min_days(bloom_day: Vec<i32>, m: i32, k: i32) -> i32 {
        if bloom_day.len() < ((m * k) as usize) {
            return -1;
        }

        let mut lo = 0;
        let mut hi = 0;

        for day in bloom_day.iter() {
            hi = cmp::max(hi, *day);
        }

        let mut best = -1;

        while (lo <= hi) {
            let mid = lo + (hi - lo) / 2;
            if Self::possible(&bloom_day, m, k, mid) {
                best = mid;
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        }

        best
    }

    fn possible(bloom_day: &Vec<i32>, m: i32, k: i32, day: i32) -> bool {
        let mut bouquet = 0;
        let mut flowers = 0;

        for bloom in bloom_day.iter() {
            if *bloom <= day {
                flowers += 1;
            } else {
                flowers = 0;
            }

            if flowers == k {
                bouquet += 1;
                flowers = 0;
            }
        }

        bouquet >= m
    }
}
