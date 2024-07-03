#include <vector>
#include <algorithm>
#include <climits>
using namespace std;

class Solution {
public:
    int minDifference(vector<int>& nums) {
        if (nums.size() <= 4) {
            return 0;
        }

        sort(nums.begin(), nums.end());

        int result = INT_MAX;

        for (int i = 0, j = nums.size() - 4; i < 4; i++, j++) {
            result = min(result, nums[j] - nums[i]);
        }

        return result;
    }
};
