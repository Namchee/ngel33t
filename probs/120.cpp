#include <vector>
using namespace std;

#define INF 1000000000

int minimumTotal(vector<vector<int>> &triangle)
{
    vector<vector<int>> memo;

    for (int i = 0; i < triangle.size(); i++)
    {
        memo.push_back(
            vector<int>(triangle[i].size(), INF));
    }

    memo[0][0] = triangle[0][0];

    for (int i = 1; i < memo.size(); i++)
    {
        for (int j = 0; j < memo[i].size(); j++)
        {
            if (j > 0)
            {
                memo[i][j] = min(
                    memo[i][j],
                    triangle[i][j] + memo[i - 1][j - 1]);
            }

            if (j < memo[i - 1].size())
            {
                memo[i][j] = min(memo[i][j], triangle[i][j] + memo[i - 1][j]);
            }
        }
    }

    int best = INF;

    for (int i = 0; i < memo[memo.size() - 1].size(); i++)
    {
        best = min(best, memo[memo.size() - 1][i]);
    }

    return best;
}

int main()
{
    vector<vector<int>> triangle = {
        {2},
        {3, 4},
        {6, 5, 7},
        {4, 1, 8, 3}};

    int best = minimumTotal(triangle);

    printf("%d\n", best);
    return 0;
}