#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int maxSubarrayLength(vector<int>& nums, int k) {
        int result = 1;
        int start = 0;
        int end = 0;

        unordered_map<int, int> freq;

        while (end < nums.size()) {
            freq[nums[end]]++;
            while (freq[nums[end]] > k) {
                freq[nums[start]]--;
                start++;
            }
            result = max(result, end - start + 1);

            end++;
        }

        return result;
    }
};
