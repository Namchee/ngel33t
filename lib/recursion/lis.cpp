#include <vector>
#include <iostream>
#include <cmath>
using namespace std;

int main()
{
    vector<int> arr = {50, 3, 10, 7, 40, 80};
    vector<int> lis(arr.size(), 1); // the LIS in point `x`, is itself

    int best = 1;

    for (int i = 0; i < arr.size(); i++)
    {
        for (int j = i + 1; j < arr.size(); j++)
        {
            if (arr[j] > arr[i])
            {
                lis[j] = max(lis[j], lis[i] + 1);
                best = max(lis[j], best);
            }
        }
    }

    cout << best << "\n";
    return 0;
}