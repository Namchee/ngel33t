#include <vector>;
using namespace std;

class Solution {
public:
    int findTargetSumWays(vector<int>& nums, int target) {
        findCombination(nums, target, 0, 0);

        return result;
    }

private:
    int result = 0;

    void findCombination(vector<int>& nums, int target, int curr, int idx) {
        if (nums.size() == idx) {
            result += (curr == target);

            return;
        }

        findCombination(nums, target, curr + nums[idx], idx + 1);
        findCombination(nums, target, curr - nums[idx], idx + 1);
    }
};
