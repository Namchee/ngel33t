#include <vector>
using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int count = 0;
        int n = nums.size();

        for (int i = 0; i <= n - 3; i++) {
            if (nums[i] == 0) {
                for (int j = 0; j < 3; j++) {
                    nums[i + j] = nums[i + j] == 0 ? 1 : 0;
                }

                count++;
            }
        }

        for (int i = 0; i < n; i++) {
            if (nums[i] == 0) {
                return -1;
            }
        }

        return count;
    }
};
