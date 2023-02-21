#include <vector>
#include <iostream>
using namespace std;

int findPivot(int arr[], int begin, int end)
{
    int pivot = arr[end];
    int low = begin - 1;

    for (int idx = begin; idx <= end - 1; idx++)
    {
        if (arr[idx] < pivot)
        {
            low++;
            int temp = arr[low];
            arr[low] = arr[idx];
            arr[idx] = temp;
        }
    }

    int temp = arr[low + 1];
    arr[low + 1] = arr[end];
    arr[end] = temp;

    return low + 1;
}

void quickSort(int arr[], int begin, int end)
{
    if (begin < end)
    {
        int pivot = findPivot(arr, begin, end);
        quickSort(arr, begin, pivot - 1);
        quickSort(arr, pivot + 1, end);
    }
}

// Quick sort algorithm
// Time complexity: O(n log n)
int main()
{
    int arr[5] = {5, 3, 4, 2, 1};

    quickSort(arr, 0, 4);

    for (int idx = 0; idx < 5; idx++)
    {
        cout << arr[idx] << endl;
    }

    return 0;
}