#include <vector>;
using namespace std;

class Solution {
public:
    int rob(vector<int>& nums) {
        vector<int> acc(nums.begin(), nums.end());
        for (int i = 0; i < acc.size(); i++) {
            for (int j = 0; j < i - 1; j++) {
                acc[i] = max(acc[i], nums[i] + acc[j]);
            }
        }

        int best = 0;
        for (int i = 0; i < acc.size(); i++) {
            best = max(best, acc[i]);
        }

        return best;
    }
};
