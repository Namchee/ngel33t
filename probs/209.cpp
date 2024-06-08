#include <vector>
#include <climits>
using namespace std;

class Solution {
public:
    int minSubArrayLen(int target, vector<int>& nums) {
        int start = 0;
        int end = 0;
        int sum = 0;

        int result = INT_MAX;

        while (end < nums.size()) {
            sum += nums[end];
            while (sum >= target) {
                result = min(result, end - start + 1);
                sum -= nums[start++];
            }

            end++;
        }

        return result == INT_MAX ? 0 : result;
    }
};
