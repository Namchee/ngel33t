#include <vector>;
using namespace std;

class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        int curr = -100000;
        int count = 0;
        int len = nums.size();

        for (int idx = 0; idx < len; idx++) {
            if (nums[idx] != curr) {
                curr = nums[idx];
                count = 0;
            }
            
            count++;
            if (count == 3) {
                int startPoint = idx;

                while (startPoint < nums.size() && nums[startPoint] == curr) {
                    startPoint++;
                }

                if (startPoint < nums.size()) {
                    int orig = nums[startPoint];
                    len -= startPoint - idx;

                    for (int id = idx; startPoint < nums.size(); startPoint++, id++) {
                        nums[id] = nums[startPoint];
                    }

                    curr = orig;
                    count = 1;
                } else {
                    len = idx;
                    break;
                }
            }
        }

        return len;
    }
};
