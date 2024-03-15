#include <vector>;
using namespace std;

class Solution {
public:
    vector<int> productExceptSelf(vector<int>& nums) {
        vector<int> result(nums.begin(), nums.end());

        int temp = 1;
        for (int i = 0; i < nums.size(); i++) {
            result[i] = temp;
            temp *= nums[i];
        }

        temp = 1;
        for (int i = nums.size() - 1; i >= 0; i--) {
            result[i] *= temp;
            temp *= nums[i];
        }

        return result;
    }
};
