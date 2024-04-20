#include <vector>
using namespace std;

class Solution {
public:
    int countSubIslands(vector<vector<int>>& grid1, vector<vector<int>>& grid2) {
        int count = 0;
        for (int i = 0; i < grid2.size(); i++) {
            for (int j = 0; j < grid2[i].size(); j++) {
                if (grid2[i][j] == 1) {
                    count += traverse(grid1, grid2, i, j);
                }
            }
        }

        return count;
    }

private:
    bool traverse(vector<vector<int> >& a, vector<vector<int> >& b, int x, int y) {
        if (x < 0 || y < 0 || x >= a.size() || y >= a[x].size() || b[x][y] == 0) {
            return true;
        }

        if (a[x][y] == 0) {
            return false;
        }

        b[x][y] = 0;

        bool one = traverse(a, b, x + 1, y);
        bool two = traverse(a, b, x, y + 1);
        bool three = traverse(a, b, x - 1, y);
        bool four = traverse(a, b, x, y - 1);
        
        return one && two && three && four;
    }
};
