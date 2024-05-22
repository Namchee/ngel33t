#include <vector>
#include <algorithm>
using namespace std;

class Solution
{
public:
    int minMoves2(vector<int> &nums)
    {
        sort(nums.begin(), nums.end());
        int target;
        if (nums.size() & 1)
        {
            target = nums[nums.size() / 2];
        }
        else
        {
            target = (nums[nums.size() / 2] + nums[(nums.size() / 2) - 1]) / 2;
        }

        int steps = 0;
        for (int num : nums)
        {
            steps += abs(num - target);
        }

        return steps;
    }
};