#include <vector>
using namespace std;

class Solution {
public:
    int firstMissingPositive(vector<int>& nums) {
        int idx = 0;
        while (idx < nums.size()) {
            int target = nums[idx];
            
            if (target >= 1 && target <= nums.size() && nums[idx] != nums[target - 1]) {
                int temp = nums[idx];
                nums[idx] = nums[target - 1];
                nums[target - 1] = temp;
            } else {
                idx++;
            }
        }

        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] != i + 1) {
                return i + 1;
            }
        }

        return nums.size() + 1;
    }
};
