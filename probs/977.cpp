#include <vector>;
using namespace std;

class Solution {
public:
    vector<int> sortedSquares(vector<int>& nums) {
        vector<int> result(nums.size());

        for (int idx = 0; idx < nums.size(); idx++) {
            nums[idx] *= nums[idx];
        }

        int l = 0;
        int r = nums.size() - 1;
        for (int idx = nums.size() - 1; idx >= 0; idx--) {
            if (nums[l] > nums[r]) {
                result[idx] = nums[l++];
            } else {
                result[idx] = nums[r--];
            }
        }

        return result;
    }
};
