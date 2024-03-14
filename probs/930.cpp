#include <vector>;
using namespace std;

class Solution {
public:
    int numSubarraysWithSum(vector<int>& nums, int goal) {
        int n = nums.size();
        int res = 0;

        for (int i = 0; i < n; i++) {
            if (i) {
                nums[i] += nums[i - 1]; 
            }

            if (nums[i] == goal) {
                res++;
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                int sum = nums[i] - nums[j];

                if (sum == goal) {
                    res++;
                }
            }
        }

        return res;
    }
};