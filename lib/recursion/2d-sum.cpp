#include <iostream>
#include <vector>
using namespace std;

#define MIN -1000000000

// Max 2D array sum
//
// Time complexity: O(n ^ 4)
int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int arr[5][5];

    int best = 0;

    // prepare the matrix
    for (int i = 0; i < 5; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            if (i > 0)
                arr[i][j] += arr[i - 1][j];
            if (j > 0)
                arr[i][j] += arr[i][j - 1];
            if (i > 0 && j > 0)
                arr[i][j] -= arr[i - 1][j - 1]; // because we double count this
        }
    }

    for (int i = 0; i < 5; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            for (int k = i; k < 5; k++)
            {
                for (int l = j; l < 5; l++)
                {
                    int sub_array = arr[k][l];
                    if (i > 0)
                    {
                        sub_array -= arr[i - 1][l];
                    }
                    if (j > 0)
                    {
                        sub_array -= arr[k][j - 1];
                    }
                    if (i > 0 && j > 0)
                    {
                        sub_array += arr[i - 1][j - 1]; // we are substracting twice!
                    }

                    best = max(best, sub_array);
                }
            }
        }
    }

    cout << best << "\n";
}