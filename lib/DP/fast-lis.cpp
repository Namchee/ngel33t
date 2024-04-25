/**
 * O (n log n) version of longest increasing subsequence.
 * 
 * Instead of building the list, we build a DP table where:
 * dp[i] is the smallest element at which a LIS with length i ends.
 * 
 * Detailed reading: https://cp-algorithms.com/sequences/longest_increasing_subsequence.html#solution-in-on-log-n-with-dynamic-programming-and-binary-search
*/

int lis(const vector<int>& input) {
    int n = input.size();
    const int INF = 1e9;
    vector<int> dp(n + 1, INF);
    dp[0] = -INF;

    for (int i = 0; i < n; i++) {
        int l = upper_bound(dp.begin(), dp.end(), input[i]) - dp.begin();

        if (dp[l - 1] < input[i] && input[i] < dp[l]) {
            dp[l] = input[i];
        }
    }

    int ans = 1;

    for (int l = 1; l <= n; l++) {
        if (d[l] != INF) {
            ans = l;
        }
    }

    return ans;
}
