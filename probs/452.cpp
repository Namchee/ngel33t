#include <vector>;
#include <algorithm>;
using namespace std;

class Solution {
public:
    int findMinArrowShots(vector<vector<int>>& points) {
        sort(points.begin(), points.end());

        int start = points[0][0];
        int end = points[0][1];

        int result = 0;

        for (int i = 1; i < points.size(); i++) {
            int a = points[i][0];
            int b = points[i][1];

            if (a >= start && a <= end && b >= start && b <= end) {
                start = a;
                end = b;

                continue;
            }
            
            if (a >= start && a <= end && b >= end) {
                start = a;
            } else {
                result++;
                start = a;
                end = b;
            }
        }

        return result + 1;
    }
};
