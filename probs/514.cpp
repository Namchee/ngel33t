#include <vector>
#include <string>
#include <unordered_map>
#include <limits.h>
using namespace std;

class Solution {
public:
    int findRotateSteps(string ring, string key) {
        size = ring.size();
        for (int i = 0; i < size; i++) {
            mp[ring[i]].push_back(i);
        }

        vector<vector<int> > dp(key.size(), vector<int>(ring.size(), -1));

        return solve(key, 0, 0, dp);
    }

private:
    int size;
    unordered_map<char, vector<int> > mp;

    int solve(string& key, int idx, int pos, vector<vector<int> >& dp) {
        if (idx == key.size()) {
            return 0;
        }

        if (dp[idx][pos] != -1) {
            return dp[idx][pos];
        }

        int steps = INT_MAX;
        int target = key[idx];

        for (int i = 0; i < mp[target].size(); i++) {
            int new_pos = mp[target][i];
            int taken = solve(key, idx + 1, new_pos, dp);

            steps = min(steps, 1 + clockwise(pos, new_pos) + taken);
            steps = min(steps, 1 + counter_clockwise(pos, new_pos) + taken);
        }

        return dp[idx][pos] = steps;
    }

    int clockwise(int curr, int new_pos){
        if(new_pos >= curr){
            return new_pos-curr;
        }
        return size - (curr - new_pos);
    }
    int counter_clockwise(int curr, int new_pos){
        if(curr >= new_pos){
            return curr - new_pos;
        }
        return size - (new_pos - curr);
    }
};
