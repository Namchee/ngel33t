#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    void nextPermutation(vector<int>& nums) {
        int pivot = -1;
        int n = nums.size();

        for (int i = n - 2; i >= 0 && pivot == -1; i--) {
            if (nums[i] < nums[i + 1]) {
                pivot = i;
            }
        }

        if (pivot == -1) {
            reverse(nums.begin(), nums.end());
        } else {
            int successor = -1;
            for (int i = n - 1; i > pivot && successor == -1; i--) {
                if (nums[i] > nums[pivot]) {
                    successor = i;
                }
            }

            swap(nums[pivot], nums[successor]);
            reverse(nums.begin() + pivot + 1, nums.end());
        }
    }
};
