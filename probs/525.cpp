#include <vector>;
#include <unordered_map>;
using namespace std;

class Solution {
public:
    int findMaxLength(vector<int>& nums) {
        int best = 0;
        int sum = 0;

        int n = nums.size();
        unordered_map<int, int> mp;
        for (int i = 0; i < n; i++) {
            sum += nums[i] == 0 ? -1 : 1;
            if (sum == 0) {
                best = i + 1;
            } else if (mp.find(sum) != mp.end()) {
                best = max(best, i - mp[sum]);
            } else {
                mp[sum] = i;
            }
        }

        return best;
    }
};
