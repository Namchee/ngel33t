#include <vector>
using namespace std;

class Solution {
public:
    vector<vector<int>> findFarmland(vector<vector<int>>& land) {
        vector<vector<int> > result;
        for (int i = 0; i < land.size(); i++) {
            for (int j = 0; j < land[i].size(); j++) {
                pair<int, int> end = findFarthestCorner(land, i, j);

                if (end.first != -1 && end.second != -1) {
                    result.push_back({ i, j, end.first, end.second });
                }
            }
        }

        return result;
    }

private:
    pair<int, int> findFarthestCorner(vector<vector<int> >& land, int x, int y) {
        if (x < 0 || y < 0 || x >= land.size() || y >= land[x].size() || land[x][y] == 0) {
            return { -1, -1 };
        }

        land[x][y] = 0;

        pair<int, int> a = findFarthestCorner(land, x + 1, y);
        pair<int, int> b = findFarthestCorner(land, x, y + 1);
        pair<int, int> c = a.first != -1 && a.second != -1 ? a : b;

        return c.first != -1 && c.second != -1 ? c : pair<int, int>(x, y);
    }
};
