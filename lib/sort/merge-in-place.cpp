#include <iostream>
using namespace std;

void merge(int arr[], int begin, int mid, int end)
{
    int cursor = mid + 1;
    if (arr[mid] <= arr[cursor])
    { // has been sorted
        return;
    }

    while (begin <= mid && cursor <= end)
    {
        if (arr[begin] <= arr[cursor])
        {
            begin++; // right place
        }
        else
        {
            int value = arr[cursor];
            int index = cursor;

            while (index != begin)
            {
                arr[index] = arr[index - 1];
                index--;
            }

            arr[begin] = value;

            begin++;
            cursor++;
            mid++;
        }
    }
}

void merge_sort(int arr[], int begin, int end)
{
    if (begin < end)
    {
        int mid = begin + (end - begin) / 2;
        merge_sort(arr, begin, mid);
        merge_sort(arr, mid + 1, end);
        merge(arr, begin, mid, end);
    }
}

int main()
{
    int arr[] = {5, 2, 3, 1};

    merge_sort(arr, 0, 4);

    for (int i = 0; i < 4; i++)
    {
        cout << arr[i] << " ";
    }
}