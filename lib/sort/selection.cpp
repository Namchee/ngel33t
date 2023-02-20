#include <vector>
#include <iostream>
using namespace std;

// Selection sort algorithm
// Time complexity: Theta(n^2)
int main()
{
    vector<int> arr = {5, 3, 4, 2, 1};

    for (int idx = 0; idx < arr.size() - 1; idx++)
    {
        int pivot = idx;

        for (int cursor = idx + 1; cursor < arr.size(); cursor++)
        {
            if (arr[cursor] < arr[pivot])
            {
                pivot = cursor;
            }
        }

        // swap
        int temp = arr[idx];
        arr[idx] = arr[pivot];
        arr[pivot] = temp;
    }

    for (int idx = 0; idx < arr.size(); idx++)
    {
        cout << arr[idx] << endl;
    }

    return 0;
}