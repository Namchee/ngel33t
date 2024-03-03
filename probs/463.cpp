#include <vector>
using namespace std;

class Solution {
public:
    int islandPerimeter(vector<vector<int>>& grid) {
        int sides = 0;

        for (int i = 0; i < grid.size(); i++) {
            for (int j = 0; j < grid[i].size(); j++) {
                if (grid[i][j] == 1) {
                    int new_side = 4;
                    if (i - 1 >= 0 && grid[i - 1][j] == 1) new_side--;
                    if (j - 1 >= 0 && grid[i][j - 1] == 1) new_side--;
                    if (i + 1 < grid.size() && grid[i + 1][j] == 1) new_side--;
                    if (j + 1 < grid[i].size() && grid[i][j + 1] == 1) new_side--;

                    sides += new_side;
                }
            }
        }
        return sides;
    }
};
