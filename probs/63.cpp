#include <vector>
using namespace std;

class Solution {
public:
    int uniquePathsWithObstacles(vector<vector<int>>& obstacleGrid) {
        int n = obstacleGrid.size();
        int m = obstacleGrid[0].size();

        vector<vector<int> > paths(n, vector<int>(m, 0));
        paths[0][0] = 1;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (i > 0 && obstacleGrid[i - 1][j] == 0) {
                    paths[i][j] += paths[i - 1][j];
                }
                
                if (j > 0 && obstacleGrid[i][j - 1] == 0) {
                    paths[i][j] += paths[i][j - 1];
                }
            }
        }

        return obstacleGrid[n - 1][m - 1] == 1 ? 0 : paths[n - 1][m - 1];
    }
};
