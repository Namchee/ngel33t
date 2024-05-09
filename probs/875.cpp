#include <vector>
#include <cmath>
using namespace std;

class Solution {
public:
    int minEatingSpeed(vector<int>& piles, int h) {
        int lo = 0;
        int hi = 0;

        for (int num: piles) {
            hi = max(num, hi);
        }

        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;

            if (mid > 0 && simulate(piles, mid, h)) {
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        }

        return lo + (hi - lo) / 2;
    }

private:
    bool simulate(vector<int>& piles, int speed, int h) {
        int sum = 0;
        for (int pile: piles) {
            sum += (int)ceil((double)pile/(double)speed);
        }

        return sum <= h;
    }
};
