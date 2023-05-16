impl Solution {
    pub fn combination_sum(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32> > = Vec::new();
        let mut temp: Vec<i32> = Vec::new();

        Solution::brute_force(&candidates, &mut temp, target, 0, &mut result);

        result
    }

    fn brute_force(
        candidates: &Vec<i32>,
        temp: &mut Vec<i32>,
        target: i32,
        start: usize,
        result: &mut Vec<Vec<i32> >
    ) {
        let mut sum: i32 = 0;
        for val in temp.iter() {
            sum += val;
        }

        if (sum > target) {
            return;
        }

        if (sum == target) {
            result.push(temp.clone());
            return;
        }

        let mut idx = start;

        while idx < candidates.len() {
            temp.push(candidates[idx]);

            Solution::brute_force(candidates, temp, target, idx, result);

            temp.pop();

            idx += 1;
        }
    }
}