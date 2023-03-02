#include <vector>
using namespace std;

int findJudge(int n, vector<vector<int>> &trust)
{
    int count[n];
    int ref[n];

    for (int i = 0; i < n; i++)
    {
        count[i] = 0;
        ref[i] = -1;
    }

    for (int i = 0; i < trust.size(); i++)
    {
        int from = trust[i][0] - 1;
        int to = trust[i][1] - 1;

        count[to]++;
        ref[from] = to;
    }

    for (int i = 0; i < n; i++)
    {
        if (count[i] == n - 1 && ref[i] == -1)
        {
            return i + 1;
        }
    }

    return -1;
}