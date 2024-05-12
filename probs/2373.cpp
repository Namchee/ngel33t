#include <vector>
#include <climits>
using namespace std;

class Solution {
public:
    vector<vector<int>> largestLocal(vector<vector<int>>& grid) {
        vector<vector<int> > result(grid.size() - 2, vector<int>(grid[0].size() - 2));

        for (int i = 0; i < grid.size() - 2; i++) {
            for (int j = 0; j < grid[i].size() - 2; j++) {
                int maxi = INT_MIN;

                for (int k = 0; k <= 2; k++) {
                    for (int l = 0; l <= 2; l++) {
                        maxi = max(maxi, grid[i + k][j + l]);
                    }
                }

                result[i][j] = maxi;
            }
        }

        return result;
    }
};
