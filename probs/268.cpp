#include <vector>;
using namespace std;

class Solution {
public:
    int missingNumber(vector<int>& nums) {
        int freq[nums.size() + 1];
        for (int idx = 0; idx < nums.size() + 1; idx++) {
            freq[idx] = 0;
        }

        for (int idx = 0; idx < nums.size(); idx++) {
            freq[nums[idx]]++;
        }

        for (int idx = 0; idx < nums.size() + 1; idx++) {
            if (freq[idx] == 0) {
                return idx;
            }
        }

        return -1;
    }
};
