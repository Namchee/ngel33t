#include <vector>
#include <cmath>
using namespace std;

class Solution {
public:
    int minimizedMaximum(int n, vector<int>& quantities) {
        int start = 0;
        int end = 0;

        for (int num: quantities) {
            end = max(end, num);
        }

        int best = 0;

        while (start <= end) {
            int mid = start + (end - start) / 2;
            if (mid && possible(n, mid, quantities)) {
                best = mid;
                end = mid - 1;
            } else {
                start = mid + 1;
            }
        }

        return best;
    }

private:
    bool possible(int n, int amount, vector<int>& quantities) {
        for (int q: quantities) {
            int shop = (int)ceil((double)q / (double)amount);
            n -= shop;
        }

        return n >= 0;
    }
};
