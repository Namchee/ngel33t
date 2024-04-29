#include <vector>
using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int temp = 0;
        for (int num: nums) {
            temp ^= num;
        }

        int count = 0;
        while (temp || k) {
            if ((temp & 1) != (k & 1)) {
                count++;
            }

            temp >>= 1;
            k >>= 1;
        }

        return count;
    }
};
