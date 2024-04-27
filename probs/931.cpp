#include <vector>
#include <limits.h>
using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& matrix) {
        for (int i = 1; i < matrix.size(); i++) {
            for (int j = 0; j < matrix[i].size(); j++) {
                int sum = INT_MAX;

                for (int k = -1; k <= 1; k++) {
                    if (j + k >= 0 && j + k < matrix.size()) {
                        sum = min(sum, matrix[i - 1][j + k]);
                    }
                }

                matrix[i][j] += sum;
            }
        }

        int result = INT_MAX;

        for (int i = 0; i < matrix[0].size(); i++) {
            result = min(result, matrix[matrix.size() - 1][i]);
        }

        return result;
    }
};
