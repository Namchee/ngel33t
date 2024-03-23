#include <vector>
using namespace std;

class Solution {
public:
    vector<vector<int>> permute(vector<int>& nums) {
        vector<vector<int> > result;
        permutation(nums, 0, result);

        return result;
    }
private:
    void permutation(vector<int>& num, int i, vector<vector<int> >& ans) {
        if (i == num.size() - 1) {
            ans.push_back(num);

            return;
        }

        for (int idx = i; idx < num.size(); idx++) {
            swap(num[idx], num[i]);
            permutation(num, i + 1, ans);
            swap(num[idx], num[i]);
        }
    }
};
