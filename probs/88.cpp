#include <vector>
#include <iostream>
#include <string>
using namespace std;

void merge(vector<int> &nums1, int m, vector<int> &nums2, int n)
{
    int p_one = m - 1;
    int p_two = n - 1;
    int tot = m + n - 1;

    while (p_one >= 0 && p_two >= 0)
    {
        if (nums1[p_one] > nums2[p_two])
        {
            nums1[tot--] = nums1[p_one--];
        }
        else
        {
            nums1[tot--] = nums2[p_two--];
        }
    }

    while (p_two >= 0)
    {
        nums1[tot--] = nums2[p_two--];
    }
}

int main()
{
    vector<int> nums1 = {1, 2, 3, 0, 0, 0};
    vector<int> nums2 = {2, 5, 6};

    int n = 3;
    int m = 3;

    merge(nums1, n, nums2, m);
    return 0;
}