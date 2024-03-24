#include <vector>
using namespace std;

class Solution {
public:
    int findDuplicate(vector<int>& nums) {
        int tortoise = nums[0];
        int hare = nums[0];

        while (true) {
            tortoise = nums[tortoise];
            hare = nums[nums[hare]];

            if (tortoise == hare) {
                break;
            }
        }

        hare = nums[0];

        while (tortoise != hare) {
            tortoise = nums[tortoise];
            hare = nums[hare];
        }

        return tortoise;
    }
};
