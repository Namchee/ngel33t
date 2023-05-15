class Solution {
public:
    int numSquares(int n) {
        int memo[10001];
        for (int idx = 0; idx <= 10000; idx++) {
            memo[idx] = idx;
        }

        for (int num = 2; num * num <= 10000; num++) {
            int sp = num * num;
            memo[sp] = 1;

            for (int idx = sp + 1; idx <= 10000; idx++) {
                if (memo[idx] > memo[idx - sp] + memo[sp]) {
                    memo[idx] = memo[idx - sp] + memo[sp];
                }
            }
        }

        return memo[n];
    }
};