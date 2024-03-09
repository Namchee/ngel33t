#include <vector>;
#include <map>;
#include <string>;
using namespace std;

class Solution {
public:
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        map<vector<int>, vector<string> > mp;

        for (int i = 0; i < strs.size(); i++) {
            vector<int> freq(26);

            for (int j = 0; j < strs[i].size(); j++) {
                freq[strs[i][j] - 'a']++;
            }

            mp[freq].push_back(strs[i]);
        }

        vector<vector<string> > result;
        for (auto& [_, value]: mp) {
            result.push_back(value);
        }

        return result;
    }
};
