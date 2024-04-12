#include <vector>
using namespace std;

class Solution {
public:
    int trap(vector<int>& height) {
        int result = 0;
        int i = 0;
        int j = height.size() - 1;

        int left = height[0];
        int right = height[j];

        while (i < j) {
            if (left <= right) {
                result += left - height[i];
                left = max(left, height[++i]);
            } else {
                result += right - height[j];
                right = max(right, height[--j]);
            }
        }

        return result;
    }
};
