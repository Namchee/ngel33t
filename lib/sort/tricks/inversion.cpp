#include <vector>
using namespace std;

int merge(int arr[], int l, int m, int r)
{
    int left = l, mid = m, tempCt = 0;
    int invCount = 0;
    int temp[(r - left + 1)];

    while ((left < mid) && (mid <= r))
    {
        if (arr[left] <= arr[mid])
        {
            temp[tempCt++] = arr[left++];
        }
        else
        {
            invCount += (mid - left);
            temp[tempCt++] = arr[mid++];
        }
    }

    while (left < mid)
    {
        temp[tempCt++] = arr[left++];
    }

    while (mid <= r)
    {
        temp[tempCt++] = arr[mid++];
    }

    for (int i = l, k = 0; i <= r; i++, k++)
    {
        arr[i] = temp[k];
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
    int mergeInversion = merge(arr, l, mid + 1, r);

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