#include <vector>
using namespace std;

class Solution {
public:
    int subarraySum(vector<int>& nums, int k) {
        int result = 0;
        for (int i = 0; i < nums.size(); i++) {
            result += nums[i] == k;
            if (i > 0) {
                nums[i] += nums[i - 1];
                result += nums[i] == k;
            }
        }

        for (int i = 1; i < nums.size(); i++) {
            for (int j = 0; j < i - 1; j++) {
                int temp = nums[i] - nums[j];

                result += temp == k;
            }
        }

        return result;
    }
};
