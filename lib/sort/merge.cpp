#include <vector>
#include <iostream>
using namespace std;

void merge(int arr[], int begin, int mid, int end)
{
    int lenLeft = mid - begin + 1;
    int lenRight = end - mid;

    int leftArr[lenLeft];
    int rightArr[lenRight];

    for (int idx = 0; idx < lenLeft; idx++)
    {
        leftArr[idx] = arr[begin + idx];
    }
    for (int idx = 0; idx < lenRight; idx++)
    {
        rightArr[idx] = arr[mid + 1 + idx];
    }

    int leftIdx = 0;
    int rightIdx = 0;
    int cursor = 0;

    while (leftIdx < lenLeft && rightIdx < lenRight)
    {
        if (leftArr[leftIdx] < rightArr[rightIdx])
        {
            arr[cursor] = leftArr[leftIdx];
            leftIdx++;
        }
        else
        {
            arr[cursor] = rightArr[rightIdx];
            rightIdx++;
        }

        cursor++;
    }

    while (leftIdx < lenLeft)
    {
        arr[cursor] = leftArr[leftIdx];
        cursor++;
        leftIdx++;
    }

    while (rightIdx < lenRight)
    {
        arr[cursor] = rightArr[rightIdx];
        cursor++;
        rightIdx++;
    }
}

void mergeSort(int arr[], int begin, int end)
{
    if (begin >= end)
    {
        return;
    }

    int mid = (begin + end) / 2;
    mergeSort(arr, begin, mid);
    mergeSort(arr, mid + 1, end);
    merge(arr, begin, mid, end);
}

// Merge sort algorithm
// Time complexity: Theta(n log n)
int main()
{
    int arr[5] = {5, 3, 4, 2, 1};

    mergeSort(arr, 0, 5);

    for (int idx = 0; idx < 5; idx++)
    {
        cout << arr[idx] << endl;
    }

    return 0;
}