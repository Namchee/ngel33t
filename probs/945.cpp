#include <vector>
#include <algorithm>
using namespace std;


class Solution {
public:
    int minIncrementForUnique(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        
        int n = nums.size();

        int sum = 0;
        int next = 0;

        for (int num: nums) {
            next = max(num, next);
            sum += next - num;
            next++;
        }

        return sum;
    }
};
