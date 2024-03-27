class Solution {
public:
    int numSubarrayProductLessThanK(vector<int>& nums, int k) {
        int result = 0;

        for (int i = 0; i < nums.size(); i++) {
            int acc = nums[i];
            if (acc < k) {
                result++;
            }

            for (int j = i + 1; j < nums.size() && acc < k; j++) {
                acc *= nums[j];

                if (acc < k) {
                    result++;
                }
            }
        }
        
        return result;
    }
};
