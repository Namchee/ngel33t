#include <vector>
using namespace std;

class Solution {
public:
    int findMin(vector<int>& nums) {
        int result = nums[0];
        int start = 0;
        int end = nums.size() - 1;

        while (start <= end) {
            if (nums[start] < nums[end]) {
                result = min(result, nums[start]);
                break;
            }

            int mid = start + (end - start) / 2;
            result = min(result, nums[mid]);

            if (nums[mid] >= nums[start]) {
                start = mid + 1;
            } else {
                end = mid - 1;
            }
        }

        return result;
    }
};
