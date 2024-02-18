#include <unordered_map>;
#include <unordered_set>;
#include <vector>;
using namespace std;

class Solution {
public:
    int findEntry(unordered_map<int, vector<int> > mp) {
        for (auto it = mp.begin(); it != mp.end(); it++) {
            if (it->second.size() == 1) {
                return it->first;
            }
        }

        return -1;
    }

    vector<int> restoreArray(vector<vector<int>>& adjacentPairs) {
        unordered_map<int, vector<int> > mp;

        for (int idx = 0; idx < adjacentPairs.size(); idx++) {
            int a = adjacentPairs[idx][0];
            int b = adjacentPairs[idx][1];

            if (mp.find(a) == mp.end()) {
                mp[a] = {};
            }

            if (mp.find(b) == mp.end()) {
                mp[b] = {};
            }

            mp[a].push_back(b);
            mp[b].push_back(a);
        }

        // traverse the graph
        int curr = findEntry(mp), prev = -100001;
        vector<int> nums;
        while (nums.size() < mp.size()) {
            nums.push_back(curr);
            for (auto& next : mp[curr]) {
                if (next != prev) {
                    prev = curr;
                    curr = next;
                    break;
                }
            }
        }

        return nums;
    }
};
