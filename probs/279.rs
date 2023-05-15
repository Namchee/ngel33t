impl Solution {
    pub fn num_squares(n: i32) -> i32 {
        let mut memo: [i32; 10001] = [0; 10001];
        
        for idx in 0..10001 {
            memo[idx] = idx as i32;
        }

        let mut num = 2;

        while num * num <= 10000 {
            let mut start = num * num;
            memo[start] = 1;

            while start <= 10000 {
                if memo[start] > memo[start - num * num] + 1 {
                    memo[start] = memo[start - num * num] + 1;
                }

                start += 1;
            }

            num += 1;
        }

        return memo[n as usize];
    }
}