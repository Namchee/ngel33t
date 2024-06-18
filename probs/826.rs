impl Solution {
    pub fn max_profit_assignment(difficulty: Vec<i32>, profit: Vec<i32>, mut worker: Vec<i32>) -> i32 {
        let mut jobs: Vec<(i32, i32)> = difficulty.iter()
            .zip(profit.iter())
            .map(|(&d, &p)| (d, p))
            .collect();

        jobs.sort();
        worker.sort();

        let mut best: (i32, i32) = jobs[0];
        let mut job = 0;
        let mut result = 0;

        for w in worker.iter() {
            while job < jobs.len() && jobs[job].0 <= *w {
                if jobs[job].1 > best.1 {
                    best = jobs[job];
                }

                job += 1;
            }

            if best.0 <= *w {
                result += best.1;
            } 
        }

        result
    }
}
