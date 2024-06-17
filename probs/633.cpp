#include <cmath>
using namespace std;

class Solution {
public:
    bool judgeSquareSum(int c) {
        long long start = 0;
        long long end = ceil(sqrt(c));

        while (start <= end) {
            long long sum = start * start + end * end;
            if (sum == c) {
                return true;
            }

            if (sum < c) {
                start++;
            } else {
                end--;
            }
        }

        return false;
    }
};
