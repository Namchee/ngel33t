#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int findCenter(vector<vector<int>>& edges) {
        unordered_map<int, int> mp;
        for (vector<int> pair: edges) {
            mp[pair[0]]++;
            mp[pair[1]]++;
        }

        int sz = mp.size();
        for (auto it: mp) {
            if (it.second == sz - 1) {
                return it.first;
            }
        }

        return -1;
    }
};
