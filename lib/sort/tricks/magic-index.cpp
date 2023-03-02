#include <vector>
#include <iostream>
using namespace std;

int binary_search(vector<int> &arr, int lo, int hi)
{
    if (hi < lo)
    {
        return -1;
    }

    int mid = lo + (hi - lo) / 2;
    if (arr[mid] == mid)
    {
        return mid;
    }

    if (arr[mid] < mid)
    {
        return binary_search(arr, mid + 1, hi);
    }

    return binary_search(arr, lo, mid - 1);
}

int main()
{
    vector<int> arr = {7, 8, 9, 1, 2, 3, 4, 6};

    cout << binary_search(arr, 0, arr.size() - 1) << "\n";

    return 0;
}