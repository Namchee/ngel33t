#include <vector>
#include <algorithm>
#include <set>
using namespace std;

class Solution
{
public:
    vector<vector<int>> subsetsWithDup(vector<int> &nums)
    {
        vector<vector<int>> result;
        sort(nums.begin(), nums.end());
        vector<int> temp;

        generateSubset(0, nums, temp, result);
        set<vector<int>> st;
        for (vector<int> seet : result)
        {
            st.insert(seet);
        }

        vector<vector<int>> actual;
        for (auto seet : st)
        {
            actual.push_back(seet);
        }

        return actual;
    }

private:
    void generateSubset(int idx, vector<int> &nums, vector<int> &curr, vector<vector<int>> &result)
    {
        if (idx == nums.size())
        {
            result.push_back(curr);
        }
        else
        {
            generateSubset(idx + 1, nums, curr, result);
            vector<int> cpy = curr;
            cpy.push_back(nums[idx]);

            generateSubset(idx + 1, nums, cpy, result);
        }
    }
};