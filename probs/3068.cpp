#include <vector>
#include <limits.h>
using namespace std;

class Solution {
public:
    long long maximumValueSum(vector<int>& nums, int k, vector<vector<int>>& edges) {
        vector<vector<long long> > dp(nums.size(), vector<long long>(2, -1));

        return maxSumOfNodes(0, 1, nums, k, dp);
    }

private:
    long long maxSumOfNodes(int idx, int even, vector<int>& nums, int k, vector<vector<long long> >& dp) {
        if (idx == nums.size()) {
            return even ? 0 : INT_MIN;
        }

        if (dp[idx][even] != -1) {
            return dp[idx][even];
        }

        long long withXor = (nums[idx] ^ k) + maxSumOfNodes(idx + 1, even ^ 1, nums, k, dp);
        long long noXor = (nums[idx]) + maxSumOfNodes(idx + 1, even, nums, k, dp);

        return dp[idx][even] = max(withXor, noXor);
    }
};
