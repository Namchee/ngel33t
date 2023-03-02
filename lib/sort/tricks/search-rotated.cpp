#include <vector>
#include <iostream>
using namespace std;

int find_pivot(vector<int> &arr)
{
    int lo = 0;
    int hi = arr.size() - 1;

    while (lo <= hi)
    {
        int mid = lo + (hi - lo) / 2;
        if (mid > lo && arr[mid] < arr[mid - 1])
        {
            return mid;
        }

        if (mid < hi && arr[mid + 1] < arr[mid])
        {
            return mid + 1;
        }

        if (arr[lo] >= arr[mid])
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

int binary_search(vector<int> &arr, int key, int lo, int hi)
{
    if (hi < lo)
    {
        return -1;
    }

    int mid = lo + (hi - lo) / 2;
    if (arr[mid] == key)
    {
        return mid;
    }

    if (arr[mid] < key)
    {
        return binary_search(arr, key, mid + 1, hi);
    }

    return binary_search(arr, key, lo, mid - 1);
}

int main()
{
    vector<int> arr = {3, 1};
    int pivot = find_pivot(arr);

    int key;

    cin >> key;

    if (pivot == -1)
    {
        cout << binary_search(arr, key, 0, arr.size() - 1) << "\n";
    }
    else
    {
        if (key == arr[pivot])
        {
            return pivot;
        }

        if (arr[0] <= key)
        {
            cout << binary_search(arr, key, 0, pivot - 1) << "\n";
        }
        else
        {
            cout << binary_search(arr, key, pivot, arr.size() - 1) << "\n";
        }
    }
    return 0;
}