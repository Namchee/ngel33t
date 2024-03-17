#include <vector>;
#include <algorithm>;
using namespace std;

class Solution {
public:
    vector<vector<int>> insert(vector<vector<int>>& intervals, vector<int>& newInterval) {
        if (intervals.size() == 0) {
            return { newInterval };
        }

        for (int i = 0; i < intervals.size(); i++) {
            int a = intervals[i][0];
            int b = intervals[i][1];

            bool on_start = newInterval[0] >= a && newInterval[0] <= b;
            bool on_end = newInterval[1] >= a && newInterval[1] <= b;

            bool isBigger = newInterval[0] <= a && newInterval[1] >= b;
            bool isSmaller = newInterval[0] >= a && newInterval[0] <= b && newInterval[1] >= a && newInterval[1] <= b;

            if (isBigger) {
                intervals[i] = newInterval;

                continue;
            }

            if (isSmaller) {
                break;
            }

            if (on_start || on_end) {
                intervals[i][0] = min(intervals[i][0], newInterval[0]);
                intervals[i][1] = max(intervals[i][1], newInterval[1]);
            }
        }

        intervals.push_back(newInterval);

        sort(intervals.begin(), intervals.end());

        vector<vector<int> > result;

        int start = intervals[0][0];
        int end = intervals[0][1];

        for (int i = 1; i < intervals.size(); i++) {
            int a = intervals[i][0];
            int b = intervals[i][1];

            bool on_start = a >= start && a <= end;
            bool on_end = a >= end && b <= end;

            // this new interval is smaller, or same
            if (a >= start && a <= end && b >= start && b <= end) {
                continue;
            }

            if (on_start) {
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
