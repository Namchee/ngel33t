#include <vector>
using namespace std;

class Solution {
public:
    int numSubarraysWithSum(vector<int>& nums, int goal) {
        return atMostGoal(nums, goal) - atMostGoal(nums, goal - 1);
    }

private:
    int atMostGoal(vector<int>& nums, int goal) {
        int result = 0;

        int n = nums.size();
        int curr = 0;
        int start = 0;
        int end = 0;

        while (end < n) {
            curr += nums[end];
            while (curr > goal && start <= end) {
                curr -= nums[start++];
            }

            result += end - start + 1;
            end++;
        }

        return result;
    }
};
