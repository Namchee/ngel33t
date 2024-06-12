#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    void sortColors(vector<int>& nums) {
        int zero = 0;
        int two = nums.size() - 1;

        int idx = 0;

        while (idx <= two) {
            if (nums[idx] == 0) {
                swap(nums[idx], nums[zero]);
                zero += 1;
                if (idx < zero) {
                    idx = zero;
                }
            } else if (nums[idx] == 2) {
                swap(nums[idx], nums[two]);
                two--;
            } else {
                idx++;
            }
        }
    }
};
