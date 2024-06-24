#include <vector>
using namespace std;

class Solution {
public:
    int minKBitFlips(vector<int>& nums, int k) {
        int n = nums.size();
        int flipped = 0;
        int count = 0;

        for (int i = 0; i < n; i++) {
            if ((nums[i] + flipped) % 2 == 0) {
                if (i + k > n) {
                    return -1;
                }

                count++;
                flipped++;
                nums[i] = -1;
            }

            if (i + 1 >= k) {
                flipped -= (nums[i - k + 1] < 0);
            }
        }

        return count;
    }
};
