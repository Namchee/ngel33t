#include <iostream>
#include <vector>
using namespace std;

#define MIN -1000000000

// Kadane's algorithm
// Max 1D array sum
// Only works if at least one of the numbers is positive
// If there's none, the answer is always the most positive one or empty, actually
//
// Time complexity: O(n)
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    vector<int> arr = {-2, -3, 4, -1, -2, 1, 5, -3};

    int best = MIN;
    int acc = 0;

    int start = 0, end = 0, s = 0;

    for (int i = 0; i < arr.size(); i++)
    {
        acc += arr[i];
        if (acc > best)
        {
            best = acc;
            end = i;
            start = s;
        }

        if (acc < 0)
        {
            acc = 0;
            s = i + 1;
        }
    }

    return 0;
}