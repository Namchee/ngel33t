#include <vector>;
using namespace std;

class Solution {
public:
    int numIslands(vector<vector<char>>& grid) {
        int islands = 0;
        for (int i = 0; i < grid.size(); i++) {
            for (int j = 0; j < grid[i].size(); j++) {
                if (grid[i][j] == '1') {
                    islands++;
                    visit(grid, i, j);
                }
            }
        }

        return islands;
    }

    void visit(vector<vector<char>>& grid, int x, int y) {
        if (x < 0 || x >= grid.size() || y < 0 || y >= grid[0].size() || grid[x][y] == '0') {
            return;
        }

        grid[x][y] = '0';
        visit(grid, x - 1, y);
        visit(grid, x + 1, y);
        visit(grid, x, y - 1);
        visit(grid, x, y + 1);
    }
};
