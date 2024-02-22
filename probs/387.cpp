#include <string>;
#include <vector>;
#include <unordered_map>;
using namespace std;

class Solution {
public:
    int firstUniqChar(string s) {
        unordered_map<char, vector<int> > mp;

        for (int i = 0; i < s.length(); i++) {
            if (mp.find(s[i]) == mp.end()) {
                mp[s[i]] = {};
            }

            mp[s[i]].push_back(i);
        }

        int best = s.size();

        for (auto& [c, pos]: mp) {
            if (pos.size() == 1) {
                best = min(best, pos[0]);
            }
        }

        if (best == s.size()) {
            return -1;
        }

        return best;
    }
};
