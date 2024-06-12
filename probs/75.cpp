#include <vector>
using namespace std;

class Solution {
public:
    void sortColors(vector<int>& nums) {
        int zeroes = 0;
        int ones = 0;
        int twos = 0;

        for (int num: nums) {
            zeroes += num == 0;
            ones += num == 1;
            twos += num == 2;   
        }

        for (int i = 0; i < nums.size(); i++) {
            if (zeroes) {
                nums[i] = 0;
                zeroes--;
            } else if (ones) {
                nums[i] = 1;
                ones--;
            } else {
                nums[i] = 2;
                twos--;
            }
        }
    }
};
