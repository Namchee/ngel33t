#include <vector>
#include <unordered_set>
using namespace std;

class Solution {
public:
    vector<int> findErrorNums(vector<int>& nums) {
        int duplicated = -1;
        int missing = -1;

        unordered_set<int> mp;

        for (int num: nums) {
            if (mp.find(num) != mp.end()) {
                duplicated = num;
            }

            mp.insert(num);
        }

        for (int i = 1; i <= nums.size(); i++) {
            if (mp.find(i) == mp.end()) {
                return { duplicated, i };
            }
        }

        return {};
    }
};
