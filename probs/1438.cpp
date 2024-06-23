#include <queue>
#include <unordered_map>
#include <vector>
using namespace std;


class Solution {
public:
    int longestSubarray(vector<int>& nums, int limit) {
        int start = 0;
        int end = 0;

        int best = 0;

        priority_queue<int> maxi;
        priority_queue<int, vector<int>, greater<int> > mini;
        unordered_map<int, int> freq;

        while (end < nums.size()) {
            int num = nums[end];

            freq[num]++;
            mini.push(num);
            maxi.push(num);

            while (maxi.top() - mini.top() > limit) {
                freq[nums[start]]--;

                while (freq[mini.top()] == 0) {
                    mini.pop();
                }

                while (freq[maxi.top()] == 0) {
                    maxi.pop();
                }

                start++;
            }

            best = max(best, end - start + 1);
            end++;
        }

        return best;
    }
};
