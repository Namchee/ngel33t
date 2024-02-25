#include <vector>;
#include <climits>;
using namespace std;

class Solution {
public:
    vector<int> majorityElement(vector<int>& nums) {
        int cand_1 = INT_MIN;
        int cand_2 = INT_MIN;
        int count_1 = 0;
        int count_2 = 0;

        for (int i = 0; i < nums.size(); i++) {
            if (cand_1 == nums[i]) {
                count_1++;
            } else if (cand_2 == nums[i]) {
                count_2++;
            } else if (count_1 == 0) {
                count_1 = 1;
                cand_1 = nums[i];
            } else if (count_2 == 0) {
                count_2 = 1;
                cand_2 = nums[i];
            } else {
                count_1--;
                count_2--;
            }
        }

        count_1 = 0;
        count_2 = 0;

        for (int i = 0; i < nums.size(); i++) {
            if (nums[i] == cand_1) {
                count_1++;
            }

            if (nums[i] == cand_2) {
                count_2++;
            }
        }

        vector<int> result;
        if (count_1 > nums.size() / 3) {
            result.push_back(cand_1);
        }

        if (count_2 > nums.size() / 3) {
            result.push_back(cand_2);
        }

        return result;
    }
};
