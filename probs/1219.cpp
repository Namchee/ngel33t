#include <vector>
using namespace std;

class Solution {
public:
    int getMaximumGold(vector<vector<int>>& grid) {
        int maxi = 0;

        for (int i = 0; i < grid.size(); i++) {
            for (int j = 0; j < grid[i].size(); j++) {
                if (grid[i][j]) {
                    vector<vector<bool> > visit(grid.size(), vector<bool>(grid[0].size(), false));
                    visit[i][j] = true;

                    maxi = max(maxi, simulate(grid, i, j, visit, grid[i][j]));
                }
            }
        }

        return maxi;
    }

private:
    int simulate(vector<vector<int>>& grid, int i, int j, vector<vector<bool> >& visit, int score) {
        int maxi = score;

        if (i > 0 && grid[i - 1][j] != 0 && !visit[i - 1][j]) {
            visit[i - 1][j] = true;
            maxi = max(maxi, simulate(grid, i - 1, j, visit, score + grid[i - 1][j]));
            visit[i - 1][j] = false;
        }

        if (i < grid.size() - 1 && grid[i + 1][j] != 0 && !visit[i + 1][j]) {
            visit[i + 1][j] = true;
            maxi = max(maxi, simulate(grid, i + 1, j, visit, score + grid[i + 1][j]));
            visit[i + 1][j] = false;
        }

        if (j > 0 && grid[i][j - 1] != 0 && !visit[i][j - 1]) {
            visit[i][j - 1] = true;
            maxi = max(maxi, simulate(grid, i, j - 1, visit, score + grid[i][j - 1]));
            visit[i][j - 1] = false;
        }

        if (j < grid[i].size() - 1 && grid[i][j + 1] != 0 && !visit[i][j + 1]) {
            visit[i][j + 1] = true;
            maxi = max(maxi, simulate(grid, i, j + 1, visit, score + grid[i][j + 1]));
            visit[i][j + 1] = false;
        }

        return maxi;
    }
};
