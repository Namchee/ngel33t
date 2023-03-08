#include <vector>
using namespace std;

bool isMonotonic(vector<int> &nums)
{
    if (nums.size() == 1)
    {
        return true;
    }

    int abs = 0;
    for (int idx = 1; idx < nums.size(); idx++)
    {
        int diff = nums[idx] - nums[idx - 1];
        if (diff != 0)
        {
            abs = diff;
            break;
        }
    }

    if (abs == 0)
    {
        return true;
    }

    for (int i = 2; i < nums.size(); i++)
    {
        if (abs > 0 && nums[i] < nums[i - 1])
        {
            return false;
        }
        else if (abs < 0 && nums[i] > nums[i - 1])
        {
            return false;
        }
    }

    return true;
}