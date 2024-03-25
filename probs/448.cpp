#include <vector>
using namespace std;

class Solution {
public:
    vector<int> findDisappearedNumbers(vector<int>& nums) {
        int i = 0;
        while (i < nums.size()) {
            int idx = nums[i] - 1;
            if (nums[idx] != nums[i]) {
                int temp = nums[i];
                nums[i] = nums[idx];
                nums[idx] = temp;
            } else {
                i++;
            }
        }

        vector<int> result;
        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] != i + 1) {
                result.push_back(i + 1);
            }
        }

        return result;
    }
};