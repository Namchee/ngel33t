#include <vector>;
using namespace std;

class Solution {
public:
    int maxAreaOfIsland(vector<vector<int>>& grid) {
        int best = 0;
        for (int i = 0; i < grid.size(); i++) {
            for (int j = 0; j < grid[i].size(); j++) {
                if (grid[i][j] == 1) {
                    int area = traverse(grid, i, j);
                    best = max(best, area);
                }
            }
        }

        return best;
    }

private:
    int traverse(vector<vector<int>>& grid, int x, int y) {
        if (x < 0 || x >= grid.size() || y < 0 || y >= grid[0].size() || grid[x][y] == 0) {
            return 0;
        }

        grid[x][y] = 0;
        return 1 + traverse(grid, x - 1, y) + traverse(grid, x + 1, y) + traverse(grid, x, y - 1) + traverse(grid, x, y + 1);
    }
};
