#include <vector>
using namespace std;

class Solution {
public:
    int numSubarrayProductLessThanK(vector<int>& nums, int k) {
        int start = 0;
        int end = 0;
        int result = 0;
        int curr = 1;

        if (k <= 1) {
            return 0;
        }

        while (end < nums.size()) {
            curr *= nums[end];
            while (curr >= k) curr /= nums[start++];
            result += 1 + (end - start);
            end++;
        }

        return result;
    }
};
