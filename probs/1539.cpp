#include <unordered_set>
#include <vector>
using namespace std;

int findKthPositive(vector<int> &arr, int k)
{
    unordered_set<int> el;
    for (int i = 0; i < arr.size(); i++)
    {
        el.insert(arr[i]);
    }

    int e = 1;
    int nth = 0;
    while (true)
    {
        if (el.find(e) == el.end())
        {
            nth++;

            if (nth == k)
            {
                return e;
            }
        }

        e++;
    }

    return -1;
}