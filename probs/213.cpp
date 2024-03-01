#include <vector>;
using namespace std;

class Solution {
public:
    int rob(vector<int>& nums) {
        vector<int> acc_with(nums.begin(), nums.end());
        for (int i = 0; i < acc_with.size() - 1; i++) {
            for (int j = 0; j < i - 1; j++) {
                acc_with[i] = max(acc_with[i], nums[i] + acc_with[j]);
            }
        }

        vector<int> acc_without(nums.begin(), nums.end());
        for (int i = 1; i < acc_without.size(); i++) {
            for (int j = 1; j < i - 1; j++) {
                acc_without[i] = max(acc_without[i], nums[i] + acc_without[j]);
            }
        }

        int best = 0;
        for (int i = 0; i < acc_with.size(); i++) {
            best = max(best, acc_with[i]);
            best = max(best, acc_without[i]);
        }

        return best;
    }
};
