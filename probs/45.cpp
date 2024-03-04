#include <vector>;
using namespace std;

class Solution {
public:
    int jump(vector<int>& nums) {
        vector<int> jumps(nums.size(), 100000);
        jumps[0] = 0;

        for (int i = 0; i < nums.size(); i++) {
            for (int j = 0; j < nums[i] && j + i + 1 < nums.size(); j++) {
                jumps[j + i + 1] = min(jumps[j + i + 1], jumps[i] + 1);
            }
        }

        return jumps[nums.size() - 1];
    }
};
