#include <vector>
using namespace std;

int pivotIndex(vector<int> &nums)
{
    vector<int> prefix(nums.size(), nums[0]);
    for (int i = 1; i < nums.size(); i++)
    {
        prefix[i] = nums[i] + prefix[i - 1];
    }

    for (int i = 0; i < prefix.size(); i++)
    {
        int left_sum = 0;
        if (i > 0)
        {
            left_sum = prefix[i - 1];
        }

        int right_sum = prefix[prefix.size() - 1] - prefix[i];

        if (left_sum == right_sum)
        {
            return i;
        }
    }

    return -1;
}