#include <vector>
using namespace std;

int searchInsert(vector<int> &nums, int target)
{
    int lo = 0;
    int hi = nums.size() - 1;

    while (hi > lo)
    {
        int mid = lo + (hi - lo) / 2;
        if (nums[mid] == target)
        {
            return mid;
        }

        if (nums[mid] < target)
        {
            lo = mid + 1;
        }
        else
        {
            hi = mid - 1;
        }
    }

    int mid = lo + (hi - lo) / 2;
    if (nums[mid] >= target)
    {
        return mid;
    }

    return mid + 1;
}