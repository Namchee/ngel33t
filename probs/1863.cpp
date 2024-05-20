#include <vector>
using namespace std;

class Solution
{
public:
    int subsetXORSum(vector<int> &nums)
    {
        int sum = 0;
        vector<int> place;

        backtrack(0, sum, nums, place);

        return sum;
    }

private:
    void backtrack(int idx, int &sum, vector<int> &nums, vector<int> &picks)
    {
        if (idx == nums.size())
        {
            int temp = picks.size() > 0 ? picks[0] : 0;
            for (int i = 1; i < picks.size(); i++)
            {
                temp ^= picks[i];
            }

            sum += temp;
        }
        else
        {
            backtrack(idx + 1, sum, nums, picks);
            vector<int> picked = picks;
            picked.push_back(nums[idx]);

            backtrack(idx + 1, sum, nums, picked);
        }
    }
};