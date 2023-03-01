#include <vector>
using namespace std;

#define INF 1000000000

int minPathSum(vector<vector<int>> &grid)
{
    for (int i = 0; i < grid.size(); i++)
    {
        for (int j = 0; j < grid[i].size(); j++)
        {
            int temp = grid[i][j];
            int best = INF;

            if (i > 0)
            {
                best = min(best, temp + grid[i - 1][j]);
            }

            if (j > 0)
            {
                best = min(best, temp + grid[i][j - 1]);
            }

            grid[i][j] = i == 0 && j == 0 ? temp : best;
        }
    }

    return grid[grid.size() - 1][grid[0].size() - 1];
}