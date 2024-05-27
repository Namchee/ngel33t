#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int specialArray(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());

        for (int i = 0; i <= n; i++) {
            int idx = lower_bound(nums.begin(), nums.end(), i) - nums.begin();

            if (idx != -1) {
                int len = n - idx;

                if (len == i) {
                    return i;
                }
            }   
        }

        return -1;
    }
};
