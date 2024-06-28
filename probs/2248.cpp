#include <vector>
using namespace std;

class Solution {
public:
    vector<int> intersection(vector<vector<int>>& nums) {
        vector<int> freq(1001, 0);

        for (vector<int> n: nums) {
            for (int num: n) {
                freq[num]++;
            }
        }

        vector<int> result;

        for (int i = 0; i < 1001; i++) {
            if (freq[i] == nums.size()) {
                result.push_back(i);
            }
        }

        return result;
    }
};
