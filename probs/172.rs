impl Solution {
    pub fn trailing_zeroes(n: i32) -> i32 {
        let mut temp = n;
        let mut count = 0;
        while (temp > 0) {
            temp /= 5;
            count += temp;
        }

        count
    }
}
