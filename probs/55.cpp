#include <vector>;
using namespace std;

class Solution {
public:
    bool canJump(vector<int>& nums) {
        bool canJump[nums.size()];
        for (int idx = 0; idx < nums.size(); idx++) {
            canJump[idx] = false;
        }
        canJump[0] = true;

        for (int idx = 0; idx < nums.size(); idx++) {
            if (!canJump[idx]) {
                continue;
            }

            for (int range = 0; idx + range < nums.size() - 1 && range < nums[idx]; range++) {
                canJump[idx + range + 1] = true;
            }

            if (canJump[nums.size() - 1]) {
                break;
            }
        }

        return canJump[nums.size() - 1];
    }
};
