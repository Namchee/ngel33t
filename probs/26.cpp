#include <vector>
using namespace std;

int removeDuplicates(vector<int> &nums)
{
    int idx = 0;
    int prev = -101;

    for (int i = 0; i < nums.size(); i++)
    {
        if (nums[i] != prev)
        {
            nums[idx] = nums[i];
            prev = nums[i];
            idx++;
        }
    }

    return idx;
}