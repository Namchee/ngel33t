#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    bool checkSubarraySum(vector<int>& nums, int k) {
        unordered_map<int, int> mp;
        mp[0] = -1;

        int sum = 0;
        for (int i = 0; i < nums.size(); i++) {
            sum += nums[i];
            if (mp.find(sum % k) != mp.end()) {
                int prev = mp[sum % k];
                if (i - prev >= 2) {
                    return true;
                }
            } else {
                mp[sum % k] = i;
            }
        }

        return false;
    }
};
