#include <vector>
using namespace std;

vector<int> sortArray(vector<int> &nums)
{
    merge_sort(nums, 0, nums.size() - 1);

    return nums;
}

void merge_sort(vector<int> &nums, int begin, int end)
{
    if (begin < end)
    {
        int mid = begin + (end - begin) / 2;
        merge_sort(nums, begin, mid);
        merge_sort(nums, mid + 1, end);
        merge(nums, begin, mid, end);
    }
}

void merge(
    vector<int> &arr,
    int begin,
    int mid,
    int end)
{
    int leftLen = mid - begin + 1;
    int rightLen = end - mid;

    int leftArr[leftLen], rightArr[rightLen];
    for (int i = 0; i < leftLen; i++)
    {
        leftArr[i] = arr[begin + i];
    }
    for (int i = 0; i < rightLen; i++)
    {
        rightArr[i] = arr[mid + 1 + i];
    }

    int leftPt = 0;
    int rightPt = 0;
    int cursor = begin;

    while (leftPt < leftLen && rightPt < rightLen)
    {
        if (leftArr[leftPt] <= rightArr[rightPt])
        {
            arr[cursor++] = leftArr[leftPt++];
        }
        else
        {
            arr[cursor++] = rightArr[rightPt++];
        }
    }

    while (leftPt < leftLen)
    {
        arr[cursor++] = leftArr[leftPt++];
    }

    while (rightPt < rightLen)
    {
        arr[cursor++] = rightArr[rightPt++];
    }
}