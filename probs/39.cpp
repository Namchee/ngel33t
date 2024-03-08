#include <vector>;
using namespace std;

class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int> > result;
        vector<int> temp;

        brute(candidates, temp, target, 0, result);

        return result;
    }

    void brute(
        vector<int>& candidates,
        vector<int>& curr,
        int target,
        int start,
        vector<vector<int> >& result
    ) {
        int sum = 0;
        for (int idx = 0; idx < curr.size(); idx++) {
            sum += curr[idx];
        }

        if (sum > target) {
            return;
        }

        if (sum == target) {
            result.push_back(curr);
            return;
        }

        for (int idx = start; idx < candidates.size(); idx++) {
            curr.push_back(candidates[idx]);

            brute(candidates, curr, target, idx, result);

            curr.pop_back();
        }
    }
};
