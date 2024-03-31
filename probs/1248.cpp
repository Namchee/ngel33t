#include <vector>
using namespace std;

class Solution {
public:
    int numberOfSubarrays(vector<int>& nums, int k) {
        return atMostK(nums, k) - atMostK(nums, k - 1);
    }

private:
    int atMostK(vector<int>& nums, int k) {
        int result = 0;
        int left = 0;
        int curr = 0;

        for (int i = 0; i < nums.size(); i++) {
            int num = nums[i];
            curr += num & 1;
            while (curr > k) {
                curr -= nums[left++] & 1;
            }

            result += (i - left) + 1;
        }

        return result;
    }
};
