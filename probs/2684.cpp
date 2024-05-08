#include <vector>
#include <algorithm>
using namespace std;

class Solution
{
public:
    int maxMoves(vector<vector<int>> &g)
    {
        int m = g.size();
        int n = g[0].size();

        vector<vector<int>> matrix(2, vector<int>(m));

        for (int c = n - 2; c >= 0; --c)
            for (int r = 0; r < m; ++r)
            {
                int c0 = c % 2, c1 = (c + 1) % 2;
                matrix[c0][r] = g[r][c + 1] > g[r][c] ? 1 + matrix[c1][r] : 0;
                if (r > 0 && g[r - 1][c + 1] > g[r][c])
                    matrix[c0][r] = max(matrix[c0][r], 1 + matrix[c1][r - 1]);
                if (r + 1 < m && g[r + 1][c + 1] > g[r][c])
                    matrix[c0][r] = max(matrix[c0][r], 1 + matrix[c1][r + 1]);
            }
        return *max_element(begin(matrix[0]), end(matrix[0]));
    }
};