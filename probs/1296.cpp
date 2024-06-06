#include <vector>
#include <map>
using namespace std;

class Solution {
public:
    bool isPossibleDivide(vector<int>& nums, int k) {
        map<int, int> mp;
        for (int num: nums) {
            mp[num]++;
        }

        for (auto const& [num, freq]: mp) {
            while (mp[num]) {
                for (int i = 0; i < k - 1; i++) {
                    int next = num + i + 1;

                    if (mp.find(next) == mp.end() || mp[next] == 0) {
                        return false;
                    }

                    mp[next]--;
                }

                mp[num]--;
            }
        }

        return true;
    }
};
