#include <vector>
using namespace std;

class Solution {
public:
    vector<int> findDuplicates(vector<int>& nums) {
        int idx = 0;
        while (idx < nums.size()) {
            int target = nums[idx] - 1;
            if (nums[target] != nums[idx]) {
                nums[idx] += nums[target];
                nums[target] = nums[idx] - nums[target];
                nums[idx] -= nums[target];
            } else {
                idx++;
            }
        }

        vector<int> result;
        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] != i + 1) {
                result.push_back(nums[i]);
            }
        }

        return result;
    }
};
