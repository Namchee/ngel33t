#include <vector>
using namespace std;

class Solution {
public:
    long long countSubarrays(vector<int>& nums, int minK, int maxK) {
        long long result = 0;

        int start = 0;
        int end = 0;
        int mini = -1;
        int maxi = -1;

        while (end < nums.size()) {
            if (nums[end] < minK || nums[end] > maxK) {
                start = end + 1;
                mini = -1;
                maxi = -1;
            } else {
                if (nums[end] == minK) {
                    mini = end;
                }
                if (nums[end] == maxK) {
                    maxi = end;
                }

                result += max(0, min(mini, maxi) - start + 1);
            }

            end++;
        }

        return result;
    }
};
