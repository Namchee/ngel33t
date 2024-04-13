#include <vector>
#include <stack>
using namespace std;

class Solution {
public:
    int maximalRectangle(vector<vector<char>>& matrix) {
        int result = 0;
        vector<int> histogram(matrix[0].size());
        
        for (auto row: matrix) {
            for (int i = 0; i < row.size(); i++) {
                histogram[i] = row[i] == '0' ? 0 : histogram[i] + 1;
            }

            result = max(result, getLargestArea(histogram));
        }

        return result;
    }

private:
    int getLargestArea(vector<int>& histogram) {
        int result = 0;
        stack<int> stk;

        for (int i = 0; i <= histogram.size(); i++) {
            while (!stk.empty() && (i == histogram.size() || histogram[stk.top()] > histogram[i])) {
                int height = histogram[stk.top()];
                stk.pop();
                int len = stk.empty() ? i : i - stk.top() - 1;
                result = max(result, height * len);
            }
            stk.push(i);
        }

        return result;
    }
};
