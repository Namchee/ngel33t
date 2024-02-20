#include <vector>;
using namespace std;

class Solution {
public:
    int maxArea(vector<int>& height) {
        int lo = 0;
        int hi = height.size() - 1;

        int best = -1;

        while (lo < hi) {
            int area = min(height[lo], height[hi]) * (hi - lo);

            best = max(area, best);

            if (height[lo] > height[hi]) {
                hi--;
            } else {
                lo++;
            }
        }

        return best; 
    }
};
