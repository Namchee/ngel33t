#include <vector>
using namespace std;

class Solution {
public:
    int orangesRotting(vector<vector<int>>& grid) {
        int minutes = 0;

        while (hasFreshFruit(grid)) {
            vector<pair<int, int> > changes;
            vector<pair<int, int> > sources;

            for (int i = 0; i < grid.size(); i++) {
                for (int j = 0; j < grid[i].size(); j++) {
                    if (grid[i][j] == 2) {
                        sources.push_back({ i, j });
                        if (i - 1 >= 0 && grid[i - 1][j] == 1) {
                            changes.push_back({ i - 1, j });
                        }

                        if (i + 1 < grid.size() && grid[i + 1][j] == 1) {
                            changes.push_back({ i + 1, j });
                        }

                        if (j - 1 >= 0 && grid[i][j - 1] == 1) {
                            changes.push_back({ i, j - 1 });
                        }

                        if (j + 1 < grid[i].size() && grid[i][j + 1] == 1) {
                            changes.push_back({ i, j + 1 });
                        }
                    }
                }
            }

            if (changes.empty()) {
                return -1;
            }

            minutes++;
            for (pair<int, int> src: sources) {
                grid[src.first][src.second] = -1;
            }

            for (pair<int, int> ef: changes) {
                grid[ef.first][ef.second] = 2;
            }
        }

        return minutes;
    }

private:
    bool hasFreshFruit(vector<vector<int> >& grid) {
        for (int i = 0; i < grid.size(); i++) {
            for (int j = 0; j < grid[i].size(); j++) {
                if (grid[i][j] == 1) {
                    return true;
                }
            }
        }

        return false;
    }
};
