#include <vector>
using namespace std;

int search(vector<int> &nums, int target)
{
    int pivot = find_pivot(nums);
    if (pivot == -1)
    {
        return binary_search(nums, 0, nums.size() - 1, target);
    }

    if (target == nums[pivot])
    {
        return pivot;
    }

    if (nums[0] <= target)
    {
        return binary_search(nums, 0, pivot - 1, target);
    }

    return binary_search(nums, pivot, nums.size() - 1, target);
}

int binary_search(vector<int> &nums, int lo, int hi, int key)
{
    if (lo > hi)
    {
        return -1;
    }

    int mid = lo + (hi - lo) / 2;
    if (nums[mid] == key)
    {
        return mid;
    }

    if (nums[mid] < key)
    {
        return binary_search(nums, mid + 1, hi, key);
    }

    return binary_search(nums, lo, mid - 1, key);
}

int find_pivot(vector<int> &nums)
{
    int lo = 0;
    int hi = nums.size() - 1;

    while (lo < hi)
    {
        int mid = lo + (hi - lo) / 2;
        if (mid < hi && nums[mid + 1] < nums[mid])
        {
            return mid + 1;
        }

        if (mid > lo && nums[mid - 1] > nums[mid])
        {
            return mid;
        }

        if (nums[lo] >= nums[mid])
        {
            hi = mid - 1;
        }
        else
        {
            lo = mid + 1;
        }
    }

    return -1;
}