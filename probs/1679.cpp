#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxOperations(vector<int>& nums, int k) {
        int ct = 0;
        sort(nums.begin(), nums.end());

        int l = 0;
        int r = nums.size() - 1;
        while (l < r) {
            int sum = nums[l] + nums[r];

            if (sum == k) {
                ct++;
                l++;
                r--;
            } else if (sum < k) {
                l++;
            } else {
                r--;
            }
        }

        return ct;
    }
};
