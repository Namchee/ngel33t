#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int minIncrementForUnique(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        unordered_map<int, int> mp;

        int n = nums.size();
        int sum = 0;

        for (int i = 0; i < n; i++) {
            if (mp.find(nums[i]) == mp.end()) {
                mp[nums[i]] = i;
            } else {
                int inc = i - mp[nums[i]];
                sum += inc;

                mp[nums[i] + inc] = i;
            }
        }

        return sum;
    }
};
