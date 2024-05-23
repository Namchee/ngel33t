#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int beautifulSubsets(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        result = 0;

        backtrack(0, 0, nums, k);

        return result;
    }

private:
    int result;

    void backtrack(int curr, int bitmask, vector<int>& nums, int k) {
        if (curr == nums.size()) {
            if (bitmask != 0) {
                result++;
            }
        } else {
            backtrack(curr + 1, bitmask, nums, k);

            bool canPick = true;
            for (int i = 0; i < curr; ++i) {
                if ((bitmask & (1 << i)) && nums[curr] == nums[i] + k) {
                    canPick = false;
                    break;
                }
            }

            if (canPick) {
                backtrack(curr + 1, bitmask | (1 << curr), nums, k);
            }
        }
    }
};
