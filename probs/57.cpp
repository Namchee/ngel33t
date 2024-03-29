#include <vector>;
#include <algorithm>;
using namespace std;

class Solution {
public:
    vector<vector<int>> insert(vector<vector<int>>& intervals, vector<int>& newInterval) {
        if (intervals.size() == 0) {
            return { newInterval };
        }

        intervals.push_back(newInterval);
        sort(intervals.begin(), intervals.end());

        vector<vector<int> > result;

        int start = intervals[0][0];
        int end = intervals[0][1];

        for (int i = 1; i < intervals.size(); i++) {
            int a = intervals[i][0];
            int b = intervals[i][1];

            // this new interval is smaller, or same
            if (a >= start && a <= end && b >= start && b <= end) {
                continue;
            }

            if (a >= start && a <= end && b >= end) {
                end = b;
            } else {
                result.push_back({ start, end });
                start = a;
                end = b;
            }
        }

        result.push_back({ start, end });

        return result;
    }
};
