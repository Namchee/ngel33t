#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    vector<vector<int>> divideArray(vector<int>& nums, int k) {
        int n = nums.size();

        sort(nums.begin(), nums.end());

        vector<vector<int> > result;
        vector<int> temp;

        int prev = 0;

        for (int num: nums) {
            if (prev == 0 || num - prev <= k) {
                temp.push_back(num);
                prev = num;

                if (temp.size() == 3) {
                    if (temp[2] - temp[0] > k) {
                        return {};
                    }

                    result.push_back(temp);
                    temp.clear();
                    prev = 0;
                }
            } else {
                return {};
            }
        }

        return result;
    }
};
