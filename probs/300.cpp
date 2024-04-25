#include <vector>
using namespace std;

class Solution {
public:
    int lengthOfLIS(vector<int>& nums) {
        int result = 1;
        int n = nums.size();
        vector<int> best(nums.size(), 1);

        for (int i = 1; i < nums.size(); i++) {
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i]) {
                    best[i] = max(best[i], best[j] + 1);
                }
            }

            result = max(result, best[i]);
        }

        return result;
    }
};