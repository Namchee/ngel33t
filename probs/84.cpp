#include <vector>
#include <stack>
using namespace std;

class Solution {
public:
    int largestRectangleArea(vector<int>& heights) {
        int result = 0;
        int n = heights.size();

        stack<pair<int, int> > stk;

        for (int i = 0; i < n; i++) {
            int start = i;

            while (!stk.empty() && heights[i] <= stk.top().second) {
                pair<int, int> top = stk.top();
                result = max(result, top.second * (i - top.first));
                start = top.first;
                stk.pop();
            }

            stk.push({ start, heights[i] });
        }

        while (!stk.empty()) {
            pair<int, int> top = stk.top();
            result = max(result, (n - top.first) * top.second);

            stk.pop();
        }

        return result;
    }
};
