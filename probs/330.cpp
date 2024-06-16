#include <vector>
using namespace std;

class Solution {
public:
    int minPatches(vector<int>& nums, int n) {
        int result = 0;
        int idx = 0;
        long long sum = 1;

        while (sum <= n) {
            if (idx < nums.size() && nums[idx] <= sum) {
                sum += nums[idx];
                idx++;
            } else {
                sum += sum;
                result++;
            }
        }

        return result;
    }
};
