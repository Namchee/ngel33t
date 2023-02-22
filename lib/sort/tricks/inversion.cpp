#include <vector>
using namespace std;

int merge(int arr[], int l, int m, int r)
{
    int leftLen = m - l + 1;
    int rightLen = r - m;

    int leftArr[leftLen];
    int rightArr[rightLen];

    for (int i = 0; i < leftLen; i++)
    {
        leftArr[i] = arr[i + l];
    }
    for (int i = 0; i < rightLen; i++)
    {
        rightArr[i] = arr[i + m + 1];
    }

    int leftP = 0, rightP = 0, idxArr = l, invCount = 0;

    while (leftP < leftLen && rightP < rightLen)
    {
        if (leftArr[leftP] <= rightArr[rightP])
        {
            arr[idxArr++] = leftArr[leftP++];
        }
        else
        {
            arr[idxArr++] = rightArr[rightP++];
            invCount += m - leftP;
        }
    }

    while (leftP < leftLen)
    {
        arr[idxArr++] = leftArr[leftP++];
    }

    while (rightP < rightLen)
    {
        arr[idxArr++] = rightArr[rightP++];
    }

    return invCount;
}

int mergeSort(int arr[], int l, int r)
{
    if (r <= l)
    {
        return 0;
    }

    int mid = l + (r - l) / 2;
    int leftInversion = mergeSort(arr, l, mid);
    int rightInversion = mergeSort(arr, mid + 1, r);
    int mergeInversion = merge(arr, l, mid, r);

    return leftInversion + rightInversion + mergeInversion;
}

int main()
{
    int arr[] = {1, 20, 6, 4, 5};
    int count = mergeSort(arr, 0, 4);

    printf("%d\n", count);
    for (int i = 0; i < 5; i++)
    {
        printf("%d ", arr[i]);
    }
    return 0;
}