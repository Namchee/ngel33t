#include <vector>
using namespace std;

class Solution
{
public:
    vector<vector<int>> subsets(vector<int> &nums)
    {
        vector<vector<int>> result;
        vector<int> temp;

        generateSubset(0, nums, temp, result);

        return result;
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