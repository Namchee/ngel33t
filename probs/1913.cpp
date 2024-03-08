#include <vector>;
#include <algorithm>;
using namespace std;

class Solution {
public:
    int maxProductDifference(vector<int>& nums) {
        sort(nums.begin(), nums.end());

        int n = nums.size();
        int bigger = nums[n - 1] * nums[n - 2];
        int smaller = nums[0] * nums[1];

        return bigger - smaller;
    }
};
