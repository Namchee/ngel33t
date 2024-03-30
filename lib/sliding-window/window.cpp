#include <unordered_map>
#include <vector>
using namespace std;

class Solution {
public:
    /**
     * Variable sized sliding window.
     * 
     * Find with exact (n) = Find with at most (n) - Find with at most (n - 1)
     * 
    */
    int subarraysWithKDistinct(vector<int>& nums, int k) {
        return atMostN(nums, k) - atMostN(nums, k - 1);
    }

private:
    int atMostN(vector<int>& nums, int k) {
        int result = 0;
        
        int start = 0;
        int end = 0;
        
        unordered_map<int, int> freq;
        while (end < nums.size()) {
            freq[nums[end]]++;
            while (freq.size() > k && start <= end) {
                freq[nums[start]]--;

                if (!freq[nums[start]]) {
                    freq.erase(nums[start]);
                }

                start++;
            }

            result += end - start + 1;
            end++;
        }

        return result;
    }
};
