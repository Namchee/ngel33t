use std::cmp;

impl Solution {
    pub fn min_cost_climbing_stairs(cost: Vec<i32>) -> i32 {
        let mut memo = vec![0; cost.len()];
        memo[0] = cost[0];

        for idx in 1..memo.len() {
            memo[idx] = memo[idx - 1] + cost[idx];

            if idx > 0 {
                let mut prev = 0;
                if idx > 1 {
                    prev = memo[idx - 2];
                }

                memo[idx] = cmp::min(
                    memo[idx],
                    prev + cost[idx]
                );
            }
        }

        return cmp::min(memo[memo.len() - 1], memo[memo.len() - 2]);
    }
}