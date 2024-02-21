#include <vector>;
#include <limits>;
using namespace std;
class Solution {
public:
    int maxProduct(vector<int>& nums) {
        int result = -999999999;

        int acc = 1;

        for (int i = 0; i < nums.size(); i++) {
            acc *= nums[i];
            result = max(result, acc);
            if (acc == 0) {
                acc = 1;
            }
        }

        acc = 1;

        for (int i = nums.size() - 1; i >= 0; i--) {
            acc *= nums[i];
            result = max(result, acc);
            if (acc == 0) {
                acc = 1;
            }
        }

        return result;
    }
};
