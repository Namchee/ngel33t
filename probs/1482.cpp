#include <vector>
using namespace std;

class Solution {
public:
    int minDays(vector<int>& bloomDay, int m, int k) {
        int l = 0;
        int r = 0;
        for (int bloom: bloomDay) {
            r = max(r, bloom);
        }

        int best = -1;

        while (l <= r) {
            int mid = l + (r - l) / 2;
            if (possible(bloomDay, m, k, mid)) {
                best = mid;
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }

        return best;
    }

private:
    bool possible(vector<int>& bloomDay, int m, int k, int day) {
        int now = 0;
        int count = 0;

        for (int i = 0; i < bloomDay.size(); i++) {
            if (bloomDay[i] <= day) {
                count++;
            } else {
                count = 0;
            }

            if (count == k) {
                now++;
                count = 0;
            }
        }

        return now >= m;
    }
};
