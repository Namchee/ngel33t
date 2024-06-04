#include <vector>
#include <deque>
using namespace std;

class Solution {
public:
    vector<int> maxSlidingWindow(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> result(n - k + 1);
        deque<int> q;
        int start = 0;
        int end = 0;

        while (end < n) {
            while (!q.empty() && nums[q.back()] < nums[end]) {
                q.pop_back();
            }

            q.push_back(end);

            if (start > q.front()) {
                q.pop_front();
            }

            if (end + 1 >= k) {
                result[start] = nums[q.front()];
                start++;
            }

            end++;
        }

        return result;
    }
};
