#include <vector>
using namespace std;

int maxSubArray(vector<int> &nums)
{
    int best = -100000;
    int acc = 0;

    for (int i = 0; i < nums.size(); i++)
    {
        acc += nums[i];
        best = max(best, acc);
        acc = max(acc, 0);
    }

    return best;
}