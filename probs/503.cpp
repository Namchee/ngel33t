#include <stack>
#include <vector>
using namespace std;

class Solution {
public:
    vector<int> nextGreaterElements(vector<int>& nums) {
        int n = nums.size();

        vector<int> result(n, -1);
        stack<int> stk;

        for (int i = 2 * n - 1; i >= 0; i--) { // we can index circular array with 2 * n - 1
            while (!stk.empty() && stk.top() <= nums[i % n]) {
                stk.pop();
            }

            if (!stk.empty() && i < n) {
                result[i] = stk.top();
            }

            stk.push(nums[i % n]);
        }

        return result;
    }
};
