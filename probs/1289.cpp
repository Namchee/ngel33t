#include <vector>
#include <limits.h>
using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        for (int i = 1; i < grid.size(); i++) {
            for (int j = 0; j < grid[i].size(); j++) {
                int sum = INT_MAX;
                for (int k = 0; k < grid[i].size(); k++) {
                    if (k != j) {
                        sum = min(sum, grid[i - 1][k]);
                    }
                }

                grid[i][j] += sum;
            }
        }

        int result = INT_MAX;
        for (int i = 0; i < grid[0].size(); i++) {
            result = min(result, grid[grid[0].size() - 1][i]);
        }

        return result;
    }
};
