#include <vector>
#include <iostream>
using namespace std;

// Insertion sort algorithm
// Time complexity: O(n^2)
int main()
{
    vector<int> arr = {5, 3, 4, 2, 1};

    for (int idx = 1; idx < arr.size(); idx++)
    {
        int val = arr[idx];
        int cursor = idx - 1;

        while (cursor >= 0 && arr[cursor] > val)
        {
            arr[cursor + 1] = arr[cursor];
            cursor--;
        }

        arr[cursor + 1] = val;
    }

    for (int idx = 0; idx < arr.size(); idx++)
    {
        cout << arr[idx] << endl;
    }

    return 0;
}